import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:github_repos_finder/app_constants.dart';
import 'package:github_repos_finder/favourites/cubit/favorites_cubit.dart';
import 'package:github_repos_finder/home/cubit/home_cubit.dart';
import 'package:github_repos_finder/widgets/favorites_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppConstants.appLayer1,
        leading: IconButton(
          icon: AppConstants.arrowLeftIcon,
          onPressed: () => context.go('/'),
        ),
        title: const Text(AppConstants.favoriteAppBarTitle,
            style: AppConstants.textPrimarySemibold),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            if (state.favorites.isEmpty) {
              return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AppConstants.noResultIcon,
                      ),
                      const Text(
                        'You have no favorites.',
                        style: AppConstants.textSecondaryRegular,
                      ),
                      const Text(
                        'Click on star while searching to add first favorite',
                        style: AppConstants.textSecondaryRegular,
                      )
                    ]),
              );
            }
            return SlidableAutoCloseBehavior(
              child: ListView.builder(
                itemCount: state.favorites.length,
                itemBuilder: (context, index) {
                  final repositoryEntry = state.favorites[index];
                  return Padding(
                    key: UniqueKey(),
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: FavoritesCard(
                        repositoryEntry: repositoryEntry,
                        onDelete: () {
                          context
                              .read<FavoritesCubit>()
                              .deleteFavorite(repositoryEntry);
                          context
                              .read<HomeCubit>()
                              .unmarkFavorite(repositoryEntry);
                        }),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
