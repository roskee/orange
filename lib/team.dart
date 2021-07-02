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
  }
}