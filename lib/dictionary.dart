import 'package:flutter/material.dart';
import 'package:PV/assets/verb-model.dart';
import 'package:PV/assets/verb-service.dart';
import 'verb-card.dart';
import 'navbar.dart';
import 'main.dart';
import 'dart:math';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  _DictionaryPageState createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  static const int _maxId = 2240;
  late int _currentVerbId;
  late Future<PhrasalVerb> _verbFuture;
  int _selectedIndex = 0; // Track the selected tab

  @override
  void initState() {
    super.initState();
    _currentVerbId = _generateRandomId(); // Generate random ID
    _verbFuture = _loadVerbById(_currentVerbId);
  }

  Future<PhrasalVerb> _loadVerbById(int id) {
    return loadVerbById(id);
  }

  void _refreshPage() {
    setState(() {
      _currentVerbId = _generateRandomId();
      _verbFuture = _loadVerbById(_currentVerbId);
    });
  }

  int _generateRandomId() {
    return Random().nextInt(_maxId) + 1;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0 || index == 2) {
      _refreshPage();
    } else if (index == 1) {
      Navigator.pushNamed(context, '/quiz');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dictionary'),
        centerTitle: true,
      ),
      body: Container(
        decoration: globalBackgroundDecoration,
        child: _buildVerbContent(),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildVerbContent() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: FutureBuilder<PhrasalVerb>(
              future: _verbFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  PhrasalVerb verb = snapshot.data!;
                  return VerbCard(
                    verb: verb,
                    onTap: _refreshPage,
                  );
                } else {
                  return const Center(child: Text('No data available.'));
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
