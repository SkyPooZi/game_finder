import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:game_finder/models/paging_model.dart';
import 'package:game_finder/models/search_game_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchDataController extends GetxController {
  RxList<PagingResponseModel> pagingresponsemodel = <PagingResponseModel>[].obs;
  RxList<SearchGameResponseModel> searchgameresponsemodel = <SearchGameResponseModel>[].obs;
  TextEditingController? cSearchProduct;
  RxBool isLoading = true.obs;
  RxInt pageCount = 1.obs;
  RxString currentSearchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    cSearchProduct = TextEditingController();
    fetchGamePaging();
  }

  Future<void> fetchGameSearch(String searchText) async {
    if (searchText.isNotEmpty) {
      const String url = "https://api.rawg.io/api/games";
      const String apiKey = "7a526888c8c24d8daa6f39e29182063c";

      try {
        final encodedSearchText = Uri.encodeComponent(searchText);
        final response = await http.get(Uri.parse('$url?search=$encodedSearchText&key=$apiKey'));
        print('$url?search=$encodedSearchText&key=$apiKey');

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          print('Raw data response: $data');

          searchgameresponsemodel.value = [SearchGameResponseModel.fromJson(data)];

          if (searchgameresponsemodel.isNotEmpty) {
            print('Game search results:');
            searchgameresponsemodel[0].results?.forEach((game) {
              print('Game Name: ${game.name}, Released: ${game.released}, Rating: ${game.rating}');
            });
          } else {
            print('No results found.');
          }

          pagingresponsemodel.value = [];
        } else {
          print('Error: ${response.statusCode}');
        }
      } catch (e) {
        print('Error occurred: $e');
      } finally {
        isLoading.value = false;
      }
    } else {
      fetchGamePaging();
    }
  }

  void onSearchProduct(String searchText) {
    currentSearchText.value = searchText;
    fetchGameSearch(searchText);
  }

  Future<void> fetchGamePaging() async {
    const String url = "https://api.rawg.io/api/games";
    const String apiKey = "7a526888c8c24d8daa6f39e29182063c";

    try {
      String requestUrl;
      if (currentSearchText.value.isNotEmpty) {
        final encodedSearchText = Uri.encodeComponent(currentSearchText.value);
        requestUrl = '$url?search=$encodedSearchText&page=${pageCount.value}&page_size=10&key=$apiKey';
      } else {
        requestUrl = '$url?page=${pageCount.value}&page_size=10&key=$apiKey';
      }

      final response = await http.get(Uri.parse(requestUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        if (currentSearchText.value.isNotEmpty) {
          searchgameresponsemodel.value = [SearchGameResponseModel.fromJson(data)];
          pagingresponsemodel.value = [];
        } else {
          pagingresponsemodel.value = [PagingResponseModel.fromJson(data)];
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
