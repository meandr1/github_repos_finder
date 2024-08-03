import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:github_repos_finder/favourites/cubit/favorites_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:github_repos_finder/app_constants.dart';
import 'package:github_repos_finder/home/cubit/home_cubit.dart';
import 'package:github_repos_finder/widgets/hystory_card.dart';
import 'package:github_repos_finder/widgets/search_result_card.dart';
import 'package:github_repos_finder/widgets/search_text_input.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppConstants.appLayer1,
        title: const Text(AppConstants.homeAppBarTitle,
            style: AppConstants.textPrimarySemibold),
        centerTitle: true,
        actions: [
          IconButton(
            icon: AppConstants.favoriteIconBlank,
            onPressed: () {
              context.go('/FavoritesScreen');
              context.read<FavoritesCubit>().getFavorites();
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: SearchTextInput(
                    focusNode: focusNode,
                    controller: controller,
                    onChanged: context.read<HomeCubit>().setQuery,
                  ),
                ),
                getTextWidget(state),
                if (state.status == HomeStatus.loading)
                  Center(
                    child: Platform.isIOS
                        ? const CupertinoActivityIndicator()
                        : const CircularProgressIndicator(),
                  ),
                if (state.status == HomeStatus.success)
                  if (state.repositories.isEmpty)
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppConstants.noResultIcon,
                          ),
                          const Text(
                            'Nothing was found for your search.',
                            style: AppConstants.textSecondaryRegular,
                          ),
                          const Text(
                            'Please check the spelling',
                            style: AppConstants.textSecondaryRegular,
                          ),
                        ],
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.repositories.length,
                        itemBuilder: (context, index) {
                          final repositoryEntry = state.repositories[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: SearchResultCard(
                              repositoryEntry: repositoryEntry,
                              onTap: () {
                                context.read<HomeCubit>().markAsFavorite(index);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                if (state.status == HomeStatus.initial)
                  if (state.searchHistory.isEmpty)
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppConstants.noResultIcon,
                          ),
                          const Text(
                            'You have empty history.',
                            style: AppConstants.textSecondaryRegular,
                          ),
                          const Text(
                            'Click on search to start the journey!',
                            style: AppConstants.textSecondaryRegular,
                          ),
                        ],
                      ),
                    )
                  else
                    Expanded(
                      child: SlidableAutoCloseBehavior(
                        child: ListView.builder(
                          itemCount: state.searchHistory.length,
                          itemBuilder: (context, index) {
                            final searchEntry = state.searchHistory[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: HistoryCard(
                                title: searchEntry,
                                onCardDelete: () => context
                                    .read<HomeCubit>()
                                    .deleteHistoryCard(searchEntry),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                if (state.status == HomeStatus.failure)
                  const Center(
                    child: Text(
                      'Something went wrong',
                      style: AppConstants.textSecondaryRegular,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget getTextWidget(HomeState state) {
    final String? text = state.status == HomeStatus.success
        ? 'What we found'
        : state.status == HomeStatus.initial
            ? 'Search history'
            : null;
    if (text == null) return const SizedBox.shrink();
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Text(text, style: AppConstants.textPrimarySemiboldGreen),
      ),
    );
  }
}
