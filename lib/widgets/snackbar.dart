import 'package:flutter/material.dart';

import 'package:PV/assets/verb-model.dart';

SnackBar buildFeedbackSnackBar({
  required BuildContext context,
  required bool isCorrect,
  required String? choice,
  required PhrasalVerb question,
}) {
  double fontSize = MediaQuery.of(context).size.width * 0.045;

  final Color baseColor =
      isCorrect
          ? Colors.greenAccent.withAlpha(75)
          : Colors.redAccent.withAlpha(75);

  final IconData icon = isCorrect ? Icons.check_circle : Icons.cancel_rounded;
  final Color textColor = isCorrect ? Colors.greenAccent : Colors.redAccent;

  return SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    duration: Duration(seconds: isCorrect ? 10 : 20),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.symmetric(horizontal: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    content: Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: baseColor.withAlpha(50),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: baseColor, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(icon, color: textColor)],
            ),
          ),
          Text(
            choice ?? '',
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize * 0.65,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            question.question,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize * 0.65,
              color: Colors.pink[50],
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
          ),
          if (question.examples.isNotEmpty)
            Text(
              question.examples[0],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize * 0.75,
                color: Colors.pink[100],
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
        ],
      ),
    ),
  );
}
