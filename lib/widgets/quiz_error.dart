import 'package:eloquent_quiz/repository/quiz_repository.dart';
import 'package:eloquent_quiz/widgets/custom_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

class QuizError extends StatelessWidget {
  final String? message;

  const QuizError({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$message',
              style: const TextStyle(color: Colors.white, fontSize: 20.0)),
          SizedBox(
            height: 20.0,
          ),
          CustomButton(
              title: 'Retry',
              onTap: () => context.refresh(quizRepositoryProvider))
        ],
      ),
    );
  }
}
