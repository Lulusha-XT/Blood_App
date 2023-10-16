import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/common_widgets/circularProgressBar/circular_progress_widget.dart';
import 'package:flutter_application_1/src/config/config.dart';
import 'package:flutter_application_1/src/constants/colors.dart';
import 'package:flutter_application_1/src/constants/sizes.dart';
import 'package:flutter_application_1/src/constants/text_string.dart';
import 'package:flutter_application_1/src/features/authentication/controllers/signin_controllers.dart';
import 'package:flutter_application_1/src/features/core/pages/dashboard_page/home_page.dart';
import 'package:get/get.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controllers = Get.put(SignInControllers());
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: cFormHeigth - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                controller: controllers.email,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined),
                  labelText: "Email".tr,
                  hintText: "Email".tr,
                  border: const OutlineInputBorder(),
                ),
                validator: validateEmail),
            const SizedBox(height: cFormHeigth),
            Obx(() => TextFormField(
                  controller: controllers.password,
                  decoration: InputDecoration(
                    label: Text("Password".tr),
                    prefixIcon: const Icon(Icons.key_outlined),
                    suffixIcon: IconButton(
                      onPressed: () {
                        controllers.hidePassword.value =
                            !controllers.hidePassword.value;
                      },
                      color: Colors.redAccent.withOpacity(.4),
                      icon: Icon(
                        controllers.hidePassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  validator: (value) => validatePassword(value, cPassword),
                  obscureText: controllers.hidePassword.value,
                )),
            const SizedBox(height: cFormHeigth),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: TextButton(
            //     onPressed: () {
            //       //  ForgetPasswordScreen.buildShowModalBottomSheet(context);
            //     },
            //     child: const Text(cForgetPassword),
            //   ),
            // ),
            Obx(() => controllers.isAsyncCallProcess.value
                ? const Center(
                    child: DottedCircularProgressIndicatorFb(
                      currentDotColor: cSecondaryColor,
                      defaultDotColor: cPrimaryColor,
                      numDots: 8,
                    ),
                  )
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          controllers.isAsyncCallProcess.value = true;
                          try {
                            await SignInControllers.instance.signInUser(
                                    controllers.email.text.trim(),
                                    controllers.password.text.trim())
                                ?

                                // If the registration was successful

                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("BloodDonation".tr),
                                        content:
                                            Text("UserLoggedInSuccessfuly".tr),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("Ok".tr),
                                            onPressed: () {
                                              // Navigator.of(context).pop();
                                              // Navigator.of(context)
                                              //     .pushNamedAndRemoveUntil(
                                              //   "/login",
                                              //   (route) => false,
                                              // );
                                              Get.to(() => const HomePage());
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  )

                                // If the email is already registered
                                : showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("BloodDonation".tr),
                                        content: Text(
                                          "InvalidEmailorPassword".tr,
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("Ok".tr),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                          } catch (e) {
                            // If there was an error during the registration process
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("BloodDonation".tr),
                                  content: Text(
                                      "An error occurred: ${e.toString()}"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text("Ok"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      },
                      child: Text("Signin".tr),
                    ),
                  )),
          ],
        ),
      ),
    );
  }

  String? validate(String? value, String inputName) {
    if (value!.isEmpty) {
      return "$inputName is required";
    }
    return null;
  }

  String? validatePassword(String? value, String? password) {
    if (password == null || value!.length < 6) {
      return 'Password must be 6 charachter and above';
    } else {
      return null;
    }
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }
}
