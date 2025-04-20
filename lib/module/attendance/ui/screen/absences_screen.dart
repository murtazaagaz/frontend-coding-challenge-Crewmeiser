import 'package:crewmeister_test/common/constants/string_constants.dart';
import 'package:crewmeister_test/common/utils/style/app_text_styles.dart';
import 'package:crewmeister_test/common/utils/theme/app_colors.dart';
import 'package:crewmeister_test/module/attendance/bloc/attendance_bloc.dart';
import 'package:crewmeister_test/module/attendance/bloc/attendance_event.dart';
import 'package:crewmeister_test/module/attendance/bloc/attendance_state.dart';
import 'package:crewmeister_test/models/filter_model.dart';

import 'package:crewmeister_test/module/attendance/ui/widgets/absence_list.dart';
import 'package:crewmeister_test/module/attendance/ui/widgets/filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsencesScreen extends StatefulWidget {
  const AbsencesScreen({super.key});

  @override
  State<AbsencesScreen> createState() => _AbsencesScreenState();
}

class _AbsencesScreenState extends State<AbsencesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AttendanceBloc>().add(
          const FetchAbsenceWithMembers(
            page: 1,
            filter: FilterModel(),
          ),
        );
    context.read<AttendanceBloc>().add(
          FetchAllLeavesTypes(),
        );
  }

  void _showFilterBottomSheet(BuildContext context) {
    final bloc = context.read<AttendanceBloc>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.colors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => FilterBottomSheet(bloc: bloc),
    );
  }

  void _handleExport(BuildContext context) {
    final state = context.read<AttendanceBloc>().state;
    if (state.absences.isNotEmpty) {
      context.read<AttendanceBloc>().add(ExportAbsencesToIcal(state.absences));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colors.background,
        surfaceTintColor: AppColors.colors.background,
        actions: [
          IconButton(
            onPressed: () => _handleExport(context),
            icon: BlocBuilder<AttendanceBloc, AttendanceState>(
              builder: (context, state) {
                return const Icon(Icons.download);
              },
            ),
          ),
          IconButton(
            onPressed: () => _showFilterBottomSheet(context),
            icon: const Icon(Icons.filter_alt_rounded),
          ),
        ],
      ),
      backgroundColor: AppColors.colors.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth > 600 ? 600.0 : constraints.maxWidth;
          return Center(
            child: Container(
              width: maxWidth,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    StringConstants.leaves,
                    style: AppTextStyles.title,
                  ),
                  Expanded(
                    child: BlocConsumer<AttendanceBloc, AttendanceState>(
                      listener: (context, state) {
                        if (state.exportError != null) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.exportError!),
                                backgroundColor: Colors.red,
                              ),
                            );
                          });
                        }

                        if (state is AttendanceExportSuccess) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('File exported successfully'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          });
                        }
                      },
                      builder: (context, state) {
                        if (state is AttendanceLoading && state.absences.isEmpty) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (state is AttendanceError) {
                          return Center(child: Text(state.message));
                        }

                        if (state.absences.isEmpty) {
                          return const Center(child: Text('No Records Found'));
                        }

                        return AbsenceList(
                          absences: state.absences,
                          onLoadMore: () {
                            if (!state.hasReachedMax) {
                              context.read<AttendanceBloc>().add(
                                    FetchAbsenceWithMembers(
                                      page: (state.absences.length ~/ 10) + 1,
                                      filter: state.filter,
                                    ),
                                  );
                            }
                          },
                          isLoadingMore: state is AttendanceLoading,
                          hasReachedMax: state.hasReachedMax,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
