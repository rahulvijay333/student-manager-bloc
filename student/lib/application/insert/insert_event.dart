part of 'insert_bloc.dart';

abstract class InsertEvent {}

class InsertStudent extends InsertEvent {
  final StudentModel student;

  InsertStudent({required this.student});
}




