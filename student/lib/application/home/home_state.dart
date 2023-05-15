part of 'home_bloc.dart';

class HomeState {
  final List<StudentModel> studentList;
  final bool loading;

  HomeState({required this.studentList,required this.loading});

  factory HomeState.intial() {
    return HomeState(studentList: [], loading: false);
  }
}
