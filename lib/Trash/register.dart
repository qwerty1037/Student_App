
class RegisterInfoButton extends StatelessWidget {
  RegisterInfoButton({
    super.key,
  });
  final RegisterInfoController _registerInfoController =
      Get.put(RegisterInfoController());

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shadowColor: Colors.transparent,
                title: const Text(
                  "회원가입",
                  textAlign: TextAlign.center,
                ),
                content: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: GetBuilder<RegisterInfoController>(
                      builder: (controller) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("아이디"),
                            const SizedBox(
                              height: 5,
                            ),
                            registerTextfield(controller.idController, false),
                            ...betweenTextfield("비밀번호"),
                            registerTextfield(
                                controller.passwordController, true),
                            ...betweenTextfield("비밀번호 확인"),
                            registerTextfield(
                                controller.checkPasswordController, true),
                            ...betweenTextfield("이름"),
                            registerTextfield(controller.nameController, false),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("성별"),
                            chooseSexButton(controller),
                            ...betweenTextfield("나이"),
                            registerTextfield(controller.ageController, false),
                            ...betweenTextfield("이메일"),
                            registerTextfield(
                                controller.emailController, false),
                            ...betweenTextfield("닉네임"),
                            registerTextfield(
                                controller.nicknameController, false),
                            SizedBox(
                              height: 20,
                              child: controller.matchpassword
                                  ? const Text("")
                                  : const Text("비밀번호가 다릅니다"),
                            ),
                            SizedBox(
                              height: 20,
                              child: controller.formatCorrect
                                  ? const Text("")
                                  : const Text(
                                      "입력이 완료되지 않았습니다",
                                      style: TextStyle(fontSize: 10),
                                    ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                actions: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.all(16.0),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Get.delete<RegisterInfoController>();
                          },
                          child: const Text("취소"),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.all(16.0)),
                          onPressed: () {
                            _registerInfoController.tryMakeId(context);
                          },
                          child: const Text("가입하기"),
                        ),
                      )
                    ],
                  ),
                ],
              );
            });
      },
      /*
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      */
      child: Text(
        "회원가입",
        style: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
      ),
    );
  }

  Column chooseSexButton(RegisterInfoController controller) {
    return Column(
      children: [
        RadioListTile<int>(
          value: 0,
          groupValue: controller.selectedGender,
          onChanged: (value) {
            controller.selectedGender = value!;
            controller.update();
          },
          title: const Text('남'),
        ),
        RadioListTile<int>(
          value: 1,
          groupValue: controller.selectedGender,
          onChanged: (value) {
            controller.selectedGender = value!;
            controller.update();
          },
          title: const Text('여'),
        ),
      ],
    );
  }

  SizedBox registerTextfield(TextEditingController controller, bool obscure) {
    return SizedBox(
      width: 300,
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
      Text(name),
      const SizedBox(
        height: 5,
      )
    ];
  }
}

import 'package:http/http.dart' as http;

///회원 가입에 사용되는 컨트롤러
class RegisterInfoController extends GetxController {
  //0이면 남자 1이면 여자(버튼 순서)
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

  ///채워야할 정보를 모두 채웠는지 확인하는 함수
  bool isCorrectFormat() {
    return idController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        ageController.text.isNotEmpty &&
        emailController.text.isNotEmpty;
  }

  ///입력한 정보를 백엔드에 보내는 함수
  Future<int> sendRegisterInfo() async {
    final url = Uri.parse('http://$HOST/api/auth/register');
    final Map<String, dynamic> requestBody = {
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
    matchpassword = true;
    formatCorrect = true;

    if (passwordController.text != checkPasswordController.text) {
      matchpassword = false;
      update();
    } else {
      if (isCorrectFormat()) {
        final statusCode = await sendRegisterInfo();
        if (statusCode == 200) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("회원가입이 완료되었습니다"),
            ),
          );
          Get.delete<RegisterInfoController>();
        } else {
          debugPrint("서버에서 회원가입 거부");
          formatCorrect = false;
          update();
        }
      } else {
        formatCorrect = false;
        update();
      }
    }
  }
}

