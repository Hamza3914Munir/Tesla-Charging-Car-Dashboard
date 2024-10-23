import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Controller/car_controller.dart'; // Import the controller
import 'charging_screen.dart';
import 'climate_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: CarScreen(),
    );
  }
}

class CarScreen extends StatelessWidget {
  final CarController controller = Get.put(CarController()); // Use a single controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Car Info Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tesla',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.battery_4_bar_sharp, color: Colors.grey),
                          Text(
                            '187 km',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Material(
                    elevation: 10.0,
                    shadowColor: Colors.white,
                    shape: CircleBorder(),
                    color: Colors.white,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade800,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Placeholder for Car Image
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              margin: EdgeInsets.all(20),
              width: double.infinity,
              child: Center(
                child: Material(
                  elevation: 10,
                  shadowColor: Colors.grey,
                  shape: OvalBorder(),
                  color: Colors.transparent,
                  child: ClipOval(
                    child: Image.asset(
                      'lib/assets/img_1.png',
                      height: 150,
                      width: 300,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            // Mode Selection Buttons
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              margin: EdgeInsets.all(20),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Obx(
                      () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ModeButton(
                        icon: Icons.lock,
                        isSelected: controller.selectedMode.value == 0,
                        onTap: () => controller.selectMode(0),
                      ),
                      SizedBox(width: 16),
                      ModeButton(
                        icon: Icons.ac_unit,
                        isSelected: controller.selectedMode.value == 1,
                        onTap: () => controller.selectMode(1),
                      ),
                      SizedBox(width: 16),
                      ModeButton(
                        icon: Icons.flash_on,
                        isSelected: controller.selectedMode.value == 2,
                        onTap: () => controller.selectMode(2),
                      ),
                      SizedBox(width: 16),
                      ModeButton(
                        icon: Icons.wind_power,
                        isSelected: controller.selectedMode.value == 3,
                        onTap: () => controller.selectMode(3),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            // Control Panel
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      offset: Offset(0, -1), // Adjusts the shadow upwards
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.ac_unit, color: Colors.white),
                        title: Text(
                          'Climate',
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Interior 20°C',
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing: Icon(Icons.chevron_right, color: Colors.white),
                        onTap: () {
                          Get.to(() => ClimateScreen());
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.bolt, color: Colors.white),
                        title: Text(
                          'Charging',
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Battery 65%',
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing: Icon(Icons.chevron_right, color: Colors.white),
                        onTap: () {
                          Get.to(() => ChargingScreen());
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.location_on, color: Colors.white),
                        title: Text(
                          'Location',
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Lahore',
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing: Icon(Icons.chevron_right, color: Colors.white),
                        onTap: () {
                          Get.to(() => ClimateScreen());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Obx(
            () => BottomAppBar(
          color: Colors.black,
          shape: CircularNotchedRectangle(), // Creates the notch
          notchMargin: 8.0, // Margin between the notch and the floating action button
          child: Container(decoration: BoxDecoration(
            color: Colors.grey.shade900,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.5),
                offset: Offset(0, 2), // Adjusts the shadow downwards
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.directions_car,
                      color: controller.selectedMode1.value == 0
                          ? Colors.blue
                          : Colors.white,
                    ),
                    onPressed: () => controller.selectMode1(0),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.flash_on,
                      color: controller.selectedMode1.value == 1
                          ? Colors.blue
                          : Colors.white,
                    ),
                    onPressed: () => controller.selectMode1(1),
                  ),
                  SizedBox(width: 40), // The middle space for the FAB
                  IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: controller.selectedMode1.value == 2
                          ? Colors.blue
                          : Colors.white,
                    ),
                    onPressed: () => controller.selectMode1(2),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.person,
                      color: controller.selectedMode1.value == 3
                          ? Colors.blue
                          : Colors.white,
                    ),
                    onPressed: () => controller.selectMode1(3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.6),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Icon(Icons.add, color: Colors.white, size: 32),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked, // Centers the FAB
    );
  }
}

// Custom Widget for Mode Button
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