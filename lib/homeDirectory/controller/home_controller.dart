import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import '../../helper/themes.dart';
import '../../models/game_list_model.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  RxList<GameListResponseModel> gamelistresponsemodel = <GameListResponseModel>[
  ].obs;
  Database? database;
  var currentSlider = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchGameAll();
  }

  Future<void> fetchGameAll() async {
    const String url = "https://api.rawg.io/api/games";
    const String apiKey = "7a526888c8c24d8daa6f39e29182063c";

    try {
      final response = await http.get(
        Uri.parse('$url?key=$apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Response data: $data');
        gamelistresponsemodel.value = [GameListResponseModel.fromJson(data)];
        print(gamelistresponsemodel[0].results);
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching games: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void showSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 1),
      backgroundColor: primaryTextColor,
      colorText: Colors.black,
    );
  }
}