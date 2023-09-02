import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/Controller/HomeScreenController.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const double outPadding = 32.0;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Theme.of(context).colorScheme.primary,
      ),
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
            Colors.white10,
            Colors.white10,
            Colors.black12,
            Colors.black12,
            Colors.black12,
          ]),
        ),
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text("학생 어플"),
          ),
          drawer: const NavigationDrawer(),
          body: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(outPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: outPadding,
                      ),
                      Text(
                        "안녕하세요 성현님",
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "과제 완료까지 10문제 남았습니다",
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: outPadding,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: MyContainer(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '과제',
                                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '15/40',
                                          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: outPadding,
                                ),
                                Flexible(
                                  flex: 2,
                                  child: MyContainer(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '프로필',
                                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                            const SizedBox(
                              width: outPadding,
                            ),
                            Flexible(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: MyContainer(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '오답노트',
                                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: outPadding,
                                ),
                                Flexible(
                                  flex: 3,
                                  child: MyContainer(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '커뮤니티 또는 \n주변 학원/과외 알아보기 \n 들어갈 자리',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16)
                    ],
                  ))))
    ]);
  }
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
        padding: const EdgeInsets.all(16),
        child: Wrap(
          runSpacing: 8,
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('home'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('home'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('home'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('home'),
              onTap: () {},
            ),
          ],
        ),
      );
}

class MyContainer extends StatelessWidget {
  const MyContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(16), color: Theme.of(context).colorScheme.primaryContainer, boxShadow: [
        BoxShadow(
          color: Theme.of(context).colorScheme.shadow.withAlpha(130),
          blurRadius: 8.0, // soften the shadow
          spreadRadius: 4.0, //extend the shadow
          offset: const Offset(
            8.0, // Move to right 10  horizontally
            8.0, // Move to bottom 10 Vertically
          ),
        ),
        BoxShadow(
          color: Colors.white.withAlpha(130),
          blurRadius: 8.0, // soften the shadow
          spreadRadius: 4.0, //extend the shadow
          offset: const Offset(
            -8.0, // Move to right 10  horizontally
            -8.0, // Move to bottom 10 Vertically
          ),
        ),
      ]),
      child: child,
    );
  }
}
