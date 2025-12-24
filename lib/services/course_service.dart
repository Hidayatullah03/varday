import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/course.dart';

class CourseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all courses
  Stream<List<Course>> getCourses() {
    return _firestore.collection('courses').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Course.fromMap(doc.data())).toList();
    });
  }

  // Get courses for a student
  Stream<List<Course>> getEnrolledCourses(String studentId) {
    return _firestore
        .collection('courses')
        .where('enrolledStudents', arrayContains: studentId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Course.fromMap(doc.data())).toList();
    });
  }

  // Get courses taught by lecturer
  Stream<List<Course>> getLecturerCourses(String lecturerId) {
    return _firestore
        .collection('courses')
        .where('lecturerId', isEqualTo: lecturerId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Course.fromMap(doc.data())).toList();
    });
  }

  // Add course (for lecturer)
  Future<void> addCourse(Course course) async {
    await _firestore.collection('courses').doc(course.id).set(course.toMap());
  }

  // Enroll student
  Future<void> enrollStudent(String courseId, String studentId) async {
    await _firestore.collection('courses').doc(courseId).update({
      'enrolledStudents': FieldValue.arrayUnion([studentId]),
    });
  }
}