import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/Component/Config.dart';
import 'package:student_app/Component/HomeDrawer.dart';
import 'package:student_app/Component/HomeNavigator.dart';
import 'package:student_app/Controller/TotalController.dart';
import 'package:student_app/Screen/HomeWorkListScreen.dart';
import 'package:student_app/Screen/SettingScreen.dart';
// import 'package:student_app/test/SettingScreen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  DateTime? currentBackPressTime;
  TotalController totalController = Get.put<TotalController>(TotalController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();

        if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
          currentBackPressTime = now;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("'뒤로가기' 버튼을 한 번 더 누르면 종료됩니다"),
            ),
          );

          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Stack(children: [
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
                        ),
                  ),
                  GetX<TotalController>(
                    builder: (controller) {
                      return Text(
                        controller.unsolvedRemained.value == 0 ? "남은 과제가 없습니다" : "${controller.unsolvedRemained}개의 과제가 남았습니다",
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: outPadding * 2,
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
                                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
                                    ),
                                    GetX<TotalController>(builder: (controller) {
                                      return Text(
                                        '${controller.unsolvedRemained}/${controller.totalRemained}',
                                        style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: outPadding * 0.5,
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
                                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                        const SizedBox(
                          width: outPadding * 0.5,
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
                                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: outPadding * 0.5,
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
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
