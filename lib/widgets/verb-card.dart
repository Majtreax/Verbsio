import 'package:flutter/material.dart';
import 'package:PV/assets/verb-model.dart';

class VerbCard extends StatelessWidget {
  final PhrasalVerb verb;
  final VoidCallback onTap;

  const VerbCard({required this.verb, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseFont = MediaQuery.of(context).size.width * 0.045;

    final titleStyle = theme.textTheme.titleLarge!.copyWith(
      shadows: const [Shadow(offset: Offset(1.5, 1.5), blurRadius: 7.0)],
      color: Colors.orangeAccent,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontSize: baseFont * 1.25,
    );

    final labelStyle = theme.textTheme.bodyMedium!.copyWith(
      color: Colors.grey[400],
      fontWeight: FontWeight.bold,
    );

    final contentStyle = theme.textTheme.titleMedium!.copyWith(
      fontSize: baseFont,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
      height: 1.5,
    );

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        splashColor: Colors.orangeAccent.withAlpha(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '${verb.verb} ${verb.prep}',
                textAlign: TextAlign.center,
                style: titleStyle,
              ),
              const SizedBox(height: 20),
              _Section(
                label: 'Definition',
                text: verb.definition,
                labelStyle: labelStyle,
                textStyle: contentStyle.copyWith(color: Colors.amberAccent),
              ),
              const SizedBox(height: 20),
              _Section(
                label: 'Synonyms',
                text: verb.synonyms.join(', '),
                labelStyle: labelStyle,
                textStyle: contentStyle.copyWith(color: Colors.lightBlueAccent),
              ),
              if (verb.examples.isNotEmpty) ...[
                const SizedBox(height: 20),
                _Section(
                  label: 'Example',
                  text: verb.examples.first,
                  labelStyle: labelStyle,
                  textStyle: contentStyle.copyWith(color: Colors.pinkAccent),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String label;
  final String text;
  final TextStyle labelStyle;
  final TextStyle textStyle;

  const _Section({
    required this.label,
    required this.text,
    required this.labelStyle,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 6),
        Text(text, textAlign: TextAlign.center, style: textStyle),
      ],
    );
  }
}
