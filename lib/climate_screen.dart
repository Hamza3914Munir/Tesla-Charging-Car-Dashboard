import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'Controller/climate_controller.dart';
import 'Slider.dart';

class ClimateScreen extends StatelessWidget {
  final ClimateController climateController = Get.put(ClimateController());
  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 100.0,
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white70.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 4), // Shadow position
              ),
            ],
          ),
          child: Material(
            elevation: 4,
            shape: CircleBorder(),
            color: Colors.grey.shade900,
            child: IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: Colors.grey[300],
              ),
              onPressed: () {
                Get.back(); // Navigate to the previous screen
              },
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white70.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, 4), // Shadow position
                  ),
                ],
              ),
              child: Material(
                elevation: 4,
                shape: CircleBorder(),
                color: Colors.grey.shade900,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(
                    Icons.settings,
                    color: Colors.grey[300],
                  ),
                ),
              ),
            ),
          )
        ],
        backgroundColor: Colors.black,
        title: Text(
          'Climate',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 35,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Circular Temperature Dial with Progress Bar
                      Obx(
                            () {
                          _valueNotifier.value =
                              (climateController.temperature.value - 16) * (100 / 16);
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: climateController.isPowerOn.value
                                      ? Colors.blueAccent.withOpacity(0.5)
                                      : Colors.transparent, // Null color when power is off
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: Offset(2, 0), // Shadow position
                                ),
                              ],
                            ),
                            child: DashedCircularProgressBar(
                              width: 200,
                              height: 200,
                              valueNotifier: _valueNotifier,
                              progress: _valueNotifier.value,
                              maxProgress: 100,
                              corners: StrokeCap.round,
                              foregroundColor: climateController.isPowerOn.value
                                  ? Colors.blue
                                  : Colors.grey.shade800, // Change color based on power state
                              backgroundColor: Colors.grey.shade800,
                              foregroundStrokeWidth: 16,
                              backgroundStrokeWidth: 16,
                              animation: true,
                              child: Center(
                                child: Container(
                                  width: 120, // Adjust the size as needed
                                  height: 120, // Adjust the size as needed
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle, // Circle shape
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white70.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 10,
                                        offset: Offset(1, 0), // Shadow position
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.grey.shade900,
                                    shape: CircleBorder(),
                                    elevation: 30.0,
                                    child: Center(
                                      child: Text(
                                        '${climateController.temperature.value.toStringAsFixed(0)}°C',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Container(
                        height: 230,
                        child: SingleChildScrollView(
                          child: Expanded(
                            child: Column(
                              children: [
                                SizedBox(height: 32),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'AC',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Obx(
                                      () => Container(
                                        margin: EdgeInsets.only(left: 19),
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[800],
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.ac_unit,
                                          color:
                                              climateController.isPowerOn.value == true
                                                  ? Colors.blue
                                                  : Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Obx(
                                        () => SliderTheme(
                                          data:
                                              SliderTheme.of(context).copyWith(
                                            activeTrackColor: climateController.isPowerOn.value == true
                                                ? Colors.blue
                                                : Colors.white,
                                            inactiveTrackColor:
                                                Colors.grey.shade900,
                                            trackHeight: 8.0,
                                            thumbColor: Colors.grey[800],
                                            thumbShape:
                                                RectangularSliderThumbShape(),
                                            overlayColor:
                                                Colors.blue.withAlpha(32),
                                            overlayShape:
                                                RoundSliderOverlayShape(
                                              overlayRadius: 28.0,
                                            ),
                                            tickMarkShape:
                                                RoundSliderTickMarkShape(),
                                            activeTickMarkColor: Colors.blue,
                                            inactiveTickMarkColor:
                                                Colors.grey.shade800,
                                          ),
                                          child: Slider(
                                            value:
                                                climateController.acSpeed.value,
                                            min: 0,
                                            max: 3,
                                            divisions: 3,
                                            label:
                                                '${climateController.acSpeed.value.toStringAsFixed(1)}',
                                            onChanged: (value) {
                                              climateController
                                                  .setAcSpeed(value);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Fan',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Obx(
                                      () => Container(
                                        margin: EdgeInsets.only(left: 14),
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[800],
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.wind_power,
                                          color:
                                          climateController.isPowerOn.value == true
                                                  ? Colors.blue
                                                  : Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Obx(
                                        () => SliderTheme(
                                          data:
                                              SliderTheme.of(context).copyWith(
                                            activeTrackColor: climateController.isPowerOn.value == true
                                                ? Colors.blue
                                                : Colors.white,
                                            inactiveTrackColor:
                                                Colors.grey.shade900,
                                            trackHeight: 8.0,
                                            thumbColor: Colors.grey[800],
                                            thumbShape:
                                                RectangularSliderThumbShape(),
                                            overlayColor:
                                                Colors.blue.withAlpha(32),
                                            overlayShape:
                                                RoundSliderOverlayShape(
                                              overlayRadius: 28.0,
                                            ),
                                            tickMarkShape:
                                                RoundSliderTickMarkShape(),
                                            activeTickMarkColor: Colors.blue,
                                            inactiveTickMarkColor:
                                                Colors.grey.shade800,
                                          ),
                                          child: Slider(
                                            value: climateController
                                                .fanSpeed.value,
                                            min: 0,
                                            max: 3,
                                            divisions: 3,
                                            label:
                                                '${climateController.fanSpeed.value.toStringAsFixed(1)}',
                                            onChanged: (value) {
                                              climateController
                                                  .setFanSpeed(value);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Cool',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Obx(
                                      () => Container(
                                        margin: EdgeInsets.only(left: 10),
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[800],
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.severe_cold,
                                          color: climateController.isPowerOn.value == true
                                              ? Colors.blue
                                              : Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Obx(
                                        () => SliderTheme(
                                          data:
                                              SliderTheme.of(context).copyWith(
                                            activeTrackColor: climateController.isPowerOn.value == true
                                                ? Colors.blue
                                                : Colors.white,
                                            inactiveTrackColor:
                                                Colors.grey.shade900,
                                            trackHeight: 8.0,
                                            thumbColor: Colors.grey[800],
                                            thumbShape:
                                                RectangularSliderThumbShape(),
                                            overlayColor:
                                                Colors.blue.withAlpha(32),
                                            overlayShape:
                                                RoundSliderOverlayShape(
                                              overlayRadius: 28.0,
                                            ),
                                            tickMarkShape:
                                                RoundSliderTickMarkShape(),
                                            activeTickMarkColor:climateController.isPowerOn.value == true
                                                ? Colors.blue
                                                : Colors.white,
                                            inactiveTickMarkColor:
                                                Colors.grey.shade800,
                                          ),
                                          child: Slider(
                                            value: climateController
                                                .coolSpeed.value,
                                            min: 0,
                                            max: 3,
                                            divisions: 3,
                                            label:
                                                '${climateController.coolSpeed.value.toStringAsFixed(1)}',
                                            onChanged: (value) {
                                              climateController
                                                  .setCoolSpeed(value);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hot',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Obx(
                                      () => Container(
                                        margin: EdgeInsets.only(left: 10),
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[800],
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.sunny,
                                          color:
                                          climateController.isPowerOn.value == true
                                                  ? Colors.blue
                                                  : Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Obx(
                                        () => SliderTheme(
                                          data:
                                              SliderTheme.of(context).copyWith(
                                            activeTrackColor:climateController.isPowerOn.value == true
                                                ? Colors.blue
                                                : Colors.white,
                                            inactiveTrackColor:
                                                Colors.grey.shade900,
                                            trackHeight: 8.0,
                                            thumbColor: Colors.grey[800],
                                            thumbShape:
                                                RectangularSliderThumbShape(),
                                            overlayColor:
                                                Colors.blue.withAlpha(32),
                                            overlayShape:
                                                RoundSliderOverlayShape(
                                              overlayRadius: 28.0,
                                            ),
                                            tickMarkShape:
                                                RoundSliderTickMarkShape(),
                                            activeTickMarkColor: Colors.blue,
                                            inactiveTickMarkColor:
                                                Colors.grey.shade800,
                                          ),
                                          child: Slider(
                                            value: climateController
                                                .hotSpeed.value,
                                            min: 0,
                                            max: 3,
                                            divisions: 3,
                                            label:
                                                '${climateController.hotSpeed.value.toStringAsFixed(1)}',
                                            onChanged: (value) {
                                              climateController
                                                  .setHotSpeed(value);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(20),
              height: 180,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Power Icon with 'On' or 'Off' text
                      Obx(
                        () => IconButton(
                          icon: Icon(
                            Icons.power_settings_new,
                            color: climateController.isPowerOn.value
                                ? Colors.cyanAccent
                                : Colors.white,
                            size: 28.0,
                          ),
                          onPressed: () {
                            climateController.togglePower();
                          },
                        ),
                      ),

                      // Left Arrow Icon to decrease temperature
                      IconButton(
                        icon: Icon(Icons.chevron_left,
                            color: Colors.white, size: 28.0),
                        onPressed: () {
                          if (climateController.temperature.value > 16) {
                            climateController.setTemperature(
                                climateController.temperature.value - 1);
                          }
                        },
                      ),

                      // Temperature Display
                      Obx(
                        () => Text(
                          '${climateController.temperature.value.toStringAsFixed(0)}°',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Right Arrow Icon to increase temperature
                      IconButton(
                        icon: Icon(Icons.chevron_right,
                            color: Colors.white, size: 28.0),
                        onPressed: () {
                          if (climateController.temperature.value < 32) {
                            climateController.setTemperature(
                                climateController.temperature.value + 1);
                          }
                        },
                      ),

                      Icon(
                        Icons.air,
                        color: Colors.white,
                        size: 28.0,
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            climateController.isPowerOn.value ? 'On' : 'Off',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Vent',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
