import 'dart:math';
import 'package:flutter/material.dart';
import 'package:PV/assets/verb-model.dart';
import 'package:PV/assets/verb-service.dart';
import 'package:PV/widgets/snackbar.dart';
import 'package:PV/widgets/score.dart';

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

  final int _maxId = 2240;
  int _currentIndex = 0;
  int _correctCount = 0;
  int _incorrectCount = 0;
  bool _questionLoaded = false;

  @override
  void initState() {
    super.initState();
    _questionsFuture = loadAllQuestions();
    _currentIndex = Random().nextInt(_maxId);
  }

  void _setQuestion(int index) {
    if (!mounted) return;
    _currentQuestion = _questions[index];
    _choices = _generateOptions(_currentQuestion!.id);
    _questionLoaded = true;
  }

  List<String> _generateOptions(int correctId) {
    final rnd = Random();
    final ids = <int>{correctId};
    while (ids.length < 5) {
      ids.add(rnd.nextInt(_questions.length));
    }
    return ids
        .map((id) => _questions.firstWhere((q) => q.id == id).answer)
        .toList()
      ..shuffle();
  }

  void _nextQuestion() {
    if (!mounted) return;
    setState(() {
      _currentIndex = Random().nextInt(_questions.length);
      _setQuestion(_currentIndex);
    });
  }

  void _showFeedback(BuildContext ctx, bool correct, String? choice) {
    if (!mounted) return;
    setState(() {
      correct ? _correctCount++ : _incorrectCount++;
    });

    final fbq =
        correct
            ? _currentQuestion!
            : _questions.firstWhere((q) => q.answer == choice);

    ScaffoldMessenger.of(ctx)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        buildFeedbackSnackBar(
          context: ctx,
          isCorrect: correct,
          choice: choice,
          question: fbq,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final double fontSize = MediaQuery.of(context).size.width * 0.045;

    return FutureBuilder<List<PhrasalVerb>>(
      future: _questionsFuture,
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snap.hasError) {
          return Center(child: Text('Error: ${snap.error}'));
        }

        final data = snap.data;
        if (data == null || data.isEmpty) {
          return const Center(child: Text('No data available.'));
        }

        _questions = data;
        if (!_questionLoaded) _setQuestion(_currentIndex);

        return Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: _buildQuizContent(context, fontSize),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuizContent(BuildContext context, double fontSize) {
    final q = _currentQuestion!;
    final choices = _choices!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          q.question,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.orangeAccent,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            shadows: const [Shadow(offset: Offset(1.5, 1.5), blurRadius: 7.0)],
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 6,
          alignment: WrapAlignment.center,
          children:
              choices.map((c) {
                return ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 100,
                    maxWidth: 200,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _showFeedback(context, c == q.answer, c);
                      if (c == q.answer) _nextQuestion();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.orangeAccent,
                      backgroundColor: Colors.blueGrey.withAlpha(50),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      textStyle: TextStyle(
                        fontSize: fontSize * 0.75,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 15,
                    ),
                    child: Text(c, textAlign: TextAlign.center),
                  ),
                );
              }).toList(),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ScoreCard(label: 'Correct: $_correctCount', fontSize: fontSize),
            ScoreCard(label: 'False: $_incorrectCount', fontSize: fontSize),
          ],
        ),
      ],
    );
  }
}
