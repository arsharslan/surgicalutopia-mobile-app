import 'package:get/get.dart';
import 'package:surgicalutopia/main.dart';
import 'package:surgicalutopia/utils/wrapper_connect.dart';

import '../models/question_model.dart';

class QuestionProvider extends WrapperConnect {
  QuestionProvider() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Question.fromJson(map);
      if (map is List)
        return map.map((item) => Question.fromJson(item)).toList();
    };
    httpClient.baseUrl = baseURL;
  }

  Future<List<Question>?> getQuestion(
      {String? subjectId, String? sectionId}) async {
    final response = await get('questions', query: {
      if (subjectId != null) "subject": subjectId,
      if (sectionId != null) "section": sectionId
    });
    return response.body;
  }
}
