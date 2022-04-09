import 'package:flutter/material.dart';

import 'question_logic.dart';
import 'result_page.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({Key? key}) : super(key: key);

  @override
  _TestingPageState createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  QuestionLogic questionLogic = QuestionLogic();
  List<Icon> score = [];
  int correctAnswersCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    questionLogic.getQuestion(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 60),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: () {
                    checkAnswer(true);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green,
                    ),
                    child: Center(child: Text('Истина')),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: () {
                    checkAnswer(false);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    child: Center(child: Text('Ложь')),
                  ),
                ),
              ),
            ),
            Hero(
              tag: 'scoreTag',
              child: scoreRow(questionLogic.getAnswerList(), 40, false),
            )
          ],
        ),
      ),
    );
  }

  checkAnswer(bool userAnswer) {
    bool correctAnswer = questionLogic.getAnswer();

    setState(() {
      if (userAnswer == correctAnswer) {
        correctAnswersCount++;
        questionLogic.addAnswer(true);
      } else {
        questionLogic.addAnswer(false);
      }

      if (questionLogic.isFinished()) {
        String correctAnswerPercent =
            (correctAnswersCount * 100 / questionLogic.getAllCount())
                .toStringAsFixed(0);

        onGoBack(dynamic value) {
          setState(() {
            questionLogic.reset();
            score = [];
            correctAnswersCount = 0;
          });
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(
              correctAnswerPercent: correctAnswerPercent,
              score: score,
              questionLogic: questionLogic,
            ),
          ),
        ).then(onGoBack);

        // showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //         title: Text('Конец теста'),
        //         content: Text('Тест завершен на $correctAnswerPercent%'),
        //       );
        //     });
      } else {
        questionLogic.nextQuestion();
      }
    });
  }
}

Widget scoreRow(List<bool> answerList, double size, bool centered) {
  List<Icon> score = [];
  for (bool answer in answerList) {
    if (answer) {
      score.add(
        Icon(
          Icons.check,
          color: Colors.green,
          size: size,
        ),
      );
    } else {
      score.add(
        Icon(
          Icons.close,
          color: Colors.red,
          size: size,
        ),
      );
    }
  }

  return Row(
    mainAxisAlignment:
        centered ? MainAxisAlignment.center : MainAxisAlignment.start,
    children: score,
  );
}
