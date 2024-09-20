import 'package:get/get.dart';
import '../controller/search_controller.dart';

class SearchBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SearchDataController>(() => SearchDataController());
  }
}