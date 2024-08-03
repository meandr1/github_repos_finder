import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:github_repos_finder/app_constants.dart';
import 'package:github_repos_finder/models/repository_model.dart';
import 'package:github_repos_finder/widgets/card_layout.dart';

class FavoritesCard extends StatelessWidget {
  final RepositoryModel repositoryEntry;
  final void Function() onDelete;

  const FavoritesCard(
      {super.key, required this.repositoryEntry, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Slidable(
        key: Key(repositoryEntry.name),
        endActionPane: ActionPane(
            extentRatio: 0.22,
            motion: const DrawerMotion(),
            dismissible: DismissiblePane(
              key: Key(repositoryEntry.name),
              onDismissed: () => onDelete(),
            ),
            children: [
              CustomSlidableAction(
                  backgroundColor: AppConstants.errorColor,
                  foregroundColor: AppConstants.errorColor,
                  child: AppConstants.deleteIcon,
                  onPressed: (context) => onDelete())
            ]),
        child: CardLayout(repositoryEntry: repositoryEntry));
  }
}
