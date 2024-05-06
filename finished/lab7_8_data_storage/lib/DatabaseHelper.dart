import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:lab2/DatabaseHelper.dart';

import 'sport.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('sports.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''CREATE TABLE FootballTeam(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          teamName TEXT,
          teamSize INTEGER,
          region TEXT
        )
''');
    await db.execute('''CREATE TABLE Tennis(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          playerName TEXT,
          weight INTEGER,
          region TEXT
        )
''');
  }

  Future<int> createFootballTeam(FootballTeam team) async {
    final db = await instance.database;
    return db.insert('FootballTeam', team.toMap());
  }

  Future<List<FootballTeam>> readAllFootballTeams() async {
    final db = await instance.database;
    final result = await db.query('FootballTeam');
    return result.map((e) => FootballTeam.fromMap(e)).toList();
  }

  Future<int> updateFootballTeam(FootballTeam team) async {
    final db = await instance.database;
    return db.update('FootballTeam', team.toMap(), where: 'id = ?', whereArgs: [team.id]);
  }

  Future<int> deleteFootballTeam(int id) async {
    final db = await instance.database;
    return db.delete('FootballTeam', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> createTennis(Tennis tennis) async {
    final db = await instance.database;
    return db.insert('Tennis', tennis.toMap());
  }

  Future<List<Tennis>> readAllTennis() async {
    final db = await instance.database;
    final result = await db.query('Tennis');
    return result.map((e) => Tennis.fromMap(e)).toList();
  }

  Future<int> updateTennis(Tennis tennis) async {
    final db = await instance.database;
    return db.update('Tennis', tennis.toMap(), where: 'id = ?', whereArgs: [tennis.id]);
  }

  Future<int> deleteTennis(int id) async {
    final db = await instance.database;
    return db.delete('Tennis', where: 'id = ?', whereArgs: [id]);
  }
}
