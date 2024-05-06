import 'package:flutter/material.dart';
import 'package:lab2/DatabaseHelper.dart';
import 'package:lab2/sport.dart';

class CRUDPage extends StatefulWidget {
  @override
  _CRUDPageState createState() => _CRUDPageState();
}

FootballTeam footballTeam = FootballTeam();
FootballTeam footballTeamToUpdate = FootballTeam();

class _CRUDPageState extends State<CRUDPage> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;
  int? idToDelete;
  List<FootballTeam> _teams = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadTeams();
  }

  void _loadTeams() async {
    var teams = await databaseHelper.readAllFootballTeams();
    setState(() {
      _teams = teams;
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Operations'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.list), text: 'Retrieve'),
            Tab(icon: Icon(Icons.add), text: 'Insert'),
            Tab(icon: Icon(Icons.delete), text: 'Delete'),
            Tab(icon: Icon(Icons.edit), text: 'Update'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Виджет для отображения списка элементов
          ListView.builder(
            itemCount: _teams.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Команда ${_teams[index].id}: ${_teams[index].teamName}'),
                subtitle: Text('Игроков в команде: ${_teams[index].teamSize}'),
              );
            },
          ),
          // Виджет для вставки нового элемента
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Название команды',
                  ),
                  onChanged: (value) {
                    footballTeam.teamName = value;
                  },
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Количество игроков',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    footballTeam.teamSize = int.tryParse(value);
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    footballTeam.region = 'RU';
                    await databaseHelper.createFootballTeam(footballTeam);
                    _loadTeams(); // Перезагружаем список команд после добавления
                  },
                  child: Text('Добавить команду'),
                ),
              ],
            ),
          ),
          // Виджет для удаления элемента
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'ID команды для удаления',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    idToDelete = int.tryParse(value);
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    await databaseHelper.deleteFootballTeam(idToDelete!);
                    _loadTeams(); // Перезагружаем список команд после удаления
                  },
                  child: Text('Удалить команду'),
                ),
              ],
            ),
          ),
          // Виджет для обновления элемента
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'ID команды для обновления',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    footballTeamToUpdate.id = int.tryParse(value);
                  },
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Новое название команды',
                  ),
                  onChanged: (value) {
                    footballTeamToUpdate.teamName = value;
                  },
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Новое количество игроков',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    footballTeamToUpdate.teamSize = int.tryParse(value);
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    await databaseHelper.updateFootballTeam(footballTeamToUpdate);
                    _loadTeams();
                  },
                  child: Text('Обновить информацию о команде'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
