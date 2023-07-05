// import 'package:ecommerce_app/views/auth_screen/login_screen.dart';

import 'package:ecommerce_app/controllers/auth_controller.dart';
import 'package:ecommerce_app/views/home_screen/home.dart';

import '../../consts/consts.dart';
// import '../../consts/lists.dart';
import '../../widgets_common/applogo_widget.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/custom_textfield.dart';
import '../../widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  // text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(children: [
          (context.screenHeight * 0.1).heightBox,
          applogoWidget(),
          10.heightBox,
          "Join the $appname".text.fontFamily(bold).white.size(18).make(),
          15.heightBox,
          Obx(
            () => Column(
              children: [
                customTextField(
                    title: name,
                    hint: nameHint,
                    controller: nameController,
                    isPass: false),
                customTextField(
                    title: email,
                    hint: emailHint,
                    controller: emailController,
                    isPass: false),
                customTextField(
                    title: password,
                    hint: passwordHint,
                    controller: passwordController,
                    isPass: true),
                customTextField(
                    title: retypePass,
                    hint: passwordHint,
                    controller: passwordRetypeController,
                    isPass: true),
                10.heightBox,
                Row(
                  children: [
                    Checkbox(
                      activeColor: redColor,
                      checkColor: whiteColor,
                      value: isCheck,
                      onChanged: (newValue) {
                        setState(() {
                          isCheck = newValue;
                        });
                      },
                    ),
                    5.widthBox,
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                            text: "I agree to the ",
                            style: TextStyle(
                              fontFamily: regular,
                              color: fontGrey,
                            ),
                          ),
                          TextSpan(
                            text: termAndCond,
                            style: TextStyle(
                              color: redColor,
                              fontFamily: regular,
                            ),
                          ),
                          TextSpan(
                            text: " & ",
                            style: TextStyle(
                              color: fontGrey,
                              fontFamily: regular,
                            ),
                          ),
                          TextSpan(
                            text: privPolicy,
                            style: TextStyle(
                              color: redColor,
                              fontFamily: regular,
                            ),
                          ),
                        ])),
                      ),
                    ),
                  ],
                ),
                5.heightBox,
                controller.isLoading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ourButton(
                          color: isCheck == true ? redColor : lightGrey,
                          title: signup,
                          textColor: whiteColor,
                          onPress: () async {
                            if (isCheck != false) {
                              controller.isLoading(true);
                              try {
                                await controller
                                    .signupMethod(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        context: context)
                                    .then((value) {
                                  return controller.storeUserData(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text);
                                }).then((value) {
                                  VxToast.show(context, msg: loggedin);
                                  Get.offAll(() => const Home());
                                });
                              } catch (e) {
                                auth.signOut();
                                VxToast.show(context, msg: e.toString());
                                controller.isLoading(false);
                              }
                            }
                          },
                        ).box.width(context.screenWidth - 50).make(),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    alreadyAcc.text.color(fontGrey).make(),
                    login.text.color(redColor).make().onTap(() {
                      Get.back();
                    }),
                  ],
                )
              ],
            )
                .box
                .white
                .rounded
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .shadowSm
                .make(),
          ),
        ]),
      ),
    ));
  }
}
