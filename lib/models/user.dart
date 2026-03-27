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
      'email': password,
      'firstname': firstName,
      'lastname': lastName,
      'profile_image_url': profileImageUrl,
      'region': region,
      'province': province,
      ' municipality': municipality,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      firstName: map['firstname'],
      lastName: map['lastname'],
      profileImageUrl: map['profile_image_url'],
      region: map['region'],
      province: map['province'],
      municipality: map['municipality'],
    );
  }
}
