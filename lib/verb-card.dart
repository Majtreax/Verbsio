import 'package:flutter/material.dart';
import 'package:PV/assets/verb-model.dart';

class VerbCard extends StatelessWidget {
  final PhrasalVerb verb;
  final VoidCallback onTap;

  const VerbCard({required this.verb, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(64),
        margin: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey, width: 1),
          borderRadius: BorderRadius.circular(25),
          color: Colors.black.withOpacity(0.1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${verb.verb} ${verb.prep}',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
                shadows: [
                  Shadow(
                    offset: Offset(3.0, 3.0),
                    blurRadius: 3.0,
                    color: Color.fromARGB(100, 0, 0, 0),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            _buildTextSection('Definition:', verb.definition),
            const SizedBox(height: 30),
            _buildTextSection('Synonyms:', verb.synonyms.join(', ')),
            const SizedBox(height: 30),
            _buildTextSection('Examples:', verb.examples[0]),
          ],
        ),
      ),
    );
  }

  Widget _buildTextSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          content,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
