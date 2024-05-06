import 'dart:convert';
import 'dart:async';
abstract class Sport {
  void play();
}

abstract class TeamSport {
  int players;
  TeamSport(this.players);
  void teamPlay();
}

abstract class SoloSport{
  int weight;
  SoloSport(this.weight);
  void soloPlay();
}

mixin Game {
  void startGame() {
    print('Игра началась!');
  }
  void endGame() {
    print('Игра закончилась!');
  }
}

class Football  extends TeamSport with Game implements Sport {
  static const int teamSize = 11;
  Football() : super(teamSize);
  int get teamPlayers => players;
  set teamPlayers(int players) {
    this.players = players;
  }
  void printPlayers({int players = 11}) {
    print('Количество игроков в команде: $players');
  }
  void printTeamSize([int size = 11]) {
    print('Размер команды: $size');
  }
  void performAction(Function action) {
    action();
  }
  void optionalFunction([String? message]) {
    if (message != null) {
      print(message);
    } else {
      print('Необязательное сообщение отсутствует');
    }
  }
  @override
  void play() {
    print('Игра в футбол!');
  }
  @override
  void teamPlay() {
    print('Играем в команде из $players игроков');
  }
  String toJson() {
    return jsonEncode({
      'teamSize': teamSize,
      'players': players,
    });
  }
   delay(int seconds) async {
    await Future.delayed(Duration(seconds: seconds));
    print('Задержка на $seconds секунд(ы) завершена');
  }
  Future<String> getTeamName() async {
    await Future.delayed(Duration(seconds: 2)); // Имитация задержки
    return 'Awesome Football Team';
  }
}


class Tennis extends SoloSport implements Sport {
  static const String courtType = 'Grass';
  Tennis(int weight) : super(weight);
  Tennis.defaultWeight() : super(70);
  int get racketWeight => weight;
  set racketWeight(int weight) {
    this.weight = weight;
  }
  @override
  void play() {
    print('Игра в теннис!');
  }
  @override
  void soloPlay() {
    print('Ракетка весит $racketWeight грамм');
  }
}


class Player implements Comparable<Player> {
  String name;
  int score;
  Player(this.name, this.score);
  @override
  int compareTo(Player other) {
    if (score < other.score) {
      return -1;
    } else if (score > other.score) {
      return 1;
    } else {
      return 0;
    }
  }
}

class Team implements Iterable<Player> {
  List<Player> players = [];
  void addPlayer(Player player) {
    players.add(player);
  }
  @override
  Iterator<Player> get iterator => TeamIterator(this);

  @override
  bool any(bool Function(Player element) test) {
    return players.any(test);
  }
  @override
  Iterable<R> cast<R>() {
    return players.cast();
  }
  @override
  bool contains(Object? element) {
    return players.contains(element);
  }
  @override
  Player elementAt(int index) {
    return players.elementAt(index);
  }
  @override
  bool every(bool Function(Player element) test) {
    return players.every((element) => false);
  }
  @override
  Iterable<T> expand<T>(Iterable<T> Function(Player element) toElements) {
    return players.expand(toElements);
  }
  @override
  Player get first => players.first;
  @override
  @override
  Player firstWhere(bool Function(Player) test, {Player Function()? orElse}) =>
      players.firstWhere(test, orElse: orElse);

  @override
  T fold<T>(T initialValue, T Function(T, Player) combine) =>
      players.fold(initialValue, combine);

  @override
  Iterable<Player> followedBy(Iterable<Player> other) => players.followedBy(other);

  @override
  void forEach(void Function(Player element) action) {
    players.forEach(action);
  }

  @override
  bool get isEmpty => players.isEmpty;

  @override
  bool get isNotEmpty => players.isNotEmpty;

  @override
  String join([String separator = ""]) {
    return players.join();
  }
  @override
  Player get last => players.last;
  @override
  Player lastWhere(bool Function(Player) test, {Player Function()? orElse}) =>
      players.lastWhere(test, orElse: orElse);

  @override
  int get length => players.length;

  @override
  Iterable<T> map<T>(T Function(Player) f) => players.map(f);

  @override
  Player reduce(Player Function(Player, Player) combine) =>
      players.reduce(combine);

  @override
  Player get single => players.single;

  @override
  Player singleWhere(bool Function(Player) test, {Player Function()? orElse}) =>
      players.singleWhere(test, orElse: orElse);

  @override
  Iterable<Player> skip(int count) {
    return players.skip(count);
  }

  @override
  Iterable<Player> skipWhile(bool Function(Player value) test) {
    return players.skipWhile((value) => false);
  }

  @override
  Iterable<Player> take(int count) {
    return players.take(count);
  }

  @override
  Iterable<Player> takeWhile(bool Function(Player value) test) {
    return players.takeWhile((value) => false);
  }

  @override
  List<Player> toList({bool growable = true}) {
    return players.toList();
  }

  @override
  Set<Player> toSet() {
    return players.toSet();
  }

  @override
  Iterable<Player> where(bool Function(Player element) test) {
    return players.where((element) => false);
  }

  @override
  Iterable<T> whereType<T>() {
    return players.whereType();
  }
}

class TeamIterator implements Iterator<Player> {
  final Team team;
  int currentIndex = -1;
  TeamIterator(this.team);
  @override
  Player get current {
    if (currentIndex >= 0 && currentIndex < team.players.length) {
      return team.players[currentIndex];
    } else {
      return Player('', 0);
    }
  }
  @override
  bool moveNext() {
    currentIndex++;
    return currentIndex < team.players.length;
  }
}

Stream<int> countStream(int to) async* {
  for (int i = 1; i <= to; i++) {
    yield i;
    await Future.delayed(Duration(seconds: 1));
  }
}

Stream<int> countBroadcastStream(int to) async* {
  for (int i = 1; i <= to; i++) {
    yield i;
    await Future.delayed(Duration(seconds: 1));
  }
}


void main() async {
  var football = Football();
  football.startGame();
  football.play();
  football.teamPlay();
  football.printPlayers(players: 11);
  football.printTeamSize(11);
  football.endGame();

  Player player1 = new Player("Arts", -10);
  Player player2 = new Player("Nechay", 3);
  print(player1.compareTo(player2));
  print(player2.compareTo(player1));

  var team = Team();
  team.addPlayer(Player('Player 1', 10));
  team.addPlayer(Player('Player 2', 20));

  for (var player in team) {
    print('${player.name}: ${player.score}');
  };

  player1 = team.last;
  player2 = team.first;
  print('is not empty: ${team.isNotEmpty}');
  team.forEach((element) {element.score += 10; });
  for (var player in team) {
    print('${player.name}: ${player.score}');
  }

  print(football.toJson());

  print('Начинаем задержку...');
  await football.delay(3);
  print('Задержка завершена!');

  print('Получаем название команды...');
  String teamName = await football.getTeamName();
  print('Название команды: $teamName');



  // Одноподписочный стрим
  print('Одноподписочный стрим:');
  await for (var i in countStream(5)) {
    print(i);
  }

  // Многоподписочный стрим
  print('Многоподписочный стрим:');
  var stream = countBroadcastStream(5).asBroadcastStream();
  stream.listen((data) => print('Подписчик 1: $data'));
  stream.listen((data) => print('Подписчик 2: $data'));




  /*lab2
  var tennis = Tennis.defaultWeight();
  tennis.play();
  tennis.soloPlay();
  print('Тип корта для тенниса: ${Tennis.courtType}');
  tennis.racketWeight = 250;
  print('Новый вес ракетки: ${tennis.racketWeight} грамм');

  var list = [1, 2, 3, 4, 5];
  list.add(6);
  list.add(6);
  list.removeAt(2);
  list.insert(2, 10);
  print('List: $list');
  print('1-ый элемент: ${list[0]}');

  var set = {3, 5, 7, 2, 4};
  set.add(-2);
  set.add(-2);
  set.add(-2);
  print('Set: $set');

  var map = {
    'apple': 'red',
    'banana': 'yellow',
    'grape': 'purple',
  };
  map.remove('banana');
  print('Map: $map');
  print('Apple is ${map['apple']}\n');

  for (var i = 0; i < 10; i++) {
    if (i == 5) {
      break;
    }
    print(i);
  }
  print('\n');

  for (var i = 0; i < 10; i++) {
    if (i % 2 == 0) {
      continue;
    }
    print(i);
  }

  print('\n');

  try {
    throw Exception('Некоторое исключение');
  } catch (e) {
    print(e);
  } finally {
    print('Try-catch-finally блок');
  }*/
}