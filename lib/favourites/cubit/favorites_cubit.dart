import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repos_finder/favourites/repository/favorites_repository.dart';
import 'package:github_repos_finder/models/repository_model.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository _favoritesRepository;

  FavoritesCubit(this._favoritesRepository) : super(FavoritesState.initial());

  void deleteFavorite(RepositoryModel card) {
    final favorites = [...state.favorites.where((el) => el != card)];
    emit(state.copyWith(favorites: favorites));
    _favoritesRepository.updateFavorites(favorites);
  }

  void getFavorites() {
    try {
      final favorites = _favoritesRepository.getFavorites();
      emit(state.copyWith(
          favorites: favorites, status: FavoritesStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FavoritesStatus.failure));
    }
  }
}
