import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../helper/themes.dart';
import '../../routes/route_name.dart';
import '../../widgets/bottom_navbar.dart';
import '../controller/home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GameFinder", style: TextStyle(color: Colors.white)), backgroundColor: Color(0xFF212121)),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              await controller.fetchGameAll();
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        if (controller.gamelistresponsemodel.isNotEmpty &&
                            controller.gamelistresponsemodel[0].results.isNotEmpty)
                          CarouselSlider.builder(
                            itemCount: controller.gamelistresponsemodel[0].results.length.clamp(0, 5),
                            itemBuilder: (context, index, realIndex) {
                              final game = controller.gamelistresponsemodel[0].results[index];
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Stack(
                                  children: [
                                    Image.network(
                                      game.backgroundImage,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                    Positioned(
                                      bottom: 10.0,
                                      left: 10.0,
                                      child: Text(
                                        game.name,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(1.0, 1.0),
                                              blurRadius: 3.0,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            options: CarouselOptions(
                              autoPlay: true,
                              enlargeCenterPage: true,
                              viewportFraction: 0.85,
                              aspectRatio: 16 / 9,
                              onPageChanged: (index, reason) {
                                controller.currentSlider.value = index;
                              },
                            ),
                          )
                        else
                          Container(
                            height: 200,
                            child: Center(child: Text("No games available", style: TextStyle(color: Colors.grey))),
                          ),
                        Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              controller.gamelistresponsemodel.isNotEmpty &&
                                  controller.gamelistresponsemodel[0].results.isNotEmpty
                                  ? controller.gamelistresponsemodel[0].results.length.clamp(0, 5)
                                  : 0,
                                  (index) => AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: controller.currentSlider.value == index ? 12.0 : 8.0,
                                height: 8.0,
                                margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: controller.currentSlider.value == index ? Color(0xFFF6243D) : Color(0xFF212121),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Top Game",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.offAllNamed(RouteName.search);
                          },
                          child: Text(
                            "See More",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    itemCount: controller.gamelistresponsemodel.isNotEmpty &&
                        controller.gamelistresponsemodel[0].results.isNotEmpty
                        ? controller.gamelistresponsemodel[0].results.length.clamp(0, 5)
                        : 0,
                    itemBuilder: (BuildContext context, int index) {
                      final game = controller.gamelistresponsemodel[0].results[index];
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
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
      }),
      bottomNavigationBar: NavbarBawah(index: 0),
    );
  }
}
