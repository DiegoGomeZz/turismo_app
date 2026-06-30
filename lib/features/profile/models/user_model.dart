class UserModel {
  final int id;
  final String name;
  final String lastname;
  final String email;
  final String phone;
  final String? image;

  UserModel({
    required this.id,
    required this.name,
    required this.lastname,
    required this.email,
    required this.phone,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      lastname: json['lastname'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
    );
  }
}
