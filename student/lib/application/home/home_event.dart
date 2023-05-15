part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class AddStudent extends HomeEvent {}

class DeleteStudent extends HomeEvent {
  final String key;

  DeleteStudent({required this.key});
}

class DisplayStudents extends HomeEvent {}

class EditStudent extends HomeEvent {
  final String key;
  final StudentModel student;

  EditStudent({required this.key, required this.student});
}
