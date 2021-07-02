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

class _MyHomePageState extends State<MyHomePage>  with SingleTickerProviderStateMixin{

  // bool control values
  bool matchesLoaded = false;

  // data values
  TabController tabController;
  List<Tab> tabs = [
    Tab(text: 'Games',),
    Tab(text: 'Teams',)
  ];
  List<Match> matches;

  Future<List<Match>> fetchMathes() async {
    http.Response response = await http.get(Uri.parse('http://www.mocky.io/v2/5de8d38a3100000f006b1479'));
    List<dynamic> data= jsonDecode(response.body)['data'];
    List<Match> matches =[];
    for (int i=0; i<data.length;i++){
      matches.add(Match.fromJson(data[i]));
    }
    return matches;
  }
  @override
  void initState(){
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    fetchMathes().then((value) {
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
              Center(
                child:(matchesLoaded)?ListView(
                  children: List.generate(matches.length, (i) => ListTile(
                    title: Text(matches[i].homeTeam.fullName),
                  )),
                ):CircularProgressIndicator(),
              ),
              Center(
                child: (matchesLoaded)?ListView(
                  children: List.generate(Team.teams.length, (i) => ListTile(
                    title: Text(Team.teams[i].fullName),
                    subtitle: Row(
                      children: [
                      Text('city: ${Team.teams[i].city}'),
                      Text('name: ${Team.teams[i].name}')
                    ],),
                  ))
                ):CircularProgressIndicator(),
              )
            ],
          ),
       ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
