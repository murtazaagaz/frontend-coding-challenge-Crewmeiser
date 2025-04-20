import 'package:crewmeister_test/common/constants/string_constants.dart';
import 'package:crewmeister_test/common/utils/style/app_text_styles.dart';
import 'package:crewmeister_test/common/utils/theme/app_colors.dart';
import 'package:crewmeister_test/module/attendance/bloc/attendance_bloc.dart';
import 'package:crewmeister_test/module/attendance/bloc/attendance_event.dart';
import 'package:crewmeister_test/models/filter_model.dart';
import 'package:crewmeister_test/module/attendance/bloc/attendance_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FilterBottomSheet extends StatelessWidget {
  final AttendanceBloc bloc;
  const FilterBottomSheet({super.key, required this.bloc});

  Future<void> _pickDate(BuildContext context, {required bool isStart}) async {
    final state = bloc.state;
    final initialDate = isStart ? state.startDate ?? DateTime.now() : state.endDate ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      if (isStart) {
        bloc.add(SelectStartDate(picked));
      } else {
        bloc.add(SelectEndDate(picked));
      }
    }
  }

  void _applyFilters(BuildContext context) {
    bloc.add(ApplyFilters());
    Navigator.pop(context);
  }

  void _clearFilters(BuildContext context) {
    bloc.add(ClearFilters());
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy');

    return BlocBuilder<AttendanceBloc, AttendanceState>(
      bloc: bloc,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Apply Filters', style: AppTextStyles.headingsBold),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Type', style: AppTextStyles.headingsSemiBold),
              ),
              const SizedBox(height: 8),
              if (state.leaveTypes.isEmpty)
                const Center(child: CircularProgressIndicator())
              else
                Wrap(
                  spacing: 8,
                  children: state.leaveTypes.map((type) {
                    final selected = state.selectedType == type;
                    return FilterChip(
                      checkmarkColor: AppColors.colors.background,
                      label: Text(
                        type,
                        style: AppTextStyles.medium.copyWith(
                          color: selected ? AppColors.colors.background : AppColors.colors.titleText,
                        ),
                      ),
                      selected: selected,
                      selectedColor: AppColors.colors.primaryColor,
                      backgroundColor: AppColors.colors.background,
                      onSelected: (bool value) {
                        bloc.add(SelectLeaveType(value ? type : null));
                      },
                    );
                  }).toList(),
                ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Date Range', style: AppTextStyles.headingsSemiBold),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _pickDate(context, isStart: true),
                      child: Text(
                        state.startDate != null ? dateFormat.format(state.startDate!) : 'Start Date',
                        style: AppTextStyles.mediumBold.copyWith(
                          color: AppColors.colors.titleText,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _pickDate(context, isStart: false),
                      child: Text(
                        state.endDate != null ? dateFormat.format(state.endDate!) : 'End Date',
                        style: AppTextStyles.mediumBold.copyWith(
                          color: AppColors.colors.titleText,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => _clearFilters(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.colors.cardBackground,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: AppColors.colors.declinedTextColor),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: Text(
                      StringConstants.clearFilters,
                      style: AppTextStyles.headingsBold.copyWith(color: AppColors.colors.declinedTextColor),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _applyFilters(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.colors.primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: Text(
                      StringConstants.applyFilters,
                      style: AppTextStyles.headingsBold.copyWith(color: AppColors.colors.background),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
