import 'package:eloquent_quiz/models/failure.dart';
import 'package:eloquent_quiz/providers/providers.dart';
import 'package:eloquent_quiz/widgets/custom_button.dart';
import 'package:eloquent_quiz/widgets/quiz_body.dart';
import 'package:eloquent_quiz/widgets/quiz_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizScreen extends HookWidget {
  final questions = useProvider(questionsProvider);
  final PageController pageController = usePageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xFFD4418E), Color(0xff0652C5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: questions.when(
            data: (questions) =>
                BuildBody(pageController: pageController, questions: questions),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => QuizError(
                message:
                    error is Failure ? error.message : 'Something went wrong')),
        bottomSheet: questions.maybeWhen(
            data: (questions) {
              final quizState = useProvider(quizControllerProvider);
              if (!quizState.answered) return const SizedBox.shrink();
              // final page = pageController ? pageController.page:
              return CustomButton(
                  title: pageController.page!.toInt() + 1 < questions.length
                      ? 'Next Questions'
                      : 'See Results',
                  onTap: () {
                    context
                        .read(quizControllerProvider.notifier)
                        .nextQuestion(questions, pageController.page!.toInt());

                    if (pageController.page!.toInt() + 1 < questions.length) {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.linear);
                    }
                  });
            },
            orElse: () => const SizedBox.shrink()),
      ),
    );
  }
}
