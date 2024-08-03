part of 'favorites_cubit.dart';

enum FavoritesStatus { initial, success, failure }

class FavoritesState extends Equatable {
  final List<RepositoryModel> favorites;
  final FavoritesStatus status;

  const FavoritesState({
    required this.favorites,
    required this.status,
  });

  factory FavoritesState.initial() {
    return const FavoritesState(
      favorites: [],
      status: FavoritesStatus.initial,
    );
  }

  FavoritesState copyWith(
      {List<RepositoryModel>? favorites, FavoritesStatus? status}) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [favorites, status];
}
