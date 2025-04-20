import 'dart:convert';

class MemberModel {
  final int crewId;
  final int id;
  final String image;
  final String name;
  final int userId;
  MemberModel({
    required this.crewId,
    required this.id,
    required this.image,
    required this.name,
    required this.userId,
  });
  

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'crewId': crewId});
    result.addAll({'id': id});
    result.addAll({'image': image});
    result.addAll({'name': name});
    result.addAll({'userId': userId});
  
    return result;
  }

  factory MemberModel.fromMap(Map<String, dynamic> map) {
    return MemberModel(
      crewId: map['crewId']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      image: map['image'] ?? '',
      name: map['name'] ?? '',
      userId: map['userId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MemberModel.fromJson(String source) => MemberModel.fromMap(json.decode(source));
}
