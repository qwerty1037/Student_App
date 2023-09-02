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
        drawer: NavigationDrawer(),
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

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: EdgeInsets.all(16),
        child: Wrap(
          runSpacing: 8,
          children: [
            ListTile(
              leading: Icon(Icons.home_outlined),
              title: Text('home'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.home_outlined),
              title: Text('home'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.home_outlined),
              title: Text('home'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.home_outlined),
              title: Text('home'),
              onTap: () {},
            ),
          ],
        ),
      );
}
