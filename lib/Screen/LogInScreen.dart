import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/Component/Config.dart';
import 'package:student_app/Component/RegisterMember.dart';
import 'package:student_app/Controller/LoginScreenController.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  LoginScreenController loginScreenController = Get.put(LoginScreenController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        DateTime? currentBackPressTime;
        if (currentBackPressTime == null || now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
          currentBackPressTime = now;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("'뒤로가기' 버튼을 한 번 더 누르면 종료됩니다"),
            ),
          );

          return Future.value(false);
        }

        return Future.value(true);
      },
      child: Stack(children: [
        Container(
          color: Theme.of(context).colorScheme.primary,
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            body: SafeArea(
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Login(loginScreenController: loginScreenController),
                      const SizedBox(
                        height: 8,
                      ),
                      Password(loginScreenController: loginScreenController),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(41, 255, 255, 255),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.all(16.0)),
                                onPressed: () async {
                                  //작업할 부분
                                  Get.to(() => const RegisterMember());
                                },
                                child: Text(
                                  "회원가입",
                                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                                )),
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 3,
                            child: TextButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(41, 255, 255, 255),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.all(16.0)),
                                onPressed: () async {
                                  await loginScreenController.logInRequest(context, null, null);
                                },
                                child: Text(
                                  "로그인",
                                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ))
      ]),
    );
  }
}

class Login extends StatelessWidget {
  const Login({
    super.key,
    required this.loginScreenController,
  });

  final LoginScreenController loginScreenController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: loginScreenController.idController,
      decoration: InputDecoration(
        hintText: "ID",
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        fillColor: const Color.fromARGB(41, 255, 255, 255),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

class Password extends StatelessWidget {
  const Password({
    super.key,
    required this.loginScreenController,
  });

  final LoginScreenController loginScreenController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: loginScreenController.passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Password",
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        fillColor: const Color.fromARGB(41, 255, 255, 255),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
