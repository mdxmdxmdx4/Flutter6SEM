class FootballTeam {
  int? id;
  String? teamName;
  int? teamSize;
  String? region;

  FootballTeam({this.id, this.teamSize, this.teamName, this.region});

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

  @override
  String toString() {
    return 'FootballTeam{id: $id, teamName: $teamName, teamSize: $teamSize, region: $region}';
  }
}

class Tennis {
  int? id;
  String? playerName;
  int? weight;
  String? region;

  Tennis({this.weight, this.playerName, this.region});

  factory Tennis.fromMap(Map<String, dynamic> map) {
    return Tennis(
      playerName: map['playerName'],
      weight: map['weight'],
      region: map['region'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'playerName': playerName,
      'weight': weight,
      'region': region,
    };
  }

}

