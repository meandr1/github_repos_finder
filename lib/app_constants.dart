import 'package:flutter/material.dart';

abstract class AppConstants {
  static const String gitHubRepoSearchAPIUrl =
      'https://api.github.com/search/repositories?q=';
  static const String paginationParams = '&per_page=15&page=1';

  static const String favoritesKey = 'favorites';
  static const String searchHistoryKey = 'searchHistory';

  static const int searchDelay = 800;

  static ThemeData theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: appPrimary),
    scaffoldBackgroundColor: backgroundPrimary,
  );

  static const Color backgroundPrimary = Color(0xFFFAFAFC);
  static const Color appPrimary = Color(0xFF0CC509);
  static const Color appLayer1 = Color(0x42FFFFFF);
  static const Color appLayer2 = Color(0xFFF1F2F6);
  static const Color appLayer3 = Color(0x0D0CC509);
  static const Color appLayer4 = Color(0xFFF2F2F2);
  static const Color textPrimaryColor = Color(0xFF1C2027);
  static const Color textPlaceholderColor = Color(0xFFBFBFBF);
  static const Color errorColor = Color(0xFFEA1A1A);
  static const Color iconColor = Color(0xFF1C2027);

  static const TextStyle textPrimarySemibold = TextStyle(
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      fontSize: 16.0,
      fontFamily: 'Sora',
      color: textPrimaryColor);

  static const TextStyle textPrimarySemiboldGreen = TextStyle(
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      fontSize: 16.0,
      fontFamily: 'Sora',
      color: appPrimary);

  static const TextStyle textPrimaryRegular = TextStyle(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: 16.0,
      fontFamily: 'Sora',
      color: textPrimaryColor);
  static const TextStyle textSecondaryRegular = TextStyle(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: 14.0,
      fontFamily: 'Sora',
      color: textPlaceholderColor);

  static Container favoriteIconBlank = Container(
      width: 44,
      height: 44,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: appPrimary),
      child: SizedBox(
        width: 24.0,
        height: 24.0,
        child: Image.asset('assets/icons/Favorite_blank.png'),
      ));
  static SizedBox favoriteIconGreen = SizedBox(
    width: 24.0,
    height: 24.0,
    child: Image.asset('assets/icons/Favorite_green.png'),
  );
  static SizedBox favoriteIconGrey = SizedBox(
    width: 24.0,
    height: 24.0,
    child: Image.asset('assets/icons/Favorite_grey.png'),
  );
  static SizedBox deleteIcon = SizedBox(
    width: 24.0,
    height: 24.0,
    child: Image.asset('assets/icons/Delete.png'),
  );

  static Container arrowLeftIcon = Container(
      width: 44,
      height: 44,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: appPrimary),
      child: SizedBox(
        width: 24.0,
        height: 24.0,
        child: Image.asset('assets/icons/Arrow_left.png'),
      ));
  static SizedBox searchIcon = SizedBox(
    width: 24.0,
    height: 24.0,
    child: Image.asset('assets/icons/Search.png'),
  );
  static SizedBox closeIcon = SizedBox(
    width: 24.0,
    height: 24.0,
    child: Image.asset('assets/icons/Close.png'),
  );
  static SizedBox banIcon = SizedBox(
    width: 24.0,
    height: 24.0,
    child: Image.asset('assets/icons/Ban.png'),
  );
  static SizedBox noResultIcon = SizedBox(
    width: 36.0,
    height: 32.0,
    child: Image.asset('assets/icons/no_result.png'),
  );

  static const String homeAppBarTitle = 'Github repos list';
  static const String favoriteAppBarTitle = 'Favorite repos list';
}
