import 'dart:math';

import 'package:flutter/material.dart';

import 'question_logic.dart';
import 'testing_page.dart';

class ResultPage extends StatefulWidget {
  const ResultPage(
      {Key? key,
      required this.correctAnswerPercent,
      required this.score,
      required this.questionLogic})
      : super(key: key);

  final List<Icon> score;
  final String correctAnswerPercent;
  final QuestionLogic questionLogic;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> with TickerProviderStateMixin {
  late AnimationController _containerController, _textController;
  late Animation _containerSizeAnimation,
      _textAnimation,
      _containerColorAnimation,
      _backColorAnimation,
      _containerRadiusAnimation,
      _containerRotationAnimation;

  @override
  void initState() {
    super.initState();
    _containerController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _textController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _containerSizeAnimation =
        Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _containerController,
      curve: Curves.bounceOut,
    ))
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _textController.forward();
            }
          });

    _containerColorAnimation =
        ColorTween(begin: Colors.black, end: Colors.white)
            .animate(_containerController);

    _backColorAnimation = ColorTween(begin: Colors.white, end: Colors.grey)
        .animate(_containerController);

    _containerRadiusAnimation = BorderRadiusTween(
            begin: BorderRadius.circular(200), end: BorderRadius.circular(30))
        .animate(_containerController);

    _containerRotationAnimation =
        Tween(begin: 0.0, end: 2.0).animate(CurvedAnimation(
      parent: _containerController,
      curve: Curves.bounceOut,
    ));

    _textAnimation = Tween(begin: 0.0, end: 1.0).animate(_textController)
      ..addListener(() {
        setState(() {});
      });

    _containerController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: _backColorAnimation.value,
      body: Center(
        child: Transform.rotate(
          angle: pi * _containerRotationAnimation.value,
          child: Container(
            decoration: BoxDecoration(
                color: _containerColorAnimation.value,
                borderRadius: _containerRadiusAnimation.value),
            height: _containerSizeAnimation.value * 200.0,
            width: _containerSizeAnimation.value * width * 0.9,
            child: Opacity(
              opacity: _textAnimation.value,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  scoreRow(widget.questionLogic.getAnswerList(), 60.0, true),
                  Text('Тест завершен на ${widget.correctAnswerPercent}%'),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Ещё раз'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
