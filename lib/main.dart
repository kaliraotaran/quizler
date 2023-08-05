import 'package:quizler/quizbrain.dart';
import 'package:flutter/material.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

Quizbrain quizbrain = Quizbrain();
void main() {
  runApp(const Quizler());
}

class Quizler extends StatelessWidget {
  const Quizler({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scorekeeper = [];

  void checkanswer(bool userpickedanswer) {
    bool correctanser = quizbrain.getcorrectanswer();
    setState(() {
      if (Quizbrain().questionnumber == 14) {
        Alert(
                context: context,
                title: 'Finished!!',
                desc: 'You reached the end of the quiz')
            .show();
        quizbrain.questionnumber = 0;
        scorekeeper = [];
      } else {
        if (userpickedanswer == correctanser) {
          scorekeeper.add(const Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scorekeeper.add(const Icon(
            Icons.close,
            color: Colors.red,
          ));
        }

        quizbrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 70, 10, 10),
            child: Text(
              textAlign: TextAlign.center,
              quizbrain.getQuestionText(),
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: ElevatedButton(
              onPressed: () {
                checkanswer(true);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text(
                'True',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: ElevatedButton(
              onPressed: () {
                checkanswer(false);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                'False',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
        Row(
          children: scorekeeper,
        )
      ],
    );
  }
}
