import 'package:flutter/material.dart';
import 'package:polyglapp/main.dart';
import 'package:polyglapp/result.dart';
import'package:http/http.dart';
import 'dart:math';

var words = ["Ragazzo", "Monkey", "Βέλος", "カメ", "Vin", "Booten", "Playa", "Valp", "Računalo", "Πέτρα"];
var answers = ["Menino", "Macaco", "Flecha", "Tartaruga", "Vinho", "Bota", "Praia", "Cachorro", "Computador", "Pedra"];

class Question extends StatelessWidget {
  String username;
  Question({this.username});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: _QuestionStateful(username: username)
        ),
      ),
    );
  }
}

class _QuestionStateful extends StatefulWidget {
  String username;
  _QuestionStateful({this.username});
  @override
  State<_QuestionStateful> createState() => _QuestionState(username: username);
}

class _QuestionState extends State<_QuestionStateful> {
  String username;
  var firstAnswer;
  var secondAnswer;
  var rand = new Random();

  String _options;

  String _word;
  var places = [];
  String _rightAnswer;
  int _counter = 0;
  int points = 0;

  _QuestionState({this.username}) {
    _word = words[_counter];
    _rightAnswer = answers[_counter];
    _options = null;

    do {
      firstAnswer = answers[rand.nextInt(answers.length)];
    } while (firstAnswer == _rightAnswer);

    do {
      secondAnswer = answers[rand.nextInt(answers.length)];
    } while (secondAnswer == firstAnswer || secondAnswer == _rightAnswer);

    places.addAll([_rightAnswer, firstAnswer, secondAnswer]);
    places.shuffle();
  }

  postRequest() async {
    await post(Uri.parse('https://7c2bad50.us-south.apigw.appdomain.cloud/api/placar'), body:{'usuario': username});
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Text(
            "${username[0].toUpperCase() + username.substring(1)}, qual o significado da palavra abaixo?",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 30)
          )
        ),
        Center(
          child: Text(
            "${_word}",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.lightBlue, fontSize: 30)
          )
        ),
        ListTile(
          title: Text("${places[0]}"),
          leading: Radio(
            value: "${places[0]}",
            groupValue: _options,
            onChanged: (value) {
              setState(() {
               _options = value;
              });
            },
          )
        ),
        ListTile(
          title: Text("${places[1]}"),
          leading: Radio(
            value: "${places[1]}",
            groupValue: _options,
            onChanged: (value) {
              setState(() {
               _options = value;
              });
            },
          )
        ),
        ListTile(
          title: Text("${places[2]}"),
          leading: Radio(
            value: "${places[2]}",
            groupValue: _options,
            onChanged: (value) {
              setState(() {
               _options = value;
              });
            },
          )
        ),
        ElevatedButton(
          child: Text(
            "Enviar",
            style: TextStyle(fontSize: 10.0, color: Colors.white),
          ),
          onPressed: () {
            setState(() {
              if (_options == null) {
                showAlertDialog(context, "É necessário assinalar uma alternativa!");
              } else if (_options == _rightAnswer) {
                points++;
                postRequest();
              }

              if (_counter == 9) {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Result(username: username, points: points);
                    }
                  )
                );
              } else {
                _counter++;
                _options = null;
                places.clear();

                _word = words[_counter];
                _rightAnswer = answers[_counter];

                do {
                  firstAnswer = answers[rand.nextInt(answers.length)];
                } while (firstAnswer == _rightAnswer);

                do {
                  secondAnswer = answers[rand.nextInt(answers.length)];
                } while (secondAnswer == firstAnswer || secondAnswer == _rightAnswer);

                places.addAll([_rightAnswer, firstAnswer, secondAnswer]);
                places.shuffle();
              }
            });
          },
        )
      ],
    );
  }
}