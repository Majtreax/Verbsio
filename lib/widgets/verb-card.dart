import 'package:flutter/material.dart';

import 'package:PV/assets/verb-model.dart';

class VerbCard extends StatelessWidget {
  static const double _outerMargin = 16;
  static const double _innerPadding = 64;
  static const double _borderRadius = 25;

  final PhrasalVerb verb;
  final VoidCallback onTap;

  const VerbCard({required this.verb, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.titleLarge!.copyWith(
      color: Colors.orangeAccent,
      fontWeight: FontWeight.bold,
    );
    final labelStyle = theme.textTheme.bodySmall!.copyWith(
      color: Colors.grey[400],
      fontWeight: FontWeight.bold,
    );
    final contentStyle = theme.textTheme.bodyLarge!.copyWith(
      fontStyle: FontStyle.italic,
      height: 1.4,
    );

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: _outerMargin,
        vertical: _outerMargin / 2,
      ),
      color: Colors.black.withAlpha(100),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        side: BorderSide(color: Colors.blueGrey.withAlpha(100)),
      ),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(_borderRadius),
        splashColor: Colors.orangeAccent.withAlpha(30),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(_innerPadding),
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
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(label, style: labelStyle),
      const SizedBox(height: 6),
      Text(text, textAlign: TextAlign.center, style: textStyle),
    ],
  );
}
