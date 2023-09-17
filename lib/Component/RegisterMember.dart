import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:student_app/Component/Config.dart';
import 'package:http/http.dart' as http;

class RegisterMember extends StatefulWidget {
  const RegisterMember({super.key});

  @override
  State<RegisterMember> createState() => _RegisterMemberState();
}

class _RegisterMemberState extends State<RegisterMember> {
  int? kakaoId;
  bool _isKakaoTalkInstalled = false;
  bool certification = false;
  int selectedGender = 0;
  bool matchpassword = true;
  bool formatCorrect = true;

  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController checkPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();

  @override
  void initState() {
    _initKakaoTalkInstalled();
    super.initState();
  }

  _initKakaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    setState(() {
      _isKakaoTalkInstalled = installed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Theme.of(context).colorScheme.primary,
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              title: const Text("회원가입"),
              backgroundColor: Colors.transparent,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.2, vertical: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            if (_isKakaoTalkInstalled) {
                              try {
                                await UserApi.instance.loginWithKakaoTalk();
                                setState(() {
                                  certification = true;
                                });
                              } catch (e) {
                                print("카카오톡 로그인 실패 $e");

                                if (e is PlatformException && e.code == 'CANCELED') {
                                  return;
                                }

                                try {
                                  await UserApi.instance.loginWithKakaoAccount();
                                  setState(() {
                                    certification = true;
                                  });
                                  print('카카오계정으로 로그인 성공');
                                } catch (e) {
                                  print('카카오계정으로 로그인 실패 $e');
                                }
                              }
                            } else {
                              try {
                                await UserApi.instance.loginWithKakaoAccount();
                                setState(() {
                                  certification = true;
                                });
                                print('카카오계정으로 로그인 성공');
                              } catch (e) {
                                print('카카오계정으로 로그인 실패 $e');
                              }
                            }
                            var response = await UserApi.instance.me();
                            kakaoId = response.id;
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.yellow),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.chat_bubble,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "카카오 인증",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        certification
                            ? Text(
                                "인증 완료",
                                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                              )
                            : Text(
                                "인증 미완료",
                                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                              ),
                        ...betweenTextfield("아이디"),
                        registerTextfield(idController, false),
                        ...betweenTextfield("비밀번호"),
                        registerTextfield(passwordController, true),
                        ...betweenTextfield("비밀번호 확인"),
                        registerTextfield(checkPasswordController, true),
                        ...betweenTextfield("이름"),
                        registerTextfield(nameController, false),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "성별",
                          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                        ),
                        chooseSexButton(),
                        ...betweenTextfield("나이"),
                        registerTextfield(ageController, false),
                        ...betweenTextfield("이메일"),
                        registerTextfield(emailController, false),
                        ...betweenTextfield("닉네임"),
                        registerTextfield(nicknameController, false),
                        SizedBox(
                          height: 20,
                          child: matchpassword
                              ? const Text("")
                              : Text(
                                  "비밀번호가 다릅니다",
                                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                                ),
                        ),
                        SizedBox(
                          height: 20,
                          child: formatCorrect
                              ? const Text("")
                              : const Text(
                                  "모든 입력이 완료되지 않았습니다",
                                  style: TextStyle(fontSize: 10),
                                ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(16.0),
                                    foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text(
                                    "취소",
                                  )),
                            ),
                            const Spacer(),
                            Expanded(
                              flex: 3,
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(16.0),
                                    foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () async {
                                    await tryMakeId(context);
                                  },
                                  child: const Text("회원가입")),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ))
      ],
    );
  }

  Column chooseSexButton() {
    return Column(
      children: [
        RadioListTile<int>(
          activeColor: Theme.of(context).colorScheme.primaryContainer,
          value: 0,
          groupValue: selectedGender,
          onChanged: (value) {
            setState(() {
              selectedGender = value!;
            });
          },
          title: Text(
            '남',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
        RadioListTile<int>(
          value: 1,
          groupValue: selectedGender,
          onChanged: (value) {
            setState(() {
              selectedGender = value!;
            });
          },
          title: Text(
            '여',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ],
    );
  }

  SizedBox registerTextfield(TextEditingController controller, bool obscure) {
    return SizedBox(
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(),
        decoration: InputDecoration(
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          fillColor: const Color.fromARGB(111, 158, 158, 158),
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
      ),
    );
  }

  List<Widget> betweenTextfield(String name) {
    return [
      const SizedBox(
        height: 10,
      ),
      Text(
        name,
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
      const SizedBox(
        height: 5,
      )
    ];
  }

  bool isCorrectFormat() {
    return certification &&
        idController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        ageController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        nicknameController.text.isNotEmpty;
  }

  ///입력한 정보를 백엔드에 보내는 함수
  Future<int> sendRegisterInfo() async {
    final url = Uri.parse('http://$HOST/api/auth/register');
    final Map<String, dynamic> requestBody = {
      "kakao_id": kakaoId,
      "user_id": idController.text,
      "user_password": passwordController.text,
      "user_email": emailController.text,
      "user_nickname": nicknameController.text,
      "real_name": nameController.text,
      "gender": selectedGender == 0 ? true : false,
      "age": int.parse(ageController.text),
    };
    final headers = {"Content-type": "application/json"};

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(requestBody),
    );
    return response.statusCode;
  }

  ///유저가 회원가입 시도시 회원가입이 가능한 형태인지 검증한 후 가능한 형태시 다른 함수에 넘겨줌
  Future<void> tryMakeId(BuildContext context) async {
    setState(() {
      matchpassword = true;
      formatCorrect = true;
    });
    if (passwordController.text != checkPasswordController.text) {
      setState(() {
        matchpassword = false;
      });
    } else {
      if (isCorrectFormat()) {
        final statusCode = await sendRegisterInfo();
        if (statusCode ~/ 100 == 2) {
          Get.back();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("회원가입이 완료되었습니다"),
            ),
          );
        } else {
          debugPrint("서버에서 회원가입 거부");
          setState(() {
            formatCorrect = false;
          });
        }
      } else {
        setState(() {
          formatCorrect = false;
        });
      }
    }
  }
}
