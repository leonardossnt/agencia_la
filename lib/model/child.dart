class Child {
  String name;
  String birthday;
  String gender;
  String? picture;
  String kinship;
  String? comments;

  Child({
    required this.name,
    required this.birthday,
    required this.gender,
    this.picture,
    required this.kinship,
    this.comments
  });

  int age() {
    DateTime bday = DateTime.parse(birthday);
    DateTime now = DateTime.now();
    int age = now.year - bday.year;

    if (now.month < bday.month) {
      age--;
    } else if (now.day < bday.day) {
      age--;
    }

    return age;
  }

  Object toJson() {
    return {
      'name': name,
      'birthday': birthday,
      'gender': gender,
      'kinship': kinship,
      'comments': comments,
    };
  }

  static Child fromJson(dynamic data) {
    return Child(
        name: data["name"],
        birthday: data["birthday"],
        gender: data["gender"],
        picture: data["picture"],
        kinship: data["kinship"],
        comments: data["comments"]);
  }
}
