import 'dart:convert';
import 'dart:io';

import 'package:crewmeister_test/gen/assets.gen.dart';



Future<List<dynamic>> readJsonFile(String path) async {
  String content = await File(path).readAsString();
  Map<String, dynamic> data = jsonDecode(content);
  return data['payload'];
}

Future<List<dynamic>> absences() async {
  return await readJsonFile(Assets.jsonFiles.absences);
}

Future<List<dynamic>> members() async {
  return await readJsonFile(Assets.jsonFiles.members);
}
