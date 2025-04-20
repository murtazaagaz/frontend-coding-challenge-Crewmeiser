import 'dart:convert';
import 'dart:io';

import 'package:crewmeister_test/gen/assets.gen.dart';

class API {
   Future<dynamic> _readJsonFile(String path) async {
  String content = await File(path).readAsString();
  Map<String, dynamic> data = jsonDecode(content);
  return data;
}

Future<dynamic> absences() async {
  return await _readJsonFile(Assets.jsonFiles.absences);
}

Future<dynamic> members() async {
  return await _readJsonFile(Assets.jsonFiles.members);
}
}


