import 'question.dart';

class QuestionLogic {
  int _questionNumber = 0;

  List<bool> _userAnswers = [];

  final List<Question> _questions = [
    Question('У кота 4 лапы', true),
    Question('У кота 5 лап', false),
    Question('У кота 6 лап', false),
    Question('У кота больше одной лапы', true),
    Question('У кота 7 лап', false),
  ];

  addAnswer(bool answer) {
    _userAnswers.add(answer);
  }

  getAnswerList() {
    return _userAnswers;
  }

  getQuestionNumber() {
    return _questionNumber;
  }

  getQuestion() {
    return _questions[_questionNumber].questionText;
  }

  getAnswer() {
    return _questions[_questionNumber].questionAnswer;
  }

  nextQuestion() {
    if (_questionNumber < _questions.length - 1) {
      _questionNumber++;
    }
  }

  bool isFinished() {
    if (_questionNumber >= _questions.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  reset() {
    _questionNumber = 0;
    _userAnswers.clear();
  }

  int getAllCount() {
    return _questions.length;
  }
}
