import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'match.dart';
import 'team.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ethiopian Premier League',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Ethiopian Premier League'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  // bool control values
  bool matchesLoaded = false;

  // data values
  TabController tabController;
  List<Tab> tabs = [
    Tab(
      text: 'GAMES',
    ),
    Tab(
      text: 'TEAMS',
    )
  ];
  List<Match> matches;
  Future<List<Match>> fetchMathes() async {
    http.Response response = await http
        .get(Uri.parse('http://www.mocky.io/v2/5de8d38a3100000f006b1479'));
    if (response.statusCode == HttpStatus.ok) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Match> matches = [];
      for (int i = 0; i < data.length; i++) {
        matches.add(Match.fromJson(data[i]));
      }
      matches.sort((a, b) => b.date.compareTo(a.date));
      return matches;
    } else
      return null;
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);

    // this fetches all data from the remote api to local classes
    fetchMathes().then((value) {
      if (value != null)
        setState(() {
          matches = value;
          matchesLoaded = true;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottom: TabBar(tabs: tabs, controller: tabController),
          title: Text(widget.title),
        ),
        body: Container(
          child: TabBarView(
            controller: tabController,
            children: [
              // Games tab
              Center(
                child: (matchesLoaded)
                    ? ListView(
                        children: List.generate(
                            matches.length,
                            (i) => InkWell(
                              onTap: (){
                                showDialog(context: context, builder: (context)=>AlertDialog(
                                  content:Column(
                                    children: [
                                      Expanded(child:Text('Home Team: ${matches[i].homeTeam}'),),
                                      Expanded(child:Text('Visitor Team: ${matches[i].visitorTeam}'),),
                                      Expanded(child:Text('Home Score: ${matches[i].homeTeamScore}'),),
                                      Expanded(child:Text('Visitor Score: ${matches[i].visitorTeamScore}'),),
                                      Expanded(child:Text('Date: ${matches[i].date}'),),
                                      Expanded(child:Text('Period: ${matches[i].period}'),),
                                      Expanded(child:Text('Post Season: ${matches[i].postSeason}'),),
                                      Expanded(child:Text('Season: ${matches[i].season}'),),
                                      Expanded(child:Text('Status: ${matches[i].status}'),),
                                    ],
                                  ),
                                  actions: [TextButton(child: Text('OK'),onPressed: (){
                                    Navigator.of(context).pop();
                                  },)],
                                ));
                              },
                                    child: Card(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 10,
                                        child: ListTile(
                                          title: Text(
                                              '${matches[i].homeTeam.fullName}'),
                                          subtitle: Text(
                                              '${matches[i].homeTeam.abbr}'),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 4,
                                          child: ListTile(
                                              subtitle: Text(
                                                  '${matches[i].date.hour}:${matches[i].date.minute}'),
                                              title: Text(
                                                '${matches[i].homeTeamScore}-${matches[i].visitorTeamScore}',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    backgroundColor:
                                                        Colors.green),
                                              ))),
                                      Expanded(
                                        flex: 10,
                                        child: ListTile(
                                          title: Text(
                                              '${matches[i].visitorTeam.fullName}'),
                                          subtitle: Text(
                                              '${matches[i].visitorTeam.abbr}'),
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                            ),
                      )
                    : CircularProgressIndicator(),
              ),
              // Teams tab
              Center(
                child: (matchesLoaded)
                    ? ListView(
                        children: List.generate(
                            Team.teams.length,
                            (i) => Row(
                              children:[
                                Expanded(child:ListTile(
                                  title: Text(Team.teams[i].fullName),
                                  subtitle: Text('City: ${Team.teams[i].city}'),
                                  )),
                                Expanded(child:ListTile(
                                  subtitle: Text('division: ${Team.teams[i].division}'),
                                ))
                              ],
                                )))
                    : CircularProgressIndicator(),
              )
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
