import 'package:surgicalutopia/app/data/models/question_model.dart';

class QuizResult {
  String? sId;
  String? sectionId;
  String? subjectId;
  String? userId;
  int? numberOfQuestions;
  int? correctAttempts;
  int? questionsAttempted;
  int? iV;

  QuizResult(
      {this.sId,
      this.sectionId,
      this.subjectId,
      this.userId,
      this.numberOfQuestions,
      this.correctAttempts,
      this.questionsAttempted,
      this.iV});

  QuizResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sectionId = json['sectionId'];
    subjectId = json['subjectId'];
    userId = json['userId'];
    numberOfQuestions = json['numberOfQuestions'];
    correctAttempts = json['correctAttempts'];
    questionsAttempted = json[
        'questionsAttempted'] /* != null && json['questionsAttempted'] is List ? List<Question>.from(json['questionsAttempted'].map((e) => Question.fromJson(e))) : null */;
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['sectionId'] = sectionId;
    data['subjectId'] = subjectId;
    data['userId'] = userId;
    data['numberOfQuestions'] = numberOfQuestions;
    data['correctAttempts'] = correctAttempts;
    data['questionsAttempted'] =
        questionsAttempted /* ?.map((e) => e.toJson()).toList() */;
    data['__v'] = iV;
    data.removeWhere((key, value) => value == null);
    return data;
  }
}
