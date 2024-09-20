  import 'dart:convert';
  import 'dart:io';
  import 'package:get/get.dart';
  import 'package:path_provider/path_provider.dart';
  import 'package:sqflite/sqflite.dart';
  import 'package:http/http.dart' as http;
  import '../../helper/themes.dart';
  import '../../models/detail_game_model.dart';

  class DetailController extends GetxController {
    RxList<DetailGameResponseModel> detailgameresponsemodel = <DetailGameResponseModel>[].obs;
    Database? database;
    final int gameId = Get.arguments;

    @override
    void onInit() {
      super.onInit();
      initDatabase();
      fetchGameDetail();
    }

    Future<void> fetchGameDetail() async {
      const String url = "https://api.rawg.io/api/games/";
      const String apiKey = "7a526888c8c24d8daa6f39e29182063c";

      try {
        final response = await http.get(
          Uri.parse('$url$gameId?key=$apiKey'),
          headers: {
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          detailgameresponsemodel.value = [DetailGameResponseModel.fromJson(data)];
          print(data);
        } else {
          print('Error: ${response.statusCode}');
          showSnackBar('Error', 'Failed to load game details');
        }
      } catch (e) {
        print(e);
        showSnackBar('Error', 'An error occurred while fetching game details');
      }
    }

    void initDatabase() async {
      String db_name = "db_game";
      int db_version = 1;
      String table = "game";
      Directory directory = await getApplicationDocumentsDirectory();
      String path = '${directory.path}/$db_name';

      if (database == null) {
        database = await openDatabase(path, version: db_version, onCreate: (db, version) {
          db.execute('''          
  CREATE TABLE IF NOT EXISTS $table (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    genre VARCHAR(255),
    release VARCHAR(255),
    rating DOUBLE,
    description VARCHAR(255),
    image VARCHAR(255),
    platform VARCHAR(255)
  )''');
        });
      }
    }

    void addFilm(DetailGameResponseModel game) async {
      String db_name = "db_game";
      String table = "game";
      Directory directory = await getApplicationDocumentsDirectory();
      String path = '${directory.path}/$db_name';
      database = await openDatabase(path);
      var result = await database!.query(table, where: 'id = ?', whereArgs: [game.id]);

      if (result.isEmpty) {
        await database!.insert(table, {
          'id': game.id,
          'image': game.backgroundImage,
          'name': game.name,
          'release': game.released.toIso8601String(),
          'genre': game.platforms.map((platform) => platform.platform.name).join(', '),
          'rating': game.rating.toDouble(),
          'description': game.description,
          'platform': game.platforms.map((platform) => platform.platform.name).join(', '),
        });
        showSnackBar('Favorit', 'Game ${game.name} ditambahkan ke favorit');
      } else {
        await database!.delete(table, where: "id = ?", whereArgs: [game.id]);
        showSnackBar('Favorit', 'Game ${game.name} dihapus dari favorit');
      }

      refresh();
      fetchGameDetail();
    }

    Future<bool> isFavorite(int gameId) async {
      var result = await database!.query('game', where: 'id = ?', whereArgs: [gameId]);
      return result.isNotEmpty;
    }
  }

  void showSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 1),
      backgroundColor: primaryTextColor,
      colorText: primarySecondColor,
    );
  }

