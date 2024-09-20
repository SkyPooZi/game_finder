import 'package:get/get.dart';
import '../controller/detail_controller.dart';

class DetailBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<DetailController>(() => DetailController());
  }
}