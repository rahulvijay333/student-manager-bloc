import 'package:student/domain/db_model/db_mode.dart';

abstract class StudentDbFunctions {
  Future<List<StudentModel>> getStudentList();
  Future<void> insertStudent(StudentModel value);
  Future<void> deleteStudent(String key);
  Future<void> updateStudent(String key, StudentModel value);
}