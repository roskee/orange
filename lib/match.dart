import 'team.dart';
class Match{
  int id;
  String date;
  Team homeTeam;
  int homeTeamScore;
  int period;
  bool postSeason;
  int season;
  String status;
  String time;
  Team visitorTeam;
  int visitorTeamScore;
  Match.fromJson(Map<String, dynamic> json){
    this.id = json['id'];
    this.date = json['date'];
    this.homeTeam = Team.fromJson(json['home_team']);
    this.homeTeamScore = json['home_team_score'];
    this.period = json['period'];
    this.postSeason = json['postseason'];
    this.status = json['status'];
    this.time = json['time'];
    this.visitorTeam = Team.fromJson(json['visitor_team']);
    this.visitorTeamScore = json['visitor_team_score'];
  }
}