import 'package:get/get.dart';
import 'package:surgicalutopia/main.dart';
import 'package:surgicalutopia/utils/shared_preferences.dart';
import 'package:surgicalutopia/utils/wrapper_connect.dart';

import '../models/quiz_result_model.dart';

class QuizResultProvider extends WrapperConnect {
  QuizResultProvider() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return QuizResult.fromJson(map);
      if (map is List)
        return map.map((item) => QuizResult.fromJson(item)).toList();
    };
    httpClient.baseUrl = baseURL;
  }

  Future<QuizResult?> getMyQuizResults() async {
    final response = await get(
        'quiz-result/?userId=${PreferencesHelper.instance.mongoUserID}');
    return response.body;
  }

  Future<ApiResource<QuizResult?>> postQuizResult(QuizResult quizresult) async {
    final response = await wpost<QuizResult?>('quiz-result', quizresult.toJson(),
        decoder: (data) => QuizResult.fromJson(data));
    return response;
  }

  Future<Response> deleteQuizResult(int id) async =>
      await delete('quizresult/$id');
}
