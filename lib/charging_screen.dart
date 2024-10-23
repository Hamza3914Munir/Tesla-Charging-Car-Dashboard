import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'Controller/charging_controller.dart';

class ChargingScreen extends StatefulWidget {
  @override
  State<ChargingScreen> createState() => _ChargingScreenState();
}

class _ChargingScreenState extends State<ChargingScreen> {
  final double chargePercentage = 65.0;

  final List<Map<String, String>> superchargers = [
    {"location": "Tesla Supercharger - Montreal, QC", "distance": "1.7 km"},
    {"location": "Tesla Supercharger - Mississauga, QC", "distance": "2.1 km"},
  ];

  bool _isListVisible = false;
  bool isCharging = false;

  // Boolean to manage the visibility of the list
  void _toggleListVisibility() {
    setState(() {
      _isListVisible = !_isListVisible; // Toggle the visibility
    });
  }

  @override
  Widget build(BuildContext context) {
    final chargingController = Get.put(ChargingController());

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
            'Charging',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[800],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          onPressed: () {},
          child: const Icon(
            Icons.add,
            size: 28,
            color: Colors.blue,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.grey[800],
          shape: const CircularNotchedRectangle(),
          child: Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ModeButton(
                  icon: Icons.directions_car,
                  isSelected: chargingController.selectedMode1.value == 0,
                  onTap: () => chargingController.selectMode1(0),
                ),
                ModeButton(
                  icon: Icons.flash_on,
                  isSelected: chargingController.selectedMode1.value == 1,
                  onTap: () => chargingController.selectMode1(1),
                ),
                SizedBox(width: 40), // Space for the FAB
                ModeButton(
                  icon: Icons.settings,
                  isSelected: chargingController.selectedMode1.value == 2,
                  onTap: () => chargingController.selectMode1(2),
                ),
                ModeButton(
                  icon: Icons.person,
                  isSelected: chargingController.selectedMode1.value == 3,
                  onTap: () => chargingController.selectMode1(3),
                ),
              ],
            );
          }),
        ),
        body: Column(children: [
          Material(
            elevation: 10,
            shadowColor: isCharging == true ? Colors.blue : Colors.grey,
            shape: OvalBorder(),
            // Changed from OvalBorder to CircleBorder
            color: Colors.transparent,
            child: ClipOval(
                child: CircularImageAnimation()), // Replace with actual widget
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 50),
              Text(
                "$chargePercentage",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(width: 5),
              Text(
                "%",
                style: TextStyle(color: Colors.white70, fontSize: 20),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                child: Card(
                  color: isCharging == true ? Colors.blue : Colors.grey,
                  elevation: 50,
                ),
                margin: EdgeInsets.only(left: 50),
                height: 60,
                width: 160,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: isCharging == true
                          ? Colors.blueAccent.withOpacity(0.5)
                          : Colors.grey.withOpacity(0.5),
                      spreadRadius: 5, // Shadow size
                      blurRadius: 5, // Shadow softness
                      offset: Offset(0, -20), // Shadow downwards
                    ),
                  ],
                  color: isCharging == true ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                  child: Card(
                    color: Colors.grey[800],
                    elevation: 50,
                  ),
                  margin: EdgeInsets.only(right: 20),
                  height: 60,
                  width: 110,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ))
            ],
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 50,
            child: ToggleSwitch(
              minWidth: 90.0,
              cornerRadius: 20.0,
              activeBgColors: [
                [Colors.blue],   // Blue when "Start" is active
                [Colors.black26] // Black26 when "Stop" is active
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              initialLabelIndex: isCharging ? 0 : 1,
              totalSwitches: 2,
              labels: ['Start', 'Stop'],
              radiusStyle: true,
              onToggle: (index) {
                setState(() {
                  isCharging = index == 0;
                  chargingController.toggleCharging(isCharging); // Update the controller
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: _isListVisible == false
                    ? BorderRadius.circular(24)
                    : BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Nearby Superchargers',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        icon: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[800],
                          ),
                          child: Icon(
                            _isListVisible
                                ? Icons.expand_less
                                : Icons.expand_more,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: _toggleListVisibility,
                      ),
                    ],
                  ),
                  Visibility(
                    visible: _isListVisible,
                    child: Container(
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: _isListVisible
                            ? BorderRadius.circular(24)
                            : BorderRadius.vertical(
                                bottom: Radius.circular(24)),
                      ),
                      child: ListView.builder(
                        itemCount: superchargers.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading:
                                Icon(Icons.location_on, color: Colors.blue),
                            title: Text(
                              superchargers[index]["location"]!,
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              superchargers[index]["distance"]!,
                              style: TextStyle(color: Colors.grey),
                            ),
                            trailing:
                                Icon(Icons.chevron_right, color: Colors.white),
                            onTap: () {},
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ))
        ]));
  }
}

class ModeButton extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const ModeButton({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey.shade800,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(16),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
