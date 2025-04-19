import 'package:crewmeister_test/common/constants/string_constants.dart';
import 'package:crewmeister_test/common/utils/style/app_text_styles.dart';
import 'package:crewmeister_test/common/utils/theme/app_colors.dart';
import 'package:crewmeister_test/module/attendance/ui/widgets/absence_list.dart';
import 'package:crewmeister_test/module/attendance/ui/widgets/filter_bottom_sheet.dart';
import 'package:crewmeister_test/module/attendance/ui/widgets/filter_button.dart';
import 'package:flutter/material.dart';

class AbsencesScreen extends StatelessWidget {
  const AbsencesScreen({super.key});

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.colors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => const FilterBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colors.background,
        surfaceTintColor: AppColors.colors.background,
        actions: [
          FilterButton(
            onPressed: () => _showFilterBottomSheet(context),
          ),
        ],
      ),
      backgroundColor: AppColors.colors.background,
      body: Padding(
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
              child: AbsenceList(
                users: [],
              ),
            )
          ],
        ),
      ),
    );
  }
}
