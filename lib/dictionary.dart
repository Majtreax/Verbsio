import 'dart:math';
import 'package:flutter/material.dart';
import 'package:PV/assets/verb-model.dart';
import 'package:PV/assets/verb-service.dart';
import 'package:PV/widgets/verb-card.dart';

const int kMaxVerbId = 2240;

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  final ValueNotifier<PhrasalVerb?> _verbNotifier = ValueNotifier(null);
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadRandomVerb();
  }

  Future<void> _loadRandomVerb() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final id = Random().nextInt(kMaxVerbId) + 1;
    try {
      final verb = await loadVerbById(id);
      if (mounted) _verbNotifier.value = verb;
    } catch (e) {
      if (mounted) _errorMessage = e.toString();
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _verbNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading && _verbNotifier.value == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_errorMessage != null) {
      return Center(child: Text('Error: $_errorMessage'));
    }
    return ValueListenableBuilder<PhrasalVerb?>(
      valueListenable: _verbNotifier,
      builder: (context, verb, _) {
        if (verb == null) {
          return const SizedBox.shrink();
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
    );
  }
}
