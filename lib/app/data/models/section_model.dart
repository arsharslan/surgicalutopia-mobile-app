class Section {
  String? sId;
  String? subject;
  String? name;
  int? timeRequired;
  int? numberOfQuestions;
  int? iV;
  String? svgPath;
  String? pngPath;
  bool? showResultsEarly;

  Section(
      {this.sId,
      this.subject,
      this.name,
      this.timeRequired,
      this.numberOfQuestions,
      this.iV,
      this.svgPath,
      this.pngPath,
      this.showResultsEarly});

  Section.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    subject = json['subject'];
    name = json['name'];
    timeRequired = json['timeRequired'];
    numberOfQuestions = json['numberOfQuestions'];
    svgPath = json['svgPath'];
    pngPath = json['pngPath'];
    showResultsEarly = json['showResultsEarly'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['subject'] = subject;
    data['name'] = name;
    data['timeRequired'] = timeRequired;
    data['numberOfQuestions'] = numberOfQuestions;
    data['__v'] = iV;
    return data;
  }
}
