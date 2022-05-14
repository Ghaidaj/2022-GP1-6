import 'dart:ffi';

import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:untitled_design/app/app.dart';
import 'package:untitled_design/utils/extensions.dart';

import '../../../controllers/UserController.dart';
import '../../../styles/colors/custom_colors.dart';
import '../../../styles/layouts/fonts.dart';
import '../../../styles/layouts/size.dart';
import '../../../widgets/elevated_button.dart';

class UserEmailAuth extends StatefulWidget {
  @override
  _UserEmailAuthState createState() => _UserEmailAuthState();
}

class _UserEmailAuthState extends State<UserEmailAuth> {
  UserController userController = Get.put(UserController());
  final verificationForm = FormGroup({
    'email': FormControl(validators: [Validators.required]),
    'otp': FormControl(validators: [Validators.required]),
  });

  final _formKey = GlobalKey<FormState>();

  // Controllers
  // TextEditingController _emailCotroller = TextEditingController();
  // TextEditingController _otpController = TextEditingController();
  // Methods for OTP
  Future<bool> sendOTP() async {
    EmailAuth emailAuth = EmailAuth(sessionName: "HelpSession");
    bool res = await emailAuth.sendOtp(
        recipientMail: userController.emailController.value.text);
    if (res) {
      return res;
    } else {
      return res;
    }
  }

  Future<bool> verifyOTP() async {
    EmailAuth emailAuth = EmailAuth(sessionName: "HelpSession");
    print('${userController.emailController.value.text}    -----');
    print('${userController.otpController.value.text}    -----');
    bool res = await emailAuth.validateOtp(
        recipientMail: userController.emailController.value.text,
        userOtp: userController.otpController.value.text);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: CustomColors.backgroundColor,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: CustomColors.pageContentColor1,
                    ),
                  ),
                  const Text(
                    'Email Verification',
                    style: TextStyle(
                      fontFamily: CustomFonts.sitkaFonts,
                      color: CustomColors.pageNameAndBorderColor,
                      fontSize: Sizes.sPageName,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                ],
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Sizes.s20),
                child: ReactiveForm(
                  formGroup: verificationForm,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: Sizes.s24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const SizedBox(height: Sizes.s16),
                              SizedBox(
                                height: Sizes.s136,
                                // width: Sizes.s136,
                                child: Image.asset('logo'.png),
                              ),
                              const SizedBox(height: Sizes.s24),
                              // TextFormField(
                              //   controller: userController.emailController,
                              //   validator: (val) {
                              //     String pattern = r'\w+@\w+\.\w+';
                              //     RegExp regex = RegExp(pattern);
                              //     if (val!.isEmpty) {
                              //       return 'Email required.';
                              //     } else if (!regex.hasMatch(val)) {
                              //       return 'Invalid Email Format';
                              //     }
                              //     return null;
                              //   },
                              //   decoration: InputDecoration(
                              //       border: const OutlineInputBorder(
                              //         borderSide: const BorderSide(
                              //             color: Colors.black, width: 0.0),
                              //       ),
                              //       suffixIcon: TextButton(
                              //         style: ButtonStyle(
                              //             backgroundColor:
                              //                 MaterialStateProperty.all(
                              //                     CustomColors
                              //                         .pageContentColor1)),
                              //         onPressed: () {
                              //           sendOTP();
                              //           showDialog(
                              //             context: context,
                              //             builder: (_) {
                              //               return alertDialog(
                              //                   "code sent!", "");
                              //             },
                              //           );
                              //           // userController.emailController.clear();
                              //         },
                              //         child: Text(
                              //           'Send code',
                              //           style: TextStyle(
                              //               fontSize: 15,
                              //               color: Colors.white,
                              //               fontWeight: FontWeight.w700),
                              //         ),
                              //       ),
                              //       isDense: true,
                              //       label: Text("Email")),
                              // ),
                              const SizedBox(height: Sizes.s24),
                              TextFormField(
                                obscureText: true,
                                validator: (val) {
                                  // String pattern = r"^(?=.[A-Za-z])(?=.\d)[A-Za-z\d]{8,}$";
                                  // RegExp regex = RegExp(pattern);
                                  if (val!.isEmpty) return "code required! ";
                                  return null;
                                },
                                controller: userController.otpController,
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 0.0),
                                    ),
                                    isDense: true,
                                    label: Text("Enter code ")),
                              ),
                              const SizedBox(height: Sizes.s24),
                              ReactiveFormConsumer(
                                builder: (context, formGroup, child) {
                                  return ElevatedButton(
                                      onPressed: () {
                                        // if(_formKey.currentState!.validate())
                                        // {
                                        //   userController.signInUser(context);
                                        // }
                                        verifyOTP().then((value) async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            if (value == true) {
                                              String? uid= await userController.signUpUser(context);
                                              if(uid == null){
                                                showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    return alertDialog(
                                                        "Alert !!",
                                                        "Email is already in use!!");
                                                  },
                                                );
                                              }else{
                                                showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    return alertDialog(
                                                        "your email Verified !",
                                                        "please log in");
                                                  },
                                                );

                                                setState(() {
                                                  Future.delayed(
                                                      Duration(seconds: 3),
                                                      navigation);
                                                });
                                              }
                                              //userController.verified();



                                            } else {
                                              showDialog(
                                                context: context,
                                                builder: (_) {
                                                  return alertDialog(
                                                      "Invalid code",
                                                      "Please try again!");
                                                },
                                              );
                                            }
                                          }
                                        });
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                CustomColors.pageContentColor1),
                                      ),
                                      child: Text(
                                        "Verify",
                                        style: TextStyle(fontSize: 15),
                                      ));
                                },
                              ),
                              const SizedBox(height: Sizes.s16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  navigation() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
  }

  Widget alertDialog(String title, String message) {
    return AlertDialog(
      title: Text("$title"),
      content: Text("$message"),
    );
  }
}
