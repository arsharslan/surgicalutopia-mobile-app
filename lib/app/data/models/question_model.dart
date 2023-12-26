class Question {
  String? sId;
  String? question;
  String? optionA;
  String? optionB;
  String? optionC;
  String? optionD;
  String? correctOption;
  String? subject;
  String? imagePath;
  bool? isPaid;
  int? iV;
  String? choosedOption;

  Question(
      {this.sId,
      this.question,
      this.optionA,
      this.optionB,
      this.optionC,
      this.optionD,
      this.correctOption,
      this.subject,
      this.imagePath,
      this.isPaid,
      this.iV,
      this.choosedOption});

  Question.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    question = json['question'];
    optionA = json['optionA'];
    optionB = json['optionB'];
    optionC = json['optionC'];
    optionD = json['optionD'];
    correctOption = json['correctOption'];
    subject = json['subject'];
    imagePath = json['imagePath'];
    isPaid = json['isPaid'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['question'] = question;
    data['optionA'] = optionA;
    data['optionB'] = optionB;
    data['optionC'] = optionC;
    data['optionD'] = optionD;
    data['correctOption'] = correctOption;
    data['subject'] = subject;
    data['isPaid'] = isPaid;
    data['__v'] = iV;
    return data;
  }
}
