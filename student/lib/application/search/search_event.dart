part of 'search_bloc.dart';

abstract class SearchEvent {}

class SearchInitial extends SearchEvent {}

class SearchQuery extends SearchEvent {
  final String searchQuery;

  SearchQuery({required this.searchQuery});
}


