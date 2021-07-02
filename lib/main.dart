import 'package:flutter/material.dart';

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

  TabController tabController;
  List<Tab> tabs = [
    Tab(text: 'Games',),
    Tab(text: 'Teams',)
  ];
  @override
  void initState(){
    super.initState();
    tabController = TabController(length: 2, vsync: this);
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
              Text("hello world"),
              Text('hello now')
            ],
          ),
       ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
