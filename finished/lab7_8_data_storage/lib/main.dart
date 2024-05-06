import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lab2/SharedPreferencesPage.dart';
import 'package:path_provider/path_provider.dart';
import 'FileOperationsPage.dart';
import 'CRUDPage.dart';
import 'HivePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  Hive.registerAdapter(FootballTeamAdapter());
  await Hive.openBox<FootballTeam>('footballTeamBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
          fontFamily: "Bahnschrift"
      ),
      debugShowCheckedModeBanner: false,
      title: 'Your App',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    CRUDPage(),
    SharedPreferencesPage(),
    FileOperationsPage(),
    HivePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_one),
            label: 'CRUD',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_two),
            label: 'Shared preference',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_3),
            label: 'Page 3',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_4),
            label: 'Page 4',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blueGrey,
        onTap: _onItemTapped,
      ),
    );
  }
}