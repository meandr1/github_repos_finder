part of 'home_cubit.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final List<RepositoryModel> repositories;
  final HomeStatus status;
  final List<String> searchHistory;

  const HomeState({
    required this.repositories,
    required this.status,
    required this.searchHistory,
  });

  factory HomeState.initial() {
    return const HomeState(
      repositories: [],
      searchHistory: [],
      status: HomeStatus.initial,
    );
  }

  HomeState copyWith(
      {List<RepositoryModel>? repositories,
      HomeStatus? status,
      List<String>? searchHistory}) {
    return HomeState(
      repositories: repositories ?? this.repositories,
      status: status ?? this.status,
      searchHistory: searchHistory ?? this.searchHistory,
    );
  }

  @override
  List<Object> get props => [repositories, status, searchHistory];
}
