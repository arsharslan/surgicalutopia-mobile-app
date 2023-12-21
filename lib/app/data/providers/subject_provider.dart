import 'package:get/get.dart';
import 'package:surgicalutopia/main.dart';
import 'package:surgicalutopia/utils/wrapper_connect.dart';

import '../models/subject_model.dart';

class SubjectProvider extends WrapperConnect {
  SubjectProvider() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Subject.fromJson(map);
      if (map is List)
        return map.map((item) => Subject.fromJson(item)).toList();
    };
    httpClient.baseUrl = baseURL;
  }

  Future<List<Subject>?> getSubjects() async {
    final response = await get('subjects/');
    return response.body;
  }

  Future<Subject?> getSubject(int id) async {
    final response = await get('subjects/$id');
    return response.body;
  }
}
