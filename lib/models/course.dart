class Course {
  final String id;
  final String title;
  final String description;
  final String lecturerId;
  final String lecturerName;
  final List<String> enrolledStudents;
  final List<String> modules; // list of module ids

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.lecturerId,
    required this.lecturerName,
    required this.enrolledStudents,
    required this.modules,
  });

  factory Course.fromMap(Map<String, dynamic> data) {
    return Course(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      lecturerId: data['lecturerId'],
      lecturerName: data['lecturerName'],
      enrolledStudents: List<String>.from(data['enrolledStudents'] ?? []),
      modules: List<String>.from(data['modules'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'lecturerId': lecturerId,
      'lecturerName': lecturerName,
      'enrolledStudents': enrolledStudents,
      'modules': modules,
    };
  }
}