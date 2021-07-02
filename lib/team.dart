class Team {
  int id;
  String abbr;
  String city;
  String conference;
  String division;
  String fullName;
  String name;
  Team.fromJson(Map<String,dynamic> json){
    this.id = json['id'];
    this.abbr = json['abbreviation'];
    this.city = json['city'];
    this.conference = json['conference'];
    this.division = json['division'];
    this.fullName = json['full_name'];
    this.name = json['name'];
    addTeam(this);
  }
  static List<Team> teams =[];
  static void addTeam(Team team){
    if(teams.indexWhere((element) => element.id == team.id) == -1){
      teams.add(team);
    }
  }
}