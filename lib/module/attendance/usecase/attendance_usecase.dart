import 'package:crewmeister_test/api/api.dart';
import 'package:crewmeister_test/common/config/data_state.dart';
import 'package:crewmeister_test/common/config/json_parsor.dart';
import 'package:crewmeister_test/models/absence_model.dart';
import 'package:crewmeister_test/models/absence_with_member_model.dart';
import 'package:crewmeister_test/models/filter_model.dart';
import 'package:crewmeister_test/models/member_model.dart';

class AttendanceUsecase {
  final API _api = API();

  List<AbsenceModel> _absences = [];
  List<MemberModel> _members = [];

  Future<DataState> fetchAllAbsence() async {
    try {
      final response = await _api.absences();
      final DataState dataState = JsonParser.parseJson(response);

      if (dataState is DataSuccess) {
        final list = dataState.body.map((e) => AbsenceModel.fromMap(e)).toList();
        _absences = List<AbsenceModel>.from(list);

        return DataSuccess(_absences);
      }
      return dataState;
    } catch (e) {
      return DataFailed('something went wrong');
    }
  }

  Future<DataState> fetchAllMembers() async {
    try {
      final response = await _api.members();
      final DataState dataState = JsonParser.parseJson(response);

      if (dataState is DataSuccess) {
        final list = dataState.body.map((e) => MemberModel.fromMap(e)).toList();
        _members = List<MemberModel>.from(list);

        return DataSuccess(_members);
      }
      return dataState;
    } catch (e) {
      return DataFailed('something went wrong');
    }
  }

  Future<List<AbsenceWithMemberModel>> getAbsenceWithMembers(int page, {required FilterModel filter}) async {
    if (_absences.isEmpty) {
      await fetchAllAbsence();
    }
    if (_members.isEmpty) {
      await fetchAllMembers();
    }

     List<AbsenceModel> filteredAbsences = _absences.where((absence) {
    final matchesType = filter.type == null || absence.type == filter.type;
    final matchesStartDate = filter.startDate == null || absence.startDate.isAfter(filter.startDate!) || absence.startDate.isAtSameMomentAs(filter.startDate!);
    final matchesEndDate = filter.endDate == null || absence.endDate.isBefore(filter.endDate!) || absence.endDate.isAtSameMomentAs(filter.endDate!);
    return matchesType && matchesStartDate && matchesEndDate;
  }).toList();


    int begin = (page - 1) * 10;
    int end = begin + 10;

    if (begin >= _absences.length) {
      return [];
    }
    if (end > _absences.length) {
      end = _absences.length;
    }

    List<AbsenceWithMemberModel> absenceWithMembers = [];
    for (int i = begin; i >= end; i++) {
      final absence = _absences[i];
      final member = _members.firstWhere((user) => user.userId == absence.userId, orElse: () => MemberModel.fromMap({}));

      absenceWithMembers.add(AbsenceWithMemberModel(absence: absence, member: member));
    }
    return absenceWithMembers;
  }

}
