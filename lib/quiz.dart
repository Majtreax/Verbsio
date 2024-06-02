import 'package:PV/main.dart';
import 'package:PV/assets/verb-model.dart';
import 'package:PV/assets/verb-service.dart';
import 'package:flutter/material.dart';
import 'navbar.dart';
import 'dart:async';
import 'dart:math';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late Future<List<PhrasalVerb>> _questionsFuture;
  late List<PhrasalVerb> _questions;
  PhrasalVerb? _currentQuestion;
  List<String>? _choices;
  final int _maxId = 2240;
  int _selectedIndex = 1;
  int _currentIndex = 0;
  int _correctCount = 0;
  int _incorrectCount = 0;
  bool _questionLoaded = false;

  @override
  void initState() {
    super.initState();
    _questionsFuture = loadAllQuestions();
    _currentIndex = _generateRandomStartIndex();
  }

  int _generateRandomStartIndex() {
    return Random().nextInt(_maxId);
  }

  void _setQuestion(int index) {
    _currentQuestion = _questions[index];
    _choices = _generateOptions(_currentQuestion!.id);
    _questionLoaded = true;
  }

  List<String> _generateOptions(int correctId) {
    List<String> choices = [];
    Random random = Random();
    Set<int> choiceIds = {correctId};

    while (choiceIds.length < 5) {
      choiceIds.add(random.nextInt(_questions.length));
    }

    for (int id in choiceIds) {
      choices
          .add(_questions.firstWhere((question) => question.id == id).answer);
    }
    choices.shuffle();
    return choices;
  }

  void _nextQuestion() {
    setState(() {
      _currentIndex = Random().nextInt(_questions.length);
      _setQuestion(_currentIndex);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0 || index == 1) {
      _nextQuestion();
    } else if (index == 2) {
      Navigator.pushNamed(context, '/dictionary');
    }
  }

  void _showFeedback(BuildContext context, bool isCorrect, String? choice) {
    setState(() {
      if (isCorrect) {
        _correctCount++;
      } else {
        _incorrectCount++;
      }
    });

    double fontSize = MediaQuery.of(context).size.width * 0.045;
    String feedbackMessage = choice ?? '';
    Color feedbackColor = isCorrect
        ? Colors.greenAccent.withOpacity(0.5)
        : Colors.redAccent.withOpacity(0.5);

    PhrasalVerb? feedbackQuestion = isCorrect
        ? _currentQuestion
        : _questions.firstWhere((question) => question.answer == choice);

    List<Widget> feedbackWidgets = [
      if (!isCorrect)
        Text(
          feedbackMessage,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize * 0.65,
            fontWeight: FontWeight.bold,
          ),
        ),
      if (!isCorrect) const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (isCorrect) const SizedBox(width: 8),
          Expanded(
            child: Text(
              isCorrect ? feedbackMessage : feedbackQuestion!.question,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize * 0.75,
                color: Colors.pink[50],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      if (feedbackQuestion!.examples.isNotEmpty)
        Text(
          feedbackQuestion.examples[0],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize * 0.85,
            color: Colors.pink[100],
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
    ];

    final snackBar = SnackBar(
      content: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: feedbackWidgets,
        ),
      ),
      backgroundColor: feedbackColor,
      duration: Duration(seconds: isCorrect ? 5 : 10),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        centerTitle: true,
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
              if (!_questionLoaded) {
                _setQuestion(_currentIndex);
              }
              return _buildQuestionCard(context);
            } else {
              return const Center(child: Text('No data available.'));
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildQuestionCard(BuildContext context) {
    if (_currentQuestion == null || _choices == null)
      return const SizedBox.shrink();

    double fontSize = MediaQuery.of(context).size.width * 0.045;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 64),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _currentQuestion!.question,
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.orangeAccent,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 2.0,
                  color: Color.fromARGB(100, 0, 0, 0),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ..._choices!.map((choice) {
            return ElevatedButton(
              onPressed: () {
                _showFeedback(
                    context, choice == _currentQuestion!.answer, choice);
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
              ),
              child: Text(choice),
            );
          }).toList(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildScoreCard('Correct: $_correctCount', fontSize),
              _buildScoreCard('False: $_incorrectCount', fontSize),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCard(String text, double fontSize) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent[900],
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize * 0.75,
          color: Colors.orangeAccent,
        ),
      ),
    );
  }
}
