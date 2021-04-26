import 'package:eloquent_quiz/enums/QuizStatus.dart';
import 'package:eloquent_quiz/models/question.dart';
import 'package:equatable/equatable.dart';

class QuizState extends Equatable {
  final String selectedAnswer;
  final List<Question>? correct;
  final List<Question>? incorrect;
  final QuizStatus status;

  bool get answered =>
      status == QuizStatus.incorrect || status == QuizStatus.correct;

  const QuizState(
      {required this.selectedAnswer,
      this.correct,
      this.incorrect,
      required this.status});

  factory QuizState.initial() {
    return QuizState(
        selectedAnswer: '',
        correct: [],
        incorrect: [],
        status: QuizStatus.intial);
  }

  @override
  List<Object?> get props => [selectedAnswer, correct, incorrect, status];

  QuizState copyWith(
      {required String selectedAnswer,
      List<Question>? correct,
      List<Question>? incorrect,
      required QuizStatus status}) {
    return QuizState(
        selectedAnswer: selectedAnswer,
        correct: correct,
        incorrect: incorrect,
        status: status);
  }
}
