
import 'package:hive_flutter/hive_flutter.dart';
 part 'db_mode.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String age;

  @HiveField(3)
  final String emailId;
  @HiveField(4)
  final String rollNo;

  @HiveField(5)
  String? imageUrl;

  StudentModel(
      {required this.id,
      required this.name,
      required this.age,
      required this.emailId,
      required this.rollNo,
      this.imageUrl});
}