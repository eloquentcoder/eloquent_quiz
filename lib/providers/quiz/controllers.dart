import 'package:eloquent_quiz/enums/QuizStatus.dart';
import 'package:eloquent_quiz/models/question.dart';
import 'package:eloquent_quiz/providers/quiz/state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizController extends StateNotifier<QuizState> {
  QuizController() : super(QuizState.initial());

  void submitAnswer(Question currentQuestion, String answer) {
    if (state.answered) return;
    if (currentQuestion.correct == answer) {
      state = state.copyWith(
          selectedAnswer: answer,
          correct: state.correct?..add(currentQuestion),
          status: QuizStatus.correct);
    } else {
      state = state.copyWith(
          selectedAnswer: answer,
          incorrect: state.incorrect?..add(currentQuestion),
          status: QuizStatus.incorrect);
    }
  }

  void nextQuestion(List<Question> questions, int currentIndex) {
    state = state.copyWith(
        selectedAnswer: '',
        status: currentIndex + 1 < questions.length
            ? QuizStatus.intial
            : QuizStatus.complete);
  }

  void reset() {
    state = QuizState.initial();
  }
}
