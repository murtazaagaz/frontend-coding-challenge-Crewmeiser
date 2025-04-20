import 'package:flutter_test/flutter_test.dart';
import 'package:crewmeister_test/module/attendance/usecase/attendance_usecase.dart';
import 'package:crewmeister_test/common/config/data_state.dart';
import 'package:crewmeister_test/models/absence_model.dart';
import 'package:crewmeister_test/models/member_model.dart';
import 'package:crewmeister_test/models/absence_with_member_model.dart';
import 'package:crewmeister_test/models/filter_model.dart';
import 'package:crewmeister_test/api/api.dart';

class MockAPI extends API {
  @override
  Future<dynamic> absences() async {
    return {
      "message": "Success",
      "payload": [
        {
          "admitterId": null,
          "admitterNote": "",
          "confirmedAt": "2020-12-12T18:03:55.000+01:00",
          "createdAt": "2020-12-12T14:17:01.000+01:00",
          "crewId": 352,
          "endDate": "2021-01-13",
          "id": 2351,
          "memberNote": "",
          "rejectedAt": null,
          "startDate": "2021-01-13",
          "type": "sickness",
          "userId": 2664,
        }
      ]
    };
  }

  @override
  Future<dynamic> members() async {
    return {
      "message": "Success",
      "payload": [
        {
          "crewId": 352,
          "id": 2650,
          "image": "https://loremflickr.com/300/400",
          "name": "Mike",
          "userId": 2664,
        }
      ]
    };
  }
}

void main() {
  group('AttendanceUsecase Tests', () {
    late AttendanceUsecase attendanceUsecase;
    late MockAPI mockAPI;

    setUp(() {
      mockAPI = MockAPI();
      attendanceUsecase = AttendanceUsecase(api: mockAPI);
    });

    test('Test fetching absences', () async {
      final result = await attendanceUsecase.fetchAllAbsence();

      expect(result, isA<DataSuccess>());
      expect((result as DataSuccess).body, isA<List<AbsenceModel>>());
      expect((result.body as List<AbsenceModel>).isNotEmpty, isTrue);
    });

    test('Test fetching members', () async {
      final result = await attendanceUsecase.fetchAllMembers();

      expect(result, isA<DataSuccess>());
      expect((result as DataSuccess).body, isA<List<MemberModel>>());
      expect((result.body as List<MemberModel>).isNotEmpty, isTrue);
    });

    test('Test getting absences with members', () async {
      const filter = FilterModel();
      final result = await attendanceUsecase.getAbsenceWithMembers(1, filter: filter);

      expect(result, isA<DataSuccess>());
      expect((result as DataSuccess).body, isA<List<AbsenceWithMemberModel>>());
    });

    test('Test creation of ICS file', () async {
      const filter = FilterModel();
      final absencesResult = await attendanceUsecase.getAbsenceWithMembers(1, filter: filter);

      if (absencesResult is DataSuccess) {
        final absencesWithMembers = absencesResult.body as List<AbsenceWithMemberModel>;
        final result = await attendanceUsecase.convertToICalendarFile(absencesWithMembers);

        expect(result, isNull);
      } else {
        fail('Failed to get absences with members');
      }
    });
  });
}
