import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eloquent_quiz/enums/Difficulty.dart';
import 'package:eloquent_quiz/models/failure.dart';
import 'package:eloquent_quiz/models/question.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseQuizRepository {
  Future<List<Question>> getQuestions(
      {required int questionCount,
      required int categoryId,
      required Difficulty difficulty});
}

final dioProvider = Provider<Dio>((ref) => Dio());
final quizRepositoryProvider =
    Provider<QuizRepository>((ref) => QuizRepository(ref.read));

class QuizRepository extends BaseQuizRepository {
  final Reader _read;

  QuizRepository(this._read);

  @override
  Future<List<Question>> getQuestions(
      {required int questionCount,
      required int categoryId,
      required Difficulty difficulty}) async {
    try {
      final queryParamenters = {
        'type': 'multiple',
        'amount': questionCount,
        'category': categoryId
      };
      if (difficulty != Difficulty.any) {
        queryParamenters
            .addAll({'difficulty': EnumToString.convertToString(difficulty)});
      }

      final response = await _read(dioProvider).get(
          'https://opentdb.com/api.php',
          queryParameters: queryParamenters);

      final data = Map<String, dynamic>.from(response.data);
      final results = List<Map<String, dynamic>>.from(data['results']);
      if (results.isNotEmpty) {
        return results.map((e) => Question.fromMap(e)).toList();
      }
      return [];
    } on DioError catch (e) {
      print(e);
      throw Failure(message: e.response?.statusMessage);
    } on SocketException catch (e) {
      print(e);
      throw Failure(message: 'Please Check Your Internet Connection');
    }
  }
}
