import 'package:flutter/material.dart';
import 'package:polyglapp/splash.dart';
import 'package:polyglapp/question.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash()
    );
  }
}

class MainPage extends StatelessWidget {
  String username = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Polyglapp")),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(70.0),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Image.network("https://raw.githubusercontent.com/lucasfacci/Polyglapp/main/app/src/main/res/drawable-v24/polyglot.png", width: 150)
                  ),
                  Center(
                    child: Text("Insira o seu nome:", style: TextStyle(color: Colors.grey, fontSize: 25))
                  ),
                  Center(
                    child: TextField(
                      keyboardType: TextInputType.text,
                      onChanged: (var value) {
                                  username = value;
                                }
                    )
                  ),
                  Center(
                    child: ElevatedButton(
                      child: Text(
                        "Enviar",
                        style: TextStyle(fontSize: 10.0, color: Colors.white),
                      ),
                      onPressed: () {
                        var valid = username.contains(RegExp('[a-zA-Z]'));
                        if (username == "") {
                          showAlertDialog(context, "É necessário inserir um nome!");
                        } else if (valid == false) {
                          showAlertDialog(context, "É necessário inserir um nome válido!");
                        } else {
                          Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Question(username: username);
                              }
                            )
                          );
                        }
                      },
                    ),
                  )
                ]
              )
            )
          ]
        )
      ),
    );
  }
}

showAlertDialog(BuildContext context, String message) {
  Widget okButton = FlatButton(onPressed: () {Navigator.of(context, rootNavigator: true)
      .pop();}, child: Text("Ok"));
  AlertDialog alert = AlertDialog(content: Text(message), actions: [okButton]);
  showDialog(context: context, builder: (BuildContext context) {return alert;});
}