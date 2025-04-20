import 'package:crewmeister_test/common/config/enums.dart';
import 'package:crewmeister_test/common/constants/string_constants.dart';
import 'package:crewmeister_test/common/utils/style/app_text_styles.dart';
import 'package:crewmeister_test/common/utils/theme/app_colors.dart';
import 'package:crewmeister_test/module/attendance/ui/widgets/app_card_wrapper.dart';
import 'package:crewmeister_test/module/attendance/ui/widgets/circular_container.dart';
import 'package:crewmeister_test/module/attendance/ui/widgets/text_info.dart';
import 'package:flutter/material.dart';

class AbsenceItem extends StatelessWidget {
  final String name;
  final String period;
  final LeaveStatus leaveStatus;
  final String date;
  final String absenceType;
  final String membersNote;
  final String admittersNote;
  const AbsenceItem({
    super.key,
    required this.name,
    required this.period,
    required this.leaveStatus,
    required this.date,
    required this.absenceType,
    required this.membersNote,
    required this.admittersNote,
  });

  Widget _buildLeaveStatus() {
    Color color;
    Color textColor;
    String status;
    switch (leaveStatus) {
      case LeaveStatus.requested:
        color = AppColors.colors.awaitingColor;
        textColor = AppColors.colors.awaitingTextColor;
        status = leaveStatus.name.toUpperCase();
        break;
      case LeaveStatus.confirmed:
        color = AppColors.colors.approvedColor;
        textColor = AppColors.colors.approvedTextColor;
        status = leaveStatus.name.toUpperCase();
        break;

      case LeaveStatus.rejected:
        color = AppColors.colors.declinedColor;
        textColor = AppColors.colors.declinedTextColor;

        status = leaveStatus.name.toUpperCase();
        break;
     
    }

    return CircularContainer(
      height: 30,
      width: 100,
      radius: 10,
      bgColor: color,
      borderColor: AppColors.colors.cardBackground,
      child: Text(
        status,
        style: AppTextStyles.mediumBold.copyWith(
          color: textColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppCardWrapper(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              CircularContainer(
                bgColor: AppColors.colors.background,
                borderColor: AppColors.colors.primaryColor,
                child: Icon(
                  Icons.person,
                  color: AppColors.colors.primaryColor,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                name,
                style: AppTextStyles.medium.copyWith(
                  color: AppColors.colors.titleText,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$period ${StringConstants.application}',
                style: AppTextStyles.headings,
              ),
              _buildLeaveStatus(),
            ],
          ),
          Text(
            date,
            style: AppTextStyles.headingsBold,
          ),
          Text(
            absenceType,
            style: AppTextStyles.medium,
          ),
          SizedBox(
            height: 8,
          ),
          TextInfo(title: StringConstants.memberNote, value: membersNote),
          SizedBox(
            height: 8,
          ),
          TextInfo(title: StringConstants.admitterNote, value: admittersNote),
        ],
      ),
    ));
  }
}
