import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lab10/RegisterPage.dart';
import 'package:lab10/SignInPage.dart';
import 'package:lab10/notification_server.dart';
import 'package:lab10/sport.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firestore_service.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _teamNameController = TextEditingController();
  final TextEditingController _teamSizeController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();

  List<FootballTeam> _teams = [];

  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _loadTeams();
    _notificationService.initialize();
  }

  void _loadTeams() async {
    var teams = await _firestoreService.getTeams();
    setState(() {
      _teams = teams;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list)),
              Tab(icon: Icon(Icons.add)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Первая вкладка: отображение всех команд
            ListView.builder(
              itemCount: _teams.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_teams[index].teamName!),
                  subtitle: Text('Region: ${_teams[index].region}, Team Size: ${_teams[index].teamSize}'),
                );
              },
            ),

            // Вторая вкладка: форма для добавления новой команды
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _teamNameController,
                    decoration: InputDecoration(labelText: 'Team Name'),
                  ),
                  TextField(
                    controller: _teamSizeController,
                    decoration: InputDecoration(labelText: 'Team Size'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: _regionController,
                    decoration: InputDecoration(labelText: 'Region'),
                  ),
                  TextButton(
                    onPressed: () {
                      var newTeam = FootballTeam(
                        teamName: _teamNameController.text,
                        teamSize: int.parse(_teamSizeController.text),
                        region: _regionController.text,
                      );
                      _firestoreService.addTeam(newTeam);
                      setState(() {
                        _teams.add(newTeam); // Добавляем новую команду в список
                      });
                    },
                    child: Text('Add Team'),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignInPage()),
            );
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), //
      ),
    );
  }
}
