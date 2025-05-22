import 'package:flutter/material.dart';

class ScoreCard extends StatelessWidget {
  final String label;
  final double fontSize;

  const ScoreCard({required this.label, required this.fontSize, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(100),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blueGrey.withAlpha(100), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize * 0.75,
          color: Colors.orangeAccent,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
