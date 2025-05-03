import 'dart:math';
import 'package:flutter/material.dart';

import 'package:PV/assets/verb-service.dart';
import 'package:PV/assets/verb-model.dart';
import 'package:PV/widgets/snackbar.dart';
import 'package:PV/widgets/score.dart';
import 'package:PV/main.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late Future<List<PhrasalVerb>> _questionsFuture;
  late List<PhrasalVerb> _questions;
  PhrasalVerb? _currentQuestion;
  List<String>? _choices;

  int _currentIndex = 0;
  int _correctCount = 0;
  int _incorrectCount = 0;
  bool _questionLoaded = false;

  final int _maxId = 2240;

  @override
  void initState() {
    super.initState();
    _questionsFuture = loadAllQuestions();
    _currentIndex = Random().nextInt(_maxId);
  }

  void _setQuestion(int index) {
    _currentQuestion = _questions[index];
    _choices = _generateOptions(_currentQuestion!.id);
    _questionLoaded = true;
  }

  List<String> _generateOptions(int correctId) {
    final random = Random();
    final choiceIds = <int>{correctId};

    while (choiceIds.length < 5) {
      choiceIds.add(random.nextInt(_questions.length));
    }

    return choiceIds
        .map((id) => _questions.firstWhere((q) => q.id == id).answer)
        .toList()
      ..shuffle();
  }

  void _nextQuestion() {
    setState(() {
      _currentIndex = Random().nextInt(_questions.length);
      _setQuestion(_currentIndex);
    });
  }

  void _showFeedback(BuildContext context, bool isCorrect, String? choice) {
    setState(() {
      if (isCorrect) {
        _correctCount++;
      } else {
        _incorrectCount++;
      }
    });

    final feedbackQuestion =
        isCorrect
            ? _currentQuestion
            : _questions.firstWhere((q) => q.answer == choice);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      buildFeedbackSnackBar(
        context: context,
        isCorrect: isCorrect,
        choice: choice,
        question: feedbackQuestion!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.psychology, color: Colors.orangeAccent),
            SizedBox(width: 8),
            Text(
              'Quiz',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: globalBackgroundDecoration,
        child: FutureBuilder<List<PhrasalVerb>>(
          future: _questionsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              _questions = snapshot.data!;
              if (!_questionLoaded && _questions.isNotEmpty) {
                _setQuestion(_currentIndex);
              }
              return _buildQuestionCard(context);
            } else {
              return const Center(child: Text('No data available.'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildQuestionCard(BuildContext context) {
    if (_currentQuestion == null || _choices == null) {
      return const SizedBox.shrink();
    }

    final double fontSize = MediaQuery.of(context).size.width * 0.045;

    return SizedBox.expand(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(64, 32, 64, 96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(100),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.blueGrey.withAlpha(100),
                  width: 1,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(25, 96, 125, 139),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Text(
                _currentQuestion!.question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.orangeAccent,
                  fontWeight: FontWeight.bold,
                  shadows: const [
                    Shadow(
                      offset: Offset(1.5, 1.5),
                      blurRadius: 2.0,
                      color: Color.fromARGB(60, 0, 0, 0),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ..._choices!.map((choice) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                  onPressed: () {
                    _showFeedback(
                      context,
                      choice == _currentQuestion!.answer,
                      choice,
                    );
                    if (choice == _currentQuestion!.answer) {
                      _nextQuestion();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                      fontSize: fontSize * 0.85,
                      fontWeight: FontWeight.bold,
                    ),
                    foregroundColor: Colors.orangeAccent,
                    backgroundColor: Colors.blueAccent[900],
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(choice),
                ),
              );
            }).toList(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ScoreCard(label: 'Correct: $_correctCount', fontSize: fontSize),
                ScoreCard(label: 'False: $_incorrectCount', fontSize: fontSize),
              ],
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
