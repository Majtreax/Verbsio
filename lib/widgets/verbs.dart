import 'package:flutter/material.dart';

import 'package:PV/assets/verb-model.dart';

class VerbCard extends StatelessWidget {
  final PhrasalVerb verb;
  final VoidCallback onTap;

  const VerbCard({required this.verb, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final double fontSize = MediaQuery.of(context).size.width * 0.045;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        splashColor: Colors.orangeAccent.withAlpha(15),
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(32),
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(100),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.blueGrey.withAlpha(100), width: 1),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(25, 96, 125, 139),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${verb.verb} ${verb.prep}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize * 1.2,
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent,
                  shadows: const [
                    Shadow(
                      offset: Offset(1.5, 1.5),
                      blurRadius: 2.0,
                      color: Color.fromARGB(60, 0, 0, 0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              _buildTextBlock(
                'Definition',
                verb.definition,
                fontSize,
                Colors.amberAccent,
              ),
              const SizedBox(height: 24),
              _buildTextBlock(
                'Synonyms',
                verb.synonyms.join(', '),
                fontSize,
                Colors.lightBlueAccent,
              ),
              const SizedBox(height: 24),
              if (verb.examples.isNotEmpty)
                _buildTextBlock(
                  'Example',
                  verb.examples[0],
                  fontSize,
                  Colors.pinkAccent,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextBlock(
    String label,
    String content,
    double fontSize,
    Color contentColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize * 0.75,
            color: Colors.grey[300],
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            color: contentColor,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
            height: 1.35,
          ),
        ),
      ],
    );
  }
}
