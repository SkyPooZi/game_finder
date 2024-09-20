import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../helper/themes.dart';
import '../../models/favorite_model.dart';
import '../../widgets/bottom_navbar.dart';
import '../controller/favorite_controller.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({Key? key}) : super(key: key);
  final FavoriteController controller = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Favorite Games",
          style: titleText,
        ),
        backgroundColor: primaryColor,
      ),
      body: Obx(() => controller.refreshToggle.value
          ? RefreshIndicator(
        onRefresh: () async {
          await controller.getDataFilm();
          controller.refreshToggle.toggle();
        },
        child: FutureBuilder<List<FavoriteResponseModel>>(
          future: controller.getDataFilm(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  "No Data Available",
                  style: defaultText,
                ),
              );
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  FavoriteResponseModel game = snapshot.data![index];
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
                                image: NetworkImage(game.image!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                game.name!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: errorColor,
                              ),
                              onPressed: () {
                                controller.deleteFilm(game.id!, game.name!);
                              },
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Release Date: ${game.release!}", style: TextStyle(color: Colors.grey)),
                            Text("Genre: ${game.genre!}", style: TextStyle(color: Colors.grey)),
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
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      )
          : RefreshIndicator(
        onRefresh: () async {
          await controller.getDataFilm();
          controller.refreshToggle.value;
        },
        child: FutureBuilder<List<FavoriteResponseModel>>(
          future: controller.getDataFilm(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color: accentColor));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  "No Data Available",
                  style: defaultText,
                ),
              );
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  FavoriteResponseModel game = snapshot.data![index];
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
                                image: NetworkImage(game.image!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                game.name!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: errorColor,
                              ),
                              onPressed: () {
                                controller.deleteFilm(game.id!, game.name!);
                              },
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Release Date: ${game.release!}", style: TextStyle(color: Colors.grey)),
                            Text("Genre: ${game.genre!}", style: TextStyle(color: Colors.grey)),
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
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      )),
      bottomNavigationBar: NavbarBawah(index: 2),
    );
  }
}
