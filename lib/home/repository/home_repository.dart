import 'dart:convert';
import 'package:github_repos_finder/app_constants.dart';
import 'package:github_repos_finder/hive_boxes.dart';
import 'package:github_repos_finder/models/repository_model.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  List<String> getSearchHistory() {
    final List<String> searchHistory =
        searchHistoryBox.get(AppConstants.searchHistoryKey)?.cast<String>() ?? [];
    return searchHistory;
  }

  void addSearchHistory(String query) {
    final List<String> searchHistory = getSearchHistory();
    searchHistory.add(query);
    searchHistoryBox.put(AppConstants.searchHistoryKey, searchHistory.toSet().toList());
  }

  void deleteHistoryCard(String cardName) {
    final List<String> searchHistory = getSearchHistory();
    searchHistory.remove(cardName);
    searchHistoryBox.put(AppConstants.searchHistoryKey, searchHistory.toSet().toList());
  }

  Future<List<RepositoryModel>> searchRepositoriesByName(String query) async {
    final List<RepositoryModel> repositories = [];
    final queryUrl = AppConstants.gitHubRepoSearchAPIUrl +
        query +
        AppConstants.paginationParams;
    final response = await http.get(Uri.parse(queryUrl));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List items = jsonData['items'];
      for (var value in items) {
        repositories.add(RepositoryModel.fromJSON(value));
      }
    }
    return repositories;
  }

  void updateFavorites(RepositoryModel tappedRepo) {
    final List<RepositoryModel> repositories = getFavorites();
    final index = repositories.indexWhere((el) {
      return el.name == tappedRepo.name &&
          el.description == tappedRepo.description;
    });
    if (index != -1) {
      if (!tappedRepo.isFavorite) {
        repositories.removeAt(index);
        favoritesBox.put(AppConstants.favoritesKey, repositories);
      }
    } else {
      repositories.add(tappedRepo);
      favoritesBox.put(AppConstants.favoritesKey, repositories);
    }
  }

  List<RepositoryModel> getFavorites() {
    final List<RepositoryModel> repositories =
        favoritesBox.get(AppConstants.favoritesKey)?.cast<RepositoryModel>() ?? [];
    return repositories;
  }
}
