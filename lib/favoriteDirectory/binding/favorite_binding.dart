import 'package:get/get.dart';
import '../controller/favorite_controller.dart';

class FavoriteBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<FavoriteController>(() => FavoriteController());
  }
}