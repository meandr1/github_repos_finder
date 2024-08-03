import 'package:flutter/material.dart';
import 'package:github_repos_finder/models/repository_model.dart';
import 'package:github_repos_finder/widgets/card_layout.dart';

class SearchResultCard extends StatelessWidget {
  final RepositoryModel repositoryEntry;
  final void Function() onTap;

  const SearchResultCard(
      {super.key, required this.repositoryEntry, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CardLayout(repositoryEntry: repositoryEntry, onTap: onTap);
  }
}
