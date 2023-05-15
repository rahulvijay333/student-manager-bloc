part of 'search_bloc.dart';

class SearchState {
  final List<StudentModel> initialList;
  final List<StudentModel> searchList;

  SearchState({
    required this.initialList,
    required this.searchList,
  });

  factory SearchState.initialPage() {
    return SearchState(
      initialList: [],
      searchList: [],
    );
  }
}
