import 'package:get/get.dart';
import 'package:sdab_jomreang/controllers/MusicPlayerController.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MusicPlayerController(), permanent: true);
  }
}
