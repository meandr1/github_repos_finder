import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:github_repos_finder/app_constants.dart';
import 'package:github_repos_finder/favourites/cubit/favorites_cubit.dart';
import 'package:github_repos_finder/favourites/favorites_screen.dart';
import 'package:github_repos_finder/favourites/repository/favorites_repository.dart';
import 'package:github_repos_finder/hive_boxes.dart';
import 'package:github_repos_finder/home/cubit/home_cubit.dart';
import 'package:github_repos_finder/home/home_screen.dart';
import 'package:github_repos_finder/home/repository/home_repository.dart';
import 'package:github_repos_finder/models/repository_model.dart';
import 'package:github_repos_finder/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top],
  );
  await Hive.initFlutter();
  Hive.registerAdapter(RepositoryModelAdapter());
  favoritesBox = await Hive.openBox<List>('favoritesBox');
  searchHistoryBox = await Hive.openBox<List>('searchHistoryBox');
  runApp(const MyApp());
}

final _router = GoRouter(
  initialLocation: '/SplashScreen',
  routes: [
    GoRoute(
      path: '/SplashScreen',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(
      path: '/FavoritesScreen',
      builder: (context, state) => const FavoritesScreen(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                HomeCubit(HomeRepository())..getSearchHistory()),
        BlocProvider(
            create: (context) =>
                FavoritesCubit(FavoritesRepository())),
      ],
      child: MaterialApp.router(
        theme: AppConstants.theme,
        routerConfig: _router,
      ),
    );
  }
}
