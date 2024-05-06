import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sport.dart';

class SharedPreferencesPage extends StatefulWidget {
  @override
  _SharedPreferencesPageState createState() => _SharedPreferencesPageState();
}

class _SharedPreferencesPageState extends State<SharedPreferencesPage> {
  final TextEditingController _teamNameController = TextEditingController();
  final TextEditingController _teamSizeController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  String _savedData = '';
  int _idCounter = 1;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  void _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    String allData = '';
    for (int i = 1; i <= _idCounter; i++) {
      String? data = prefs.getString('football_team_$i');
      if (data != null) {
        allData += 'Запись $i: $data\n';
      }
    }
    setState(() {
      _savedData = allData.isNotEmpty ? allData : 'Нет сохраненных данных';
    });
  }


  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final footballTeam = FootballTeam(
      id: _idCounter,
      teamName: _teamNameController.text,
      teamSize: int.tryParse(_teamSizeController.text),
      region: _regionController.text,
    );
    await prefs.setString('football_team_$_idCounter', footballTeam.toString());
    _idCounter++;

    // Сброс текстовых полей
    _teamNameController.clear();
    _teamSizeController.clear();
    _regionController.clear();

    // Обновление списка сохраненных данных
    _loadSavedData();
  }


  Future<void> _deleteData() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 1; i <= _idCounter; i++) {
      await prefs.remove('football_team_$i');
    }
    _loadSavedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preferences Demo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _teamNameController,
                decoration: InputDecoration(labelText: 'Название команды'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _teamSizeController,
                decoration: InputDecoration(labelText: 'Число игроков'),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _regionController,
                decoration: InputDecoration(labelText: 'Регион'),
              ),
            ),
            ElevatedButton(
              onPressed: _saveData,
              child: Text('Сохранить данные'),
            ),
            ElevatedButton(
              onPressed: _deleteData,
              child: Text('Удалить данные'),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Сохраненные данные: $_savedData'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _teamNameController.dispose();
    _teamSizeController.dispose();
    _regionController.dispose();
    super.dispose();
  }
}
