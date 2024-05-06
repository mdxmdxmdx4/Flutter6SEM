import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'HivePage.g.dart';

@HiveType(typeId: 0)
class FootballTeam extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? teamName;

  @HiveField(2)
  int? teamSize;

  @HiveField(3)
  String? region;

  FootballTeam({this.id, this.teamSize, this.teamName, this.region});

  @override
  String toString() {
    return 'FootballTeam{id: $id, teamName: $teamName, teamSize: $teamSize, region: $region}';
  }

  factory FootballTeam.fromMap(Map<String, dynamic> map) {
    return FootballTeam(
      id: map['id'],
      teamName: map['teamName'],
      teamSize: map['teamSize'],
      region: map['region'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'teamName': teamName,
      'teamSize': teamSize,
      'region': region,
    };
  }
}

class FootballTeamBox {
  static const String _boxName = "footballTeamBox";

  // Открывает коробку с футбольными командами
  Future<Box> openBox() async {
    return await Hive.openBox<FootballTeam>(_boxName);
  }

  // Создает новую футбольную команду
  Future<int> createFootballTeam(FootballTeam team) async {
    final box = await openBox();
    return await box.add(team);
  }

  Future<List<FootballTeam>> readAllFootballTeams() async {
    final box = await openBox();
    return box.values.map((item) => item as FootballTeam).toList();
  }

  Future<void> updateFootballTeam(int index, FootballTeam team) async {
    final box = await openBox();
    return box.putAt(index, team);
  }

  Future<void> deleteFootballTeam(int index) async {
    final box = await openBox();
    return box.deleteAt(index);
  }
}


class HivePage extends StatefulWidget {
  @override
  _HivePageState createState() => _HivePageState();
}

class _HivePageState extends State<HivePage> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final FootballTeamBox footballTeamBox = FootballTeamBox();
  FootballTeam footballTeam = FootballTeam();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
          ValueListenableBuilder(
            valueListenable: Hive.box<FootballTeam>('footballTeamBox').listenable(),
            builder: (context, Box<FootballTeam> box, _) {
              return ListView.builder(
                itemCount: box.values.length,
                itemBuilder: (context, index) {
                  var team = box.getAt(index);
                  var id = box.keyAt(index);
                  return ListTile(
                    title: Text('Команда $id: ${team?.teamName}'),
                    subtitle: Text('Игроков в команде: ${team?.teamSize}'),
                  );
                },
              );
            },
          ),
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
                    await footballTeamBox.createFootballTeam(footballTeam);
                  },
                  child: Text('Добавить команду'),
                ),
              ],
            ),
          ),
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
                    footballTeam.id = int.tryParse(value);
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (footballTeam.id != null) {
                      await footballTeamBox.deleteFootballTeam(footballTeam.id!);
                    }
                  },
                  child: Text('Удалить команду'),
                ),
              ],
            ),
          ),
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
                    footballTeam.id = int.tryParse(value);
                  },
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Новое название команды',
                  ),
                  onChanged: (value) {
                    footballTeam.teamName = value;
                  },
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Новое количество игроков',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    footballTeam.teamSize = int.tryParse(value);
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (footballTeam.id != null) {
                      footballTeam.region = 'RU';
                      await footballTeamBox.updateFootballTeam(footballTeam.id!, footballTeam);
                    }
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
