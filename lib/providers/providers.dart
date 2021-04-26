import 'dart:math';

import 'package:eloquent_quiz/enums/Difficulty.dart';
import 'package:eloquent_quiz/models/question.dart';
import 'package:eloquent_quiz/providers/quiz/controllers.dart';
import 'package:eloquent_quiz/providers/quiz/state.dart';
import 'package:eloquent_quiz/repository/quiz_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final quizControllerProvider =
    StateNotifierProvider.autoDispose<QuizController, QuizState>(
        (ref) => QuizController());

final questionsProvider = FutureProvider.autoDispose<List<Question>>((ref) =>
    ref.watch(quizRepositoryProvider).getQuestions(
        questionCount: 10,
        categoryId: Random().nextInt(24) + 9,
        difficulty: Difficulty.any));
