import 'package:get/get.dart';
import 'package:surgicalutopia/main.dart';
import 'package:surgicalutopia/utils/wrapper_connect.dart';

import '../models/section_model.dart';

class SectionProvider extends WrapperConnect {
  SectionProvider() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Section.fromJson(map);
      if (map is List)
        return map.map((item) => Section.fromJson(item)).toList();
    };
    httpClient.baseUrl = baseURL;
  }

  Future<List<Section>?> getSections(String subjectId) async {
    final response = await get('sections/', query: {"subject": subjectId});
    return response.body;
  }

  Future<Section?> getSection(String sectionId) async {
    final response = await get('sections/$sectionId');
    return response.body;
  }
}
