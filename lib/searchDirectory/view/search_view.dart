import 'package:flutter/material.dart';
import 'package:game_finder/widgets/bottom_navbar.dart';
import 'package:get/get.dart';
import '../../routes/route_name.dart';
import '../controller/search_controller.dart';
import '../../helper/themes.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final SearchDataController controller = Get.find<SearchDataController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Games', style: titleText.copyWith(color: Colors.white)),
        backgroundColor: primaryColor,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: controller.cSearchProduct,
              onChanged: (value) => controller.onSearchProduct(value),
              decoration: InputDecoration(
                hintText: 'Search for games...',
                hintStyle: TextStyle(color: Colors.grey[600]),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[100],
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          final games = controller.searchgameresponsemodel.isNotEmpty &&
              controller.searchgameresponsemodel[0].results.isNotEmpty
              ? controller.searchgameresponsemodel[0].results
              : controller.pagingresponsemodel.isNotEmpty &&
              controller.pagingresponsemodel[0].results.isNotEmpty
              ? controller.pagingresponsemodel[0].results
              : [];

          if (games.isEmpty) {
            return Center(child: Text('No results found.'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  itemCount: games.length.clamp(0, 5),
                  itemBuilder: (BuildContext context, int index) {
                    final game = games[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Color(0xFF212121),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              width: 80,
                              height: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(game.backgroundImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  game.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Release Date: ${game.released}", style: TextStyle(color: Colors.grey)),
                              Text("Genre: ${game.genres.map((g) => g.name).join(', ')}", style: TextStyle(color: Colors.grey)),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Text("Rating: ", style: TextStyle(color: Colors.grey)),
                                  RatingBar.builder(
                                    initialRating: game.rating! / 2,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                    itemSize: 20,
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          onTap: () {
                            Get.toNamed(RouteName.detail, arguments: game.id);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: controller.pageCount.value > 1
                          ? () {
                        controller.pageCount.value--;
                        controller.fetchGamePaging();
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF212121),
                      ),
                      child: Text('Previous'),
                    ),
                    SizedBox(width: 20),
                    Obx(() => Text(
                      'Page: ${controller.pageCount.value}',
                      style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                    )),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        controller.pageCount.value++;
                        controller.fetchGamePaging();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF212121),
                      ),
                      child: Text('Next'),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: NavbarBawah(index: 1),
    );
  }
}
