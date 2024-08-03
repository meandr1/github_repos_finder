import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repos_finder/home/repository/home_repository.dart';
import 'package:github_repos_finder/models/repository_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;

  HomeCubit(this._homeRepository) : super(HomeState.initial());

  void setQuery(String query) {
    if (query.isNotEmpty) {
      _homeRepository.addSearchHistory(query);
      searchRepositories(query);
    } else {
      getSearchHistory();
    }
  }

  void deleteHistoryCard(String cardName) {
    emit(state.copyWith(
        searchHistory:
            state.searchHistory.where((el) => el != cardName).toList(),
        status: HomeStatus.initial));
    _homeRepository.deleteHistoryCard(cardName);
  }

  void getSearchHistory() {
    final searchHistory = _homeRepository.getSearchHistory();
    emit(state.copyWith(
        searchHistory: searchHistory, status: HomeStatus.initial));
  }

  void markAsFavorite(int index) {
    final repositories = [...state.repositories];
    final tappedRepo = repositories[index]
        .copyWith(isFavorite: !repositories[index].isFavorite);
    repositories[index] = tappedRepo;
    _homeRepository.updateFavorites(tappedRepo);
    emit(state.copyWith(repositories: repositories));
  }

  void unmarkFavorite(RepositoryModel repository) {
    final repositories = [...state.repositories];
    int index = repositories.indexWhere((el) => el == repository);
    if (index != -1) {
      repositories[index] = repository.copyWith(isFavorite: false);
      emit(state.copyWith(repositories: repositories));
    }
  }

  void searchRepositories(String query) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final repositories =
          await _homeRepository.searchRepositoriesByName(query);
      emit(state.copyWith(
          repositories: repositories, status: HomeStatus.success));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }
}
