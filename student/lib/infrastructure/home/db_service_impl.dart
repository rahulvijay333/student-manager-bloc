import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:student/domain/db_model/db_mode.dart';
import 'package:student/domain/db_model/db_service.dart';

const studentDbName = 'student-database';

@LazySingleton(as: StudentDbFunctions)
class DbServiceImpl implements StudentDbFunctions {
  @override
  Future<void> insertStudent(StudentModel value) async {
    final studentdb = await Hive.openBox<StudentModel>(studentDbName);
    await studentdb.put(value.id, value);
  }

  //--------------------get student db
  @override
  Future<List<StudentModel>> getStudentList() async {
    final studentdb = await Hive.openBox<StudentModel>(studentDbName);

    return studentdb.values.toList();
  }

  //----------------delete Student
  @override
  Future<void> deleteStudent(String deletekey) async {
    final studentdb = await Hive.openBox<StudentModel>(studentDbName);

    await studentdb.delete(deletekey);
  }

  //--------------------update student

  @override
  Future<void> updateStudent(String key, StudentModel value) async {
    final studentdb = await Hive.openBox<StudentModel>(studentDbName);

    await studentdb.put(key, value);
  }
}
