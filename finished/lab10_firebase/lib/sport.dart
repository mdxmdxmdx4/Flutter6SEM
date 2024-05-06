
class FootballTeam {
  int? id;
  String? teamName;
  int? teamSize;
  String? region;

  FootballTeam({this.id, this.teamSize, this.teamName, this.region});

  @override
  String toString() {
    return 'FootballTeam{id: $id, teamName: $teamName, teamSize: $teamSize, region: $region}';
  }

  Map<String, dynamic> toMap() {
    return {
      'teamName': teamName,
      'teamSize': teamSize,
      'region': region,
    };
  }
}

