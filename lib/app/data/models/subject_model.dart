class Subject {
  String? sId;
  String? name;
  String? year;
  String? course;
  String? createdAt;
  String? updatedAt;
  String? pngPath;
  String? svgPath;
  int? iV;

  Subject(
      {this.sId,
      this.name,
      this.year,
      this.course,
      this.createdAt,
      this.updatedAt,
      this.svgPath,
      this.pngPath,
      this.iV});

  Subject.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    year = json['year'];
    course = json['course'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    svgPath = json['svgPath'];
    pngPath = json['pngPath'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['year'] = year;
    data['course'] = course;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
