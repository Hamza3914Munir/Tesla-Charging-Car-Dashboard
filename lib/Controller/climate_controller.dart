import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ClimateController extends GetxController {
  var temperature = 20.0.obs;
  var acSpeed = 0.0.obs;
  var coolSpeed = 0.0.obs;
  var fanSpeed = 0.0.obs;
  var hotSpeed = 0.0.obs;
  var isPowerOn = false.obs;

  void togglePower() {
    isPowerOn.value = !isPowerOn.value;
  }

  void setTemperature(double newTemp) {
    temperature.value = newTemp;
  }

  void setFanSpeed(double speed) {
    fanSpeed.value = speed;
  }

  void setAcSpeed(double speed) {
    acSpeed.value = speed;
  }

  void setCoolSpeed(double speed) {
    coolSpeed.value = speed;
  }

  void setHotSpeed(double speed) {
    hotSpeed.value = speed;
  }
}
