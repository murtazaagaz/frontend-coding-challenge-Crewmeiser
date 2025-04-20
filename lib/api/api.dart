import 'dart:convert';

import 'package:crewmeister_test/gen/assets.gen.dart';
import 'package:flutter/services.dart' show rootBundle;

class API {
  Future<dynamic> _readJsonFile(String path) async {
    String content = await rootBundle.loadString(path);
    
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
