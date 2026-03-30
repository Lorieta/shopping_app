class User {
  final int? id;
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String? profileImageUrl;
  final String region;
  final String province;
  final String municipality;

  const User({
    this.id,
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.profileImageUrl,
    required this.region,
    required this.province,
    required this.municipality,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'profile_image_url': profileImageUrl,
      'region': region,
      'province': province,
      'municipality': municipality,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      username: (map['username'] as String?)?.trim() ?? '',
      password: (map['password'] as String?)?.trim() ?? '',
      firstName: (map['firstName'] as String?)?.trim() ?? '',
      lastName: (map['lastName'] as String?)?.trim() ?? '',
      profileImageUrl: map['profile_image_url'] as String?,
      region: (map['region'] as String?)?.trim() ?? '',
      province: (map['province'] as String?)?.trim() ?? '',
      municipality: (map['municipality'] as String?)?.trim() ?? '',
    );
  }
}
