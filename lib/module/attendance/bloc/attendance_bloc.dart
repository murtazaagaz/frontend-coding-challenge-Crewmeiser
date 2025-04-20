import 'package:crewmeister_test/common/config/data_state.dart';
import 'package:crewmeister_test/common/services/permission_service.dart';
import 'package:crewmeister_test/models/absence_with_member_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crewmeister_test/module/attendance/bloc/attendance_event.dart';
import 'package:crewmeister_test/module/attendance/bloc/attendance_state.dart';
import 'package:crewmeister_test/module/attendance/usecase/attendance_usecase.dart';
import 'package:crewmeister_test/models/filter_model.dart';
import 'dart:io';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceUsecase _attendanceUsecase;

  AttendanceBloc(this._attendanceUsecase) : super(AttendanceInitial()) {
    on<FetchAbsenceWithMembers>(_onFetchAbsenceWithMembers);
    on<SelectLeaveType>(_onSelectLeaveType);
    on<SelectStartDate>(_onSelectStartDate);
    on<SelectEndDate>(_onSelectEndDate);
    on<ApplyFilters>(_onApplyFilters);
    on<ClearFilters>(_onClearFilters);
    on<FetchAllLeavesTypes>(_fetchLeaveTypes);
    on<ExportAbsencesToIcal>(_onExportAbsencesToIcal);
  }

  Future<void> _fetchLeaveTypes(event, Emitter emit) async {
    try {
      final result = await _attendanceUsecase.getAllLeaveTypes();
      List<String> leaveTypes = [];
      if (result is DataSuccess) {
        leaveTypes = result.body;
      }
      emit(state.copyWith(leaveTypes: leaveTypes));
    } catch (e) {
      emit(state.copyWith(leaveTypes: []));
    }
  }

  Future<void> _onFetchAbsenceWithMembers(
    FetchAbsenceWithMembers event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(AttendanceLoading(
      absences: state.absences,
      leaveTypes: state.leaveTypes,
      filter: state.filter,
      hasReachedMax: state.hasReachedMax,
      selectedType: state.selectedType,
      startDate: state.startDate,
      endDate: state.endDate,
    ));
    await Future.delayed(const Duration(milliseconds: 1200));

    try {
      final result = await _attendanceUsecase.getAbsenceWithMembers(
        event.page,
        filter: event.filter,
      );

      if (result is DataFailed) {
        emit(AttendanceError(
          message: result.error ?? 'something went wrong',
          absences: state.absences,
          leaveTypes: state.leaveTypes,
          filter: state.filter,
          hasReachedMax: state.hasReachedMax,
          selectedType: state.selectedType,
          startDate: state.startDate,
          endDate: state.endDate,
        ));
        return;
      }
      final absences = result.body;
      final hasReachedMax = absences.length < 10;
      final newAbsences = event.page == 1 ? absences : <AbsenceWithMemberModel>[...state.absences, ...absences];

      emit(AttendanceSuccess(
        absences: newAbsences,
        leaveTypes: state.leaveTypes,
        filter: event.filter,
        hasReachedMax: hasReachedMax,
        selectedType: state.selectedType,
        startDate: state.startDate,
        endDate: state.endDate,
      ));
    } catch (e) {
      emit(AttendanceError(
        message: e.toString(),
        absences: state.absences,
        leaveTypes: state.leaveTypes,
        filter: state.filter,
        hasReachedMax: state.hasReachedMax,
        selectedType: state.selectedType,
        startDate: state.startDate,
        endDate: state.endDate,
      ));
    }
  }

  void _onSelectLeaveType(SelectLeaveType event, Emitter<AttendanceState> emit) {
    emit(AttendanceSuccess(
      absences: state.absences,
      leaveTypes: state.leaveTypes,
      filter: state.filter,
      hasReachedMax: state.hasReachedMax,
      selectedType: event.type,
      startDate: state.startDate,
      endDate: state.endDate,
    ));
  }

  void _onSelectStartDate(SelectStartDate event, Emitter<AttendanceState> emit) {
    emit(AttendanceSuccess(
      absences: state.absences,
      leaveTypes: state.leaveTypes,
      filter: state.filter,
      hasReachedMax: state.hasReachedMax,
      selectedType: state.selectedType,
      startDate: event.date,
      endDate: state.endDate,
    ));
  }

  void _onSelectEndDate(SelectEndDate event, Emitter<AttendanceState> emit) {
    emit(AttendanceSuccess(
      absences: state.absences,
      leaveTypes: state.leaveTypes,
      filter: state.filter,
      hasReachedMax: state.hasReachedMax,
      selectedType: state.selectedType,
      startDate: state.startDate,
      endDate: event.date,
    ));
  }

  void _onApplyFilters(ApplyFilters event, Emitter<AttendanceState> emit) {
    final filter = FilterModel(
      type: state.selectedType,
      startDate: state.startDate,
      endDate: state.endDate,
    );

    add(FetchAbsenceWithMembers(
      page: 1,
      filter: filter,
    ));
  }

  void _onClearFilters(ClearFilters event, Emitter<AttendanceState> emit) {
    emit(AttendanceSuccess(
      absences: state.absences,
      leaveTypes: state.leaveTypes,
      filter: const FilterModel(),
      hasReachedMax: state.hasReachedMax,
      selectedType: null,
      startDate: null,
      endDate: null,
    ));
  }

  Future<void> _onExportAbsencesToIcal(
    ExportAbsencesToIcal event,
    Emitter<AttendanceState> emit,
  ) async {
    try {
      emit(AttendanceExporting(
        absences: state.absences,
        leaveTypes: state.leaveTypes,
        filter: state.filter,
        hasReachedMax: state.hasReachedMax,
        selectedType: state.selectedType,
        startDate: state.startDate,
        endDate: state.endDate,
      ));

      final hasPermissions = await PermissionService.hasRequiredPermissions();
      if (!hasPermissions) {
        final storagePermission = await PermissionService.requestStoragePermission();
        final downloadsPermission = await PermissionService.requestDownloadsPermission();

        if (!storagePermission || !downloadsPermission) {
          emit(AttendanceExportError(
            absences: state.absences,
            leaveTypes: state.leaveTypes,
            filter: state.filter,
            hasReachedMax: state.hasReachedMax,
            selectedType: state.selectedType,
            startDate: state.startDate,
            endDate: state.endDate,
            exportError: 'Storage permissions are required to export the file',
          ));
          return;
        }
      }

      final file = await _attendanceUsecase.convertToICalendarFile(event.absences);

      if (kIsWeb) {
        return;
      }
      if (Platform.isAndroid) {
        final downloadsDir = Directory('/storage/emulated/0/Download');
        if (await downloadsDir.exists()) {
          final newFile = File('${downloadsDir.path}/absences.ics');

          if (file != null) {
            file.copy(newFile.path);
          }
        }
      }

      emit(AttendanceExportSuccess(
        absences: state.absences,
        leaveTypes: state.leaveTypes,
        filter: state.filter,
        hasReachedMax: state.hasReachedMax,
        selectedType: state.selectedType,
        startDate: state.startDate,
        endDate: state.endDate,
      ));
    } catch (e) {
      emit(AttendanceExportError(
        absences: state.absences,
        leaveTypes: state.leaveTypes,
        filter: state.filter,
        hasReachedMax: state.hasReachedMax,
        selectedType: state.selectedType,
        startDate: state.startDate,
        endDate: state.endDate,
        exportError: e.toString(),
      ));
    }
  }
}
