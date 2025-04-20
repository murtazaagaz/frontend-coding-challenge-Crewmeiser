import 'package:crewmeister_test/models/absence_model.dart';
import 'package:crewmeister_test/models/member_model.dart';

class AbsenceWithMemberModel {
  final AbsenceModel absence;
  final MemberModel member;

  AbsenceWithMemberModel({
    required this.absence,
    required this.member,
  });
}
