class Lanny {
  String name;
  String surname;
  String birthday;
  String phone;
  String email;
  String picture;
  String? finishedServices; // TODO: change to List<Service>
  String? ongoingServices; // TODO: change to List<Service>

  Lanny({
      required this.name,
      required this.surname,
      required this.birthday,
      required this.phone,
      required this.email,
      required this.picture
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
      "info": {
        'name': name,
        'surname': surname,
        'birthday': birthday,
        'phone': phone,
        'email': email,
      },
      "finishedServices": finishedServices ?? "",
      "ongoingOrders": ongoingServices ?? "",
    };
  }

  static Lanny fromJson(dynamic data) {
    return Lanny(
        name: data["name"],
        surname: data["surname"],
        birthday: data["birthday"],
        phone: data["phone"],
        email: data["email"],
        picture: data["picture"]);
  }
}
