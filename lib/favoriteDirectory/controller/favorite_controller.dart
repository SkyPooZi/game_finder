import 'dart:io';
import 'package:game_finder/models/favorite_model.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../../helper/themes.dart';

class FavoriteController extends GetxController {
  RxBool refreshToggle = false.obs;
  Database? database;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  Future<List<FavoriteResponseModel>> getDataFilm() async {
    String table = "game";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}/db_game";
    database = await openDatabase(path);
    final data = await database!.query(table);
    List<FavoriteResponseModel> film = data.map((e) => FavoriteResponseModel.fromJson(e)).toList();
    return film;
  }

  Future<void> deleteFilm(int id, String name) async {
    String table = "game";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}/db_game";
    database = await openDatabase(path);
    await database!.delete(table, where: "id = ?", whereArgs: [id]);
    showSnackBar('Film $name removed from favorites');
    refreshToggle.toggle();
  }
}

void showSnackBar(String message) {
  Get.snackbar(
    'Favorite Films',
    message,
    snackPosition: SnackPosition.TOP,
    duration: Duration(seconds: 1),
    backgroundColor: primaryTextColor,
    colorText: primarySecondColor,
  );
}