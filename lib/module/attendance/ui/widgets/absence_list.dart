import 'package:crewmeister_test/common/config/enums.dart';
import 'package:crewmeister_test/common/widgets/load_more_animation.dart';
import 'package:crewmeister_test/models/absence_with_member_model.dart';
import 'package:crewmeister_test/module/attendance/ui/widgets/absence_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AbsenceList extends StatelessWidget {
  final List<AbsenceWithMemberModel> absences;
  final VoidCallback onLoadMore;
  final bool isLoadingMore;
  final bool hasReachedMax;

  const AbsenceList({
    super.key,
    required this.absences,
    required this.onLoadMore,
    required this.isLoadingMore,
    required this.hasReachedMax,
  });

  LeaveStatus _getLeaveStatus(AbsenceWithMemberModel absence) {
    if (absence.absence.confirmedAt != null) {
      return LeaveStatus.confirmed;
    } else if (absence.absence.rejectedAt != null) {
      return LeaveStatus.rejected;
    }
    return LeaveStatus.requested;
  }

  String _getPeriod(AbsenceWithMemberModel absence) {
    final startDate = absence.absence.startDate;
    final endDate = absence.absence.endDate;

    if (startDate.isAtSameMomentAs(endDate)) {
      return 'Half Day';
    }
    return '${endDate.difference(startDate).inDays} Days';
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification && notification.metrics.pixels == notification.metrics.maxScrollExtent && !isLoadingMore && !hasReachedMax) {
          onLoadMore();
        }
        return true;
      },
      child: ListView.separated(
        itemBuilder: (context, index) {
          if (index == absences.length) {
            return const LoadMoreAnimation();
          }

          final absence = absences[index];
          return AbsenceItem(
            name: absence.member.name,
            period: _getPeriod(absence),
            leaveStatus: _getLeaveStatus(absence),
            date: DateFormat('dd MMMM yy').format(absence.absence.startDate),
            absenceType: absence.absence.type,
            membersNote: absence.absence.memberNote,
            admittersNote: absence.absence.admitterNote,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 20);
        },
        itemCount: absences.length + (hasReachedMax ? 0 : 1),
      ),
    );
  }
}
