import 'package:github_repos_finder/app_constants.dart';
import 'package:github_repos_finder/hive_boxes.dart';
import 'package:github_repos_finder/models/repository_model.dart';

class FavoritesRepository {
  void updateFavorites(List<RepositoryModel> favorites) {
    favoritesBox.put(AppConstants.favoritesKey, favorites);
  }

  List<RepositoryModel> getFavorites() {
    final List<RepositoryModel> repositories =
        favoritesBox.get(AppConstants.favoritesKey)?.cast<RepositoryModel>() ?? [];
    return repositories;
  }
}
