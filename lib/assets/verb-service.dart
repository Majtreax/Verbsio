import 'dart:async';
import 'dart:convert';
import 'verb-model.dart';
import 'package:flutter/services.dart';

// Function to load the merged JSON asset
Future<String> _loadMergedAsset() async {
  return await rootBundle.loadString('lib/assets/verbs.json');
}

// Function to load a single phrasal verb by its ID
Future<PhrasalVerb> loadVerbById(int id) async {
  try {
    String jsonString = await _loadMergedAsset();
    final List<dynamic> jsonResponse = json.decode(jsonString);
    // Find the verb with the specified ID
    Map<String, dynamic>? verbJson = jsonResponse.firstWhere(
      (verb) => verb['id'] == id,
      orElse: () => null,
    );
    if (verbJson == null) {
      throw Exception('Phrasal verb with ID $id not found');
    }
    return PhrasalVerb.fromJson(verbJson);
  } catch (e) {
    // Handle errors appropriately
    print('Error loading phrasal verb by ID: $e');
    throw e; // Propagate the error up
  }
}

// Function to load all questions
Future<List<PhrasalVerb>> loadAllQuestions() async {
  try {
    String jsonString = await _loadMergedAsset();
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((json) => PhrasalVerb.fromJson(json)).toList();
  } catch (e) {
    // Handle errors appropriately
    print('Error loading all questions: $e');
    throw e;
  }
}

// Function to load a single question by its ID
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
    // Handle errors appropriately
    print('Error loading question by ID: $e');
    throw e;
  }
}
