import 'package:flutter/material.dart';
import 'package:polyglapp/main.dart';

class Result extends StatelessWidget {
  String username;
  int points;
  Result({this.username, this.points});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Polyglapp")),
        body: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(child: Text("Pontuação final:", style: TextStyle(color: Colors.grey, fontSize: 30))),
            Center(child: Text("$points", style: TextStyle(color: Colors.lightBlue, fontSize: 30))),
            ElevatedButton(
              child: Text(
                "Recomeçar",
                style: TextStyle(fontSize: 10.0, color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MainPage();
                    }
                  )
                );
              },
            )
          ],
        )
      ),
    );
  }
}