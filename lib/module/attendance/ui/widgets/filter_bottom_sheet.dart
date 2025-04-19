import 'package:crewmeister_test/common/utils/style/app_text_styles.dart';
import 'package:crewmeister_test/common/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final List<String> filterTypes = ['Remote', 'On-site', 'Hybrid'];
  final Set<String> selectedTypes = {};

  DateTime? startDate;
  DateTime? endDate;

  Future<void> _pickDate({
    required bool isStart,
  }) async {
    final initialDate = isStart ? startDate ?? DateTime.now() : endDate ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy');

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
          Wrap(
            spacing: 8,
            children: filterTypes.map((type) {
              final selected = selectedTypes.contains(type);
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
                  setState(() {
                    if (value) {
                      selectedTypes.add(type);
                    } else {
                      selectedTypes.remove(type);
                    }
                  });
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
                  onPressed: () => _pickDate(isStart: true),
                  child: Text(
                    startDate != null ? dateFormat.format(startDate!) : 'Start Date',
                    style: AppTextStyles.mediumBold.copyWith(
                      color: AppColors.colors.titleText,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _pickDate(isStart: false),
                  child: Text(
                    endDate != null ? dateFormat.format(endDate!) : 'End Date',
                    style: AppTextStyles.mediumBold.copyWith(
                      color: AppColors.colors.titleText,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              // Apply your filter logic here
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.colors.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            child: Text(
              'Apply Filters',
              style: AppTextStyles.headingsBold.copyWith(color: AppColors.colors.background),
            ),
          ),
        ],
      ),
    );
  }
}
