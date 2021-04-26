import 'package:eloquent_quiz/enums/QuizStatus.dart';
import 'package:eloquent_quiz/models/question.dart';
import 'package:eloquent_quiz/providers/providers.dart';
import 'package:eloquent_quiz/widgets/quiz_error.dart';
import 'package:eloquent_quiz/widgets/quiz_questions.dart';
import 'package:eloquent_quiz/widgets/quiz_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BuildBody extends HookWidget {
  final PageController pageController;
  final List<Question> questions;

  BuildBody({required this.pageController, required this.questions});

  final quizState = useProvider(quizControllerProvider);

  @override
  Widget build(BuildContext context) {
    print(quizState);
    if (questions.isEmpty) return QuizError(message: 'No Questions found');
    return quizState.status == QuizStatus.complete
        ? QuizResults(questions: questions)
        : QuizQuestions(
            pageController: pageController,
            state: quizState,
            questions: questions);
  }
}
