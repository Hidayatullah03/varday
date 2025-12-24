enum UserRole { student, lecturer }

class User {
  final String uid;
  final String email;
  final String name;
  final UserRole role;
  final String? profilePictureUrl;

  User({
    required this.uid,
    required this.email,
    required this.name,
    required this.role,
    this.profilePictureUrl,
  });

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      uid: data['uid'],
      email: data['email'],
      name: data['name'],
      role: data['role'] == 'lecturer' ? UserRole.lecturer : UserRole.student,
      profilePictureUrl: data['profilePictureUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'role': role == UserRole.lecturer ? 'lecturer' : 'student',
      'profilePictureUrl': profilePictureUrl,
    };
  }
}