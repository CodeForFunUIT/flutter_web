class User {
  String? id;
  String? firstName;
  String? lastName;
  String? sex;
  String? email;
  String? password;
  String? dateOfBirth;
  String? phone;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.sex,
    this.email,
    this.password,
    this.dateOfBirth,
    this.phone,
  });

  factory User.init() => User(
        id: '0',
        firstName: '',
        lastName: '',
        sex: '',
        email: '',
        password: '',
        dateOfBirth: '',
        phone: '',
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] ?? '0',
        firstName: json['firstName'] ?? '',
        lastName: json['lastName'] ?? '',
        sex: json['sex'] ?? '',
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        dateOfBirth: json['dateOfBirth'] ?? '',
        phone: json['phone'] ?? '',
      );

  factory User.copyWith(User? user) => User(
        id: user?.id,
        firstName: user?.firstName,
        lastName: user?.lastName,
        sex: user?.sex,
        email: user?.email,
        password: user?.password,
        dateOfBirth: user?.dateOfBirth,
        phone: user?.phone,
      );

  Map<String, dynamic> toJson(User user) => {
        // "id": user.id,
        "firstName": user.firstName,
        "lastName": user.lastName,
        "sex": user.sex ?? "male",
        "email": user.email,
        "password": user.password,
        "dateOfBirth": user.dateOfBirth,
        "phone": user.phone,
      };
}
