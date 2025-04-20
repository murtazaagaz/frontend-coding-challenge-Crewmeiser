import 'dart:convert';

class AbsenceModel {
  final int? admitterId;
  final String admitterNote;
  final String? confirmedAt;
  final String createdAt;
  final int crewId;
  final DateTime endDate;
  final int id;
  final String memberNote;
  final String? rejectedAt;
  final DateTime startDate;
  final String type;
  final int userId;
  AbsenceModel({
    this.admitterId,
    required this.admitterNote,
    this.confirmedAt,
    required this.createdAt,
    required this.crewId,
    required this.endDate,
    required this.id,
    required this.memberNote,
    this.rejectedAt,
    required this.startDate,
    required this.type,
    required this.userId,
  });


  factory AbsenceModel.fromMap(Map<String, dynamic> map) {
    return AbsenceModel(
      admitterId: map['admitterId']?.toInt(),
      admitterNote: map['admitterNote'] ?? '',
      confirmedAt: map['confirmedAt'],
      createdAt: map['createdAt'] ?? '',
      crewId: map['crewId']?.toInt() ?? 0,
      endDate: DateTime.parse(map['endDate']),
      id: map['id']?.toInt() ?? 0,
      memberNote: map['memberNote'] ?? '',
      rejectedAt: map['rejectedAt'],
      startDate: DateTime.parse(map['startDate']),
      type: map['type'] ?? '',
      userId: map['userId']?.toInt() ?? 0,
    );
  }


  factory AbsenceModel.fromJson(String source) => AbsenceModel.fromMap(json.decode(source));
}
