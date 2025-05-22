import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:PV/assets/verb-model.dart';

Future<String> _loadMergedAsset() async {
  return await rootBundle.loadString('lib/assets/verbs.json');
}

Future<PhrasalVerb> loadVerbById(int id) async {
  try {
    String jsonString = await _loadMergedAsset();
    final List<dynamic> jsonResponse = json.decode(jsonString);
    Map<String, dynamic>? verbJson = jsonResponse.firstWhere(
      (verb) => verb['id'] == id,
      orElse: () => null,
    );
    if (verbJson == null) {
      throw Exception('Phrasal verb with ID $id not found');
    }
    return PhrasalVerb.fromJson(verbJson);
  } catch (e) {
    rethrow;
  }
}

Future<List<PhrasalVerb>> loadAllQuestions() async {
  try {
    String jsonString = await _loadMergedAsset();
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((json) => PhrasalVerb.fromJson(json)).toList();
  } catch (e) {
    rethrow;
  }
}

Future<PhrasalVerb> loadQuestionById(int id) async {
  try {
    String jsonString = await _loadMergedAsset();
    final List<dynamic> jsonResponse = json.decode(jsonString);
    Map<String, dynamic>? questionJson = jsonResponse.firstWhere(
      (question) => question['id'] == id,
      orElse: () => null,
    );
    if (questionJson == null) {
      throw Exception('Question with ID $id not found');
    }
    return PhrasalVerb.fromJson(questionJson);
  } catch (e) {
    rethrow;
  }
}
