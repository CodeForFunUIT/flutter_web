class User {
  String? id;
  String? firstName;
  String? lastName;
  String? sex;
  String? email;
  String? password;
  String? dateOfBirth;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.sex,
    this.email,
    this.password,
    this.dateOfBirth,
  });

  factory User.init() => User(
        id: '0',
        firstName: '',
        lastName: '',
        sex: '',
        email: '',
        password: '',
        dateOfBirth: '',
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] ?? '0',
        firstName: json['firstName'] ?? '',
        lastName: json['lastName'] ?? '',
        sex: json['sex'] ?? '',
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        dateOfBirth: json['dateOfBirth'] ?? '',
      );

  factory User.copyWith(User? user) => User(
        id: user?.id,
        firstName: user?.firstName,
        lastName: user?.lastName,
        sex: user?.sex,
        email: user?.email,
        password: user?.password,
        dateOfBirth: user?.dateOfBirth,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "sex": sex,
        "email": email,
        "password": password,
        "dateOfBirth": dateOfBirth,
      };
}
