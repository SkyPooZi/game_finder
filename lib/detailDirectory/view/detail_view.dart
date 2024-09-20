import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helper/themes.dart';
import '../../widgets/bottom_navbar.dart';
import 'package:game_finder/detailDirectory/controller/detail_controller.dart';

class DetailPage extends StatelessWidget {
  DetailPage({Key? key}) : super(key: key);
  final DetailController controller = Get.find<DetailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Game", style: titleText),
        titleSpacing: 0,
        elevation: 0,
        foregroundColor: primarySecondColor,
        backgroundColor: Color(0xFF212121),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(() {
        if (controller.detailgameresponsemodel.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        final game = controller.detailgameresponsemodel.first;
        return Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Image.network(
                      game.backgroundImage,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.star, color: Color(0xFF212121), size: 25),
                        SizedBox(width: 8,),
                        Text(
                          game.rating.toString(),
                          style: subtitleText,
                        ),
                        SizedBox(width: 200,),
                        FutureBuilder<bool>(
                          future: controller.isFavorite(game.id),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return IconButton(
                                icon: Icon(
                                  snapshot.data! ? Icons.favorite : Icons.favorite_border,
                                  color: snapshot.data! ? errorColor : Colors.grey,
                                ),
                                onPressed: () {
                                  controller.addFilm(game);
                                },
                              );
                            } else {
                              return SizedBox();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      game.name,
                      style: titleText2,
                    ),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      "Description",
                      style: subtitleText,
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      game.description,
                      style: defaultText,
                    ),
                  ),
                  SizedBox(height: 28),
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      "Platform",
                      style: subtitleText,
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Wrap(
                      spacing: 8.0,
                      children: game.platforms
                          .map((platform) => Chip(
                        label: Text(platform.platform.name, style: subtitleText2,),
                        backgroundColor: primaryColor,
                      ))
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: NavbarBawah(index: 1),
    );
  }
}
