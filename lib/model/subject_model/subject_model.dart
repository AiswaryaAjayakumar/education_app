class SubjectModel {
  final String subject;
  final String icon;
  final String mainColor;
  final String gradientColor;

  SubjectModel({
    required this.subject,
    required this.icon,
    required this.mainColor,
    required this.gradientColor,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      subject: json["subject"],
      icon: json["icon"],
      mainColor: json["main-color"],
      gradientColor: json["gradient-color"],
    );
  }
}
