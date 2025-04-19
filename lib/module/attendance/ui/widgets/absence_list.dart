import 'package:crewmeister_test/common/config/enums.dart';
import 'package:crewmeister_test/module/attendance/ui/widgets/absence_item.dart';
import 'package:flutter/material.dart';

class AbsenceList extends StatelessWidget {
  final List<String> users;
  const AbsenceList({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          return AbsenceItem(
            name: 'Murtaza Agaz',
            period: 'Half Day',
            leaveStatus: LeaveStatus.requested,
            date: 'Wed, 16 April',
            absenceType: 'Casual',
            membersNote: 'Please provide confirmation',
            admittersNote: 'Ok I will check',
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 20,
          );
        },
        itemCount: 6,
      ),
    );
  }
}
