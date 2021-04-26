import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final String category;
  final String difficulty;
  final String question;
  final String correct;
  final List<String> answers;

  const Question(
      {required this.category,
      required this.difficulty,
      required this.question,
      required this.correct,
      required this.answers});

  @override
  List<Object?> get props => [category, difficulty, question, correct, answers];

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
        category: map['category'],
        difficulty: map['difficulty'],
        question: map['question'],
        correct: map['correct_answer'],
        answers: List<String>.from(map['incorrect_answers'] ?? [])
          ..add(map['correct_answer'] ?? '')
          ..shuffle(),
      );
  }
}
