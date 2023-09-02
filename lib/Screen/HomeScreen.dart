import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/Controller/HomeScreenController.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  HomeScreenController controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text("학생 어플"),
        ),
        body: Center(
          child: homeWidget.elementAt(controller.currentIndex.value),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Setting",
            ),
          ],
          currentIndex: controller.currentIndex.value,
          onTap: (value) {
            controller.currentIndex.value = value;
          },
        ),
      ),
    );
  }

  List<Widget> homeWidget = [
    Text("Home"),
    Text("Setting"),
  ];
}
