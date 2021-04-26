import 'package:eloquent_quiz/models/question.dart';
import 'package:eloquent_quiz/providers/providers.dart';
import 'package:eloquent_quiz/providers/quiz/state.dart';
import 'package:eloquent_quiz/widgets/quiz_answer_card.dart';
import 'package:flutter/material.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizQuestions extends StatelessWidget {
  final PageController pageController;
  final QuizState state;
  final List<Question> questions;

  const QuizQuestions(
      {Key? key,
      required this.pageController,
      required this.state,
      required this.questions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView.builder(
          controller: pageController,
          itemCount: questions.length,
          itemBuilder: (BuildContext context, int index) {
            final question = questions[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Question ${index + 1} of ${questions.length}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    HtmlCharacterEntities.decode(question.question),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Divider(
                  color: Colors.grey[200],
                  height: 32.0,
                  thickness: 2.0,
                  indent: 20.0,
                  endIndent: 20.0,
                ),
                Column(
                  children: question.answers
                      .map((e) => AnswerCard(
                          answer: e,
                          isSelected: e == state.selectedAnswer,
                          isCorrect: e == question.correct,
                          isDisplayingAnswer: state.answered,
                          onTap: () => context
                              .read(quizControllerProvider.notifier)
                              .submitAnswer(question, e)))
                      .toList(),
                )
              ],
            );
          }),
    );
  }
}
