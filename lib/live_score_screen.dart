import 'package:flutter/material.dart';

class LiveScoreScreen extends StatefulWidget {
  const LiveScoreScreen({super.key});

  @override
  State<LiveScoreScreen> createState() => _LiveScoreScreenState();
}

class _LiveScoreScreenState extends State<LiveScoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Scores"),
      ),
      body: ListView.builder(
          
          itemCount: 10,
          itemBuilder: (context, index){
            return ListTile(
              leading: Badge(
                backgroundColor: _indicatorColor(true),
              ),
              title: Text("Match id"),
              subtitle: Text("Team 1 : Bangladesh Team 2 : England"),
            );
          },),
    );
  }

  Color _indicatorColor(bool isMatchRunning){
    return isMatchRunning?Colors.green:Colors.grey;
  }
}
