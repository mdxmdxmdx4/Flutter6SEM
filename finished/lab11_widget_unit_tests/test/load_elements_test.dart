import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:lab10/sport.dart';
import 'package:lab10/firestore_service.dart';
import 'package:lab10/main.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';

typedef Callback = void Function(MethodCall call);

void setupFirebaseAuthMocks([Callback? customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseCoreMocks();
}

void main() {
  setupFirebaseAuthMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
  });

  group('_MyHomePageState Tests', () {
    test('Should load teams correctly', () async {
      final service = FirestoreService();
      service.teamCollection = FakeFirebaseFirestore().collection('teams');

      final state = MyHomePageState();
      state.firestoreService = service;

      final List<FootballTeam> mockTeams = [
        FootballTeam(teamName: 'Team 1', teamSize: 11, region: 'Region 1'),
        FootballTeam(teamName: 'Team 2', teamSize: 12, region: 'Region 2'),
      ];

      for (var team in mockTeams) {
        await service.teamCollection.add(team.toMap());
      }

      state.teams = await service.getTeams();

      expect(state.teams.length, equals(mockTeams.length));
      for (var i = 0; i < mockTeams.length; i++) {
        expect(state.teams[i].teamName, equals(mockTeams[i].teamName));
        expect(state.teams[i].teamSize, equals(mockTeams[i].teamSize));
        expect(state.teams[i].region, equals(mockTeams[i].region));
      }
    });
  });
}

class MockTask extends Mock {
  void call();
}