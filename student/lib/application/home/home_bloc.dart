import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:student/domain/db_model/db_mode.dart';
import 'package:student/domain/db_model/db_service.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final StudentDbFunctions _studentDbFunctions;

  HomeBloc(this._studentDbFunctions) : super(HomeState.intial()) {
    on<DisplayStudents>((event, emit) async {
      //intial state
      emit(HomeState(studentList: [], loading: true));

      //get list
      final result = await _studentDbFunctions.getStudentList();

      //display UI
      emit(HomeState(studentList: result, loading: false));
    });

    on<DeleteStudent>((event, emit) async {
      await _studentDbFunctions.deleteStudent(event.key);

      add(DisplayStudents());
    });

    on<EditStudent>((event, emit) async {
      await _studentDbFunctions.updateStudent(event.key, event.student);

      add(DisplayStudents());
    });
  }
}
