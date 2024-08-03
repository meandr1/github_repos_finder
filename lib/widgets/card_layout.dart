import 'package:flutter/material.dart';
import 'package:github_repos_finder/app_constants.dart';
import 'package:github_repos_finder/models/repository_model.dart';

class CardLayout extends StatelessWidget {
  const CardLayout({
    super.key,
    required this.repositoryEntry,
    this.onTap,
  });

  final Function()? onTap;
  final RepositoryModel repositoryEntry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: AppConstants.appLayer2,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      repositoryEntry.name,
                      style: AppConstants.textPrimaryRegular,
                    ),
                    Text(
                      repositoryEntry.description,
                      overflow: TextOverflow.ellipsis,
                      style: AppConstants.textSecondaryRegular,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              repositoryEntry.isFavorite
                  ? AppConstants.favoriteIconGreen
                  : AppConstants.favoriteIconGrey,
            ],
          ),
        ),
      ),
    );
  }
}
