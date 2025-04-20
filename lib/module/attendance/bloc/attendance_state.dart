import 'package:crewmeister_test/models/absence_with_member_model.dart';
import 'package:crewmeister_test/models/filter_model.dart';
import 'package:equatable/equatable.dart';
abstract class AttendanceState extends Equatable {
  final List<AbsenceWithMemberModel> absences;
  final List<String> leaveTypes;
  final FilterModel filter;
  final bool hasReachedMax;
  final String? selectedType;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? exportError;
  final bool isExporting;

  const AttendanceState({
    this.absences = const [],
    this.leaveTypes = const [],
    this.filter = const FilterModel(),
    this.hasReachedMax = false,
    this.selectedType,
    this.startDate,
    this.endDate,
    this.exportError,
    this.isExporting = false,
  });

  AttendanceState copyWith({
    List<AbsenceWithMemberModel>? absences,
    List<String>? leaveTypes,
    FilterModel? filter,
    bool? hasReachedMax,
    String? selectedType,
    DateTime? startDate,
    DateTime? endDate,
    String? exportError,
    bool? isExporting,
  });

  @override
  List<Object?> get props => [
        absences,
        leaveTypes,
        filter,
        hasReachedMax,
        selectedType,
        startDate,
        endDate,
        exportError,
        isExporting,
      ];
}

class AttendanceInitial extends AttendanceState {
  const AttendanceInitial();

  @override
  AttendanceState copyWith({
    List<AbsenceWithMemberModel>? absences,
    List<String>? leaveTypes,
    FilterModel? filter,
    bool? hasReachedMax,
    String? selectedType,
    DateTime? startDate,
    DateTime? endDate,
    String? exportError,
    bool? isExporting,
  }) => AttendanceInitial();
}

class AttendanceLoading extends AttendanceState {
  const AttendanceLoading({
    required super.absences,
    required super.leaveTypes,
    required super.filter,
    required super.hasReachedMax,
    required super.selectedType,
    required super.startDate,
    required super.endDate,
  });

  @override
  AttendanceState copyWith({
    List<AbsenceWithMemberModel>? absences,
    List<String>? leaveTypes,
    FilterModel? filter,
    bool? hasReachedMax,
    String? selectedType,
    DateTime? startDate,
    DateTime? endDate,
    String? exportError,
    bool? isExporting,
  }) => AttendanceLoading(
        absences: absences ?? this.absences,
        leaveTypes: leaveTypes ?? this.leaveTypes,
        filter: filter ?? this.filter,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        selectedType: selectedType ?? this.selectedType,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
      );
}

class AttendanceSuccess extends AttendanceState {
  const AttendanceSuccess({
    required super.absences,
    required super.leaveTypes,
    required super.filter,
    required super.hasReachedMax,
    required super.selectedType,
    required super.startDate,
    required super.endDate,
  });

  @override
  AttendanceState copyWith({
    List<AbsenceWithMemberModel>? absences,
    List<String>? leaveTypes,
    FilterModel? filter,
    bool? hasReachedMax,
    String? selectedType,
    DateTime? startDate,
    DateTime? endDate,
    String? exportError,
    bool? isExporting,
  }) => AttendanceSuccess(
        absences: absences ?? this.absences,
        leaveTypes: leaveTypes ?? this.leaveTypes,
        filter: filter ?? this.filter,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        selectedType: selectedType ?? this.selectedType,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
      );
}

class AttendanceError extends AttendanceState {
  final String message;

  const AttendanceError({
    required this.message,
    required super.absences,
    required super.leaveTypes,
    required super.filter,
    required super.hasReachedMax,
    required super.selectedType,
    required super.startDate,
    required super.endDate,
  });

  @override
  List<Object?> get props => [message, ...super.props];

  @override
  AttendanceState copyWith({
    List<AbsenceWithMemberModel>? absences,
    List<String>? leaveTypes,
    FilterModel? filter,
    bool? hasReachedMax,
    String? selectedType,
    DateTime? startDate,
    DateTime? endDate,
    String? exportError,
    bool? isExporting,
  }) => AttendanceError(
        message: message,
        absences: absences ?? this.absences,
        leaveTypes: leaveTypes ?? this.leaveTypes,
        filter: filter ?? this.filter,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        selectedType: selectedType ?? this.selectedType,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
      );
}

class AttendanceExporting extends AttendanceState {
  const AttendanceExporting({
    required super.absences,
    required super.leaveTypes,
    required super.filter,
    required super.hasReachedMax,
    required super.selectedType,
    required super.startDate,
    required super.endDate,
  }) : super(isExporting: true);

  @override
  AttendanceState copyWith({
    List<AbsenceWithMemberModel>? absences,
    List<String>? leaveTypes,
    FilterModel? filter,
    bool? hasReachedMax,
    String? selectedType,
    DateTime? startDate,
    DateTime? endDate,
    String? exportError,
    bool? isExporting,
  }) => AttendanceExporting(
        absences: absences ?? this.absences,
        leaveTypes: leaveTypes ?? this.leaveTypes,
        filter: filter ?? this.filter,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        selectedType: selectedType ?? this.selectedType,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
      );
}

class AttendanceExportSuccess extends AttendanceState {
  const AttendanceExportSuccess({
    required super.absences,
    required super.leaveTypes,
    required super.filter,
    required super.hasReachedMax,
    required super.selectedType,
    required super.startDate,
    required super.endDate,
  });

  @override
  AttendanceState copyWith({
    List<AbsenceWithMemberModel>? absences,
    List<String>? leaveTypes,
    FilterModel? filter,
    bool? hasReachedMax,
    String? selectedType,
    DateTime? startDate,
    DateTime? endDate,
    String? exportError,
    bool? isExporting,
  }) => AttendanceExportSuccess(
        absences: absences ?? this.absences,
        leaveTypes: leaveTypes ?? this.leaveTypes,
        filter: filter ?? this.filter,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        selectedType: selectedType ?? this.selectedType,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
      );
}

class AttendanceExportError extends AttendanceState {
  const AttendanceExportError({
    required super.absences,
    required super.leaveTypes,
    required super.filter,
    required super.hasReachedMax,
    required super.selectedType,
    required super.startDate,
    required super.endDate,
    required super.exportError,
  });

  @override
  AttendanceState copyWith({
    List<AbsenceWithMemberModel>? absences,
    List<String>? leaveTypes,
    FilterModel? filter,
    bool? hasReachedMax,
    String? selectedType,
    DateTime? startDate,
    DateTime? endDate,
    String? exportError,
    bool? isExporting,
  }) => AttendanceExportError(
        absences: absences ?? this.absences,
        leaveTypes: leaveTypes ?? this.leaveTypes,
        filter: filter ?? this.filter,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        selectedType: selectedType ?? this.selectedType,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        exportError: exportError ?? this.exportError,
      );
}