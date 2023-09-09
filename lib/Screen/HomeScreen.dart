import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/Component/Config.dart';
import 'package:student_app/Component/HomeDrawer.dart';
import 'package:student_app/Component/HomeNavigator.dart';
import 'package:student_app/Screen/HomeWorkListScreen.dart';
import 'package:student_app/Screen/SettingScreen.dart';
// import 'package:student_app/test/SettingScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Theme.of(context).colorScheme.primary,
      ),
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
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
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
        drawer: const HomeDrawer(),
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
                  "성현님,",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "과제 완료까지 10문제 남았습니다",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold),
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
                            child: HomeNavigator(
                              onPressed: () {
                                Get.to(() => const HomeWorkListScreen());
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '과제',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '15/40',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer),
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
                            child: HomeNavigator(
                              onPressed: () {
                                Get.to(() => SettingScreen());
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '설정',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer,
                                            fontWeight: FontWeight.bold),
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
                            child: HomeNavigator(
                              onPressed: () {
                                debugPrint("오답노트 클릭");
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '오답노트',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer,
                                            fontWeight: FontWeight.bold),
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
                            child: HomeNavigator(
                              onPressed: () {
                                debugPrint("커뮤니티 클릭");
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '커뮤니티 또는 \n주변 학원/과외 알아보기 \n 들어갈 자리',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer,
                                            fontWeight: FontWeight.bold),
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
            ),
          ),
        ),
      ),
    ]);
  }
}
