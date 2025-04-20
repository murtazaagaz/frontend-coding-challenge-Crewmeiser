import 'dart:async';
import 'dart:convert';
import 'package:universal_html/html.dart' as html;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'package:crewmeister_test/api/api.dart';
import 'package:crewmeister_test/common/config/data_state.dart';
import 'package:crewmeister_test/common/config/json_parsor.dart';
import 'package:crewmeister_test/models/absence_model.dart';
import 'package:crewmeister_test/models/absence_with_member_model.dart';
import 'package:crewmeister_test/models/filter_model.dart';
import 'package:crewmeister_test/models/member_model.dart';

class AttendanceUsecase {
  final API _api;

  AttendanceUsecase({API? api}) : _api = api ?? API();

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
      return const DataFailed('something went wrong');
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
      return const DataFailed('something went wrong');
    }
  }

  Future<DataState> getAbsenceWithMembers(int page, {required FilterModel filter}) async {
    try {
      if (_absences.isEmpty) {
        final result = await fetchAllAbsence();
        if (result is DataFailed) {
          return result;
        }
      }
      if (_members.isEmpty) {
        final result = await fetchAllMembers();
        if (result is DataFailed) {
          return result;
        }
      }

      List<AbsenceModel> filteredAbsences = _absences.where((absence) {
        final matchesType = filter.type == null || absence.type == filter.type;
        final matchesStartDate = filter.startDate == null || absence.startDate.isAfter(filter.startDate!) || absence.startDate.isAtSameMomentAs(filter.startDate!);
        final matchesEndDate = filter.endDate == null || absence.endDate.isBefore(filter.endDate!) || absence.endDate.isAtSameMomentAs(filter.endDate!);
        return matchesType && matchesStartDate && matchesEndDate;
      }).toList();

      int begin = (page - 1) * 10;
      int end = begin + 10;

      if (begin >= filteredAbsences.length - 1) {
        return const DataSuccess(<AbsenceWithMemberModel>[]);
      }
      if (end > filteredAbsences.length - 1) {
        end = filteredAbsences.length - 1;
      }

      List<AbsenceWithMemberModel> absenceWithMembers = [];
      for (int i = begin; i <= end; i++) {
        final absence = filteredAbsences[i];
        final member = _members.firstWhere((user) => user.userId == absence.userId, orElse: () => MemberModel.fromMap({}));

        absenceWithMembers.add(AbsenceWithMemberModel(absence: absence, member: member));
      }

      return DataSuccess(absenceWithMembers);
    } catch (e) {
      return const DataFailed('Something Went Wrong');
    }
  }

  Future<DataState> getAllLeaveTypes() async {
    if (_absences.isEmpty) {
      final result = await fetchAllAbsence();
      if (result is DataFailed) {
        return result;
      }
    }
    final Set<String> leaves = {};
    for (AbsenceModel absence in _absences) {
      leaves.add(absence.type);
    }
    return DataSuccess(leaves.toList());
  }

  FutureOr<File?> convertToICalendarFile(List<AbsenceWithMemberModel> absences) async {
    final buffer = StringBuffer();

    void writeLine(String text) => buffer.write('$text\r\n');

    final dateFormatter = DateFormat("yyyyMMdd'T'HHmmss'Z'");

    writeLine('BEGIN:VCALENDAR');
    writeLine('VERSION:2.0');
    writeLine('PRODID:-//crewmeister//AbsenceCalendar//EN');
    writeLine('CALSCALE:GREGORIAN');

    for (final item in absences) {
      final absence = item.absence;
      final member = item.member;

      writeLine('BEGIN:VEVENT');
      writeLine('UID:${absence.id}@crewmeister.com');
      writeLine('DTSTAMP:${dateFormatter.format(DateTime.now().toUtc())}');
      writeLine('DTSTART:${dateFormatter.format(absence.startDate.toUtc())}');
      writeLine('DTEND:${dateFormatter.format(absence.endDate.toUtc())}');
      writeLine('SUMMARY:${absence.type} - ${member.name}');
      writeLine('DESCRIPTION:Member Note: ${absence.memberNote}\\nAdmitter Note: ${absence.admitterNote}');
      writeLine('END:VEVENT');
    }

    writeLine('END:VCALENDAR');

    final icsContent = buffer.toString();

    if (kIsWeb) {
      // Web-specific download
      final bytes = utf8.encode(icsContent);
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'absences.ics')
        ..click();
      html.Url.revokeObjectUrl(url);
      return null;
    } else {
      try {
        final directory = await getApplicationDocumentsDirectory();
        final path = '${directory.path}/absences.ics';
        final file = File(path);
        await file.writeAsString(icsContent);
        return file;
      } catch (e) {
        print('Error saving file: $e');
        return null;
      }
    }
  }
}
