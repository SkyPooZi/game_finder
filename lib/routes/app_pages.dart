import 'package:game_finder/routes/route_name.dart';
import 'package:get/get.dart';
import '../detailDirectory/binding/detail_binding.dart';
import '../detailDirectory/view/detail_view.dart';
import '../favoriteDirectory/binding/favorite_binding.dart';
import '../favoriteDirectory/view/favorite_view.dart';
import '../homeDirectory/binding/home_binding.dart';
import '../homeDirectory/view/home_view.dart';
import '../searchDirectory/binding/search_binding.dart';
import '../searchDirectory/view/search_view.dart';

class AppPages {

  static const INITIAL = RouteName.home;

  static final pages = [
    GetPage(
      name: RouteName.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: RouteName.search,
      page: () => SearchPage(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: RouteName.detail,
      page: () => DetailPage(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: RouteName.favorite,
      page: () => FavoritePage(),
      binding: FavoriteBinding(),
    ),
  ];
}