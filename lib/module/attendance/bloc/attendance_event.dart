import 'package:crewmeister_test/models/filter_model.dart';
import 'package:crewmeister_test/models/absence_with_member_model.dart';
import 'package:equatable/equatable.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object?> get props => [];
}

class FetchAbsenceWithMembers extends AttendanceEvent {
  final int page;
  final FilterModel filter;

  const FetchAbsenceWithMembers({
    required this.page,
    required this.filter,
  });

  @override
  List<Object?> get props => [page, filter];
}

class FetchAllLeavesTypes extends AttendanceEvent {}

class SelectLeaveType extends AttendanceEvent {
  final String? type;

  const SelectLeaveType(this.type);

  @override
  List<Object?> get props => [type];
}

class SelectStartDate extends AttendanceEvent {
  final DateTime? date;

  const SelectStartDate(this.date);

  @override
  List<Object?> get props => [date];
}

class SelectEndDate extends AttendanceEvent {
  final DateTime? date;

  const SelectEndDate(this.date);

  @override
  List<Object?> get props => [date];
}

class ApplyFilters extends AttendanceEvent {}

class ClearFilters extends AttendanceEvent {}

class ExportAbsencesToIcal extends AttendanceEvent {
  final List<AbsenceWithMemberModel> absences;

  const ExportAbsencesToIcal(this.absences);

  @override
  List<Object?> get props => [absences];
}
