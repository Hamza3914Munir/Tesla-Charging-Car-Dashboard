import 'package:get/get.dart';

class CarController extends GetxController {
  var selectedMode = 0.obs; // 0: Fan, 1: Light, etc.
  var selectedMode1 = 0.obs;

  void selectMode(int index) {
    selectedMode.value = index;
  }
  void selectMode1(int index) {
    selectedMode1.value = index;
  }
}
