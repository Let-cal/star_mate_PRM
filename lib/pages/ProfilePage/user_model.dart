class User {
  final String fullName;
  final String email;
  final String? telephoneNumber;
  final int? zodiacId;
  final String? nameZodiac;
  final String? description;

  User({
    required this.fullName,
    required this.email,
    this.telephoneNumber,
    this.zodiacId,
    this.nameZodiac,
    this.description,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      telephoneNumber: json['telephoneNumber'],
      zodiacId: json['zodiacId'],
      nameZodiac: json['nameZodiac'],
      description: json['description'],
    );
  }
}
