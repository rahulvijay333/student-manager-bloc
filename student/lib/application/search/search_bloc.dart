import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:student/domain/db_model/db_mode.dart';
import 'package:student/domain/db_model/db_service.dart';

part 'search_event.dart';
part 'search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final StudentDbFunctions _studentDbFunctions;

  SearchBloc(this._studentDbFunctions) : super(SearchState.initialPage()) {
    on<SearchInitial>((event, emit) async {
      //intial page
      emit(SearchState(initialList: [], searchList: [], ));

      //get all students
      final allStudent = await _studentDbFunctions.getStudentList();

      //show to ui
      emit(
          SearchState(initialList: allStudent, searchList: []));
    });

    on<SearchQuery>((event, emit) async {
      final studnetList = await _studentDbFunctions.getStudentList();


        //------------------------------searching 
      final search = studnetList
          .where((student) =>
              student.name.toLowerCase().contains(event.searchQuery))
          .toList();

      emit(SearchState(
          initialList: state.initialList, searchList: search,));
    });
  }
}
