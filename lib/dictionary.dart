import 'dart:math';
import 'package:flutter/material.dart';

import 'package:PV/assets/verb-service.dart';
import 'package:PV/assets/verb-model.dart';
import 'package:PV/widgets/verbs.dart';
import 'package:PV/main.dart';

const int kMaxVerbId = 2240;

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  final ValueNotifier<PhrasalVerb?> _verbNotifier = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    _loadRandomVerb();
  }

  Future<void> _loadRandomVerb() async {
    final id = Random().nextInt(kMaxVerbId) + 1;
    final verb = await loadVerbById(id);
    if (!mounted) return;
    _verbNotifier.value = verb;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.book, color: Colors.orangeAccent),
            SizedBox(width: 8),
            Text(
              'Dictionary',
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
        child: ValueListenableBuilder<PhrasalVerb?>(
          valueListenable: _verbNotifier,
          builder: (context, verb, _) {
            if (verb == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween<double>(
                        begin: 0.95,
                        end: 1.0,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: VerbCard(
                  key: ValueKey(verb.id),
                  verb: verb,
                  onTap: _loadRandomVerb,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _verbNotifier.dispose();
    super.dispose();
  }
}
