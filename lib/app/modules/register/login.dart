import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:untitled_design/app/app.dart';
import 'package:untitled_design/app/modules/register/forget_password.dart';
import 'package:untitled_design/controllers/UserController.dart';
import 'package:untitled_design/styles/styles.dart';
import 'package:untitled_design/utils/utils.dart';
import 'package:untitled_design/widgets/widgets.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  UserController userController = Get.put(UserController());
  final loginForm = FormGroup({
    'email': FormControl(validators: [Validators.required]),
    'password': FormControl(validators: [Validators.required]),
  });

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.all(Sizes.s8),
        child: ReactiveForm(
          formGroup: loginForm,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.s24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(top: Sizes.s24),
                        child: Text(
                          'login',
                          style: TextStyle(
                              fontSize: Sizes.sPageName,
                              fontWeight: FontWeight.bold,
                              fontFamily: CustomFonts.sitkaFonts,
                              color: CustomColors.pageNameAndBorderColor),
                        ),
                      ),
                      const SizedBox(height: Sizes.s16),
                      SizedBox(
                        height: Sizes.s136,
                        // width: Sizes.s136,
                        child: Image.asset('logo'.png),
                      ),
                      const Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: Sizes.sPageName,
                          fontWeight: FontWeight.w600,
                          fontFamily: CustomFonts.sitkaFonts,
                          color: CustomColors.pageContentColor1,
                        ),
                      ),
                      const SizedBox(height: Sizes.s8),
                      const Text(
                        'login to help App',
                        style: TextStyle(
                          fontSize: Sizes.sPageContent,
                          fontFamily: CustomFonts.sitkaFonts,
                          color: CustomColors.pageContentColor2,
                        ),
                      ),
                      const SizedBox(height: Sizes.s24),
                      TextFormField(
                        controller: userController.emailController,
                        validator: (val) {
                          String pattern = r'\w+@\w+\.\w+';
                          RegExp regex = RegExp(pattern);
                          if (val!.isEmpty) {
                            return 'Email required.';
                          } else if (!regex.hasMatch(val)) {
                            return 'Invalid Email Format';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 0.0),
                            ),
                            isDense: true,
                            label: Text("Email")),
                      ),
                      const SizedBox(height: Sizes.s24),
                      TextFormField(
                        obscureText: true,
                        validator: (val) {
                          //String pattern = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
                          //RegExp regex = RegExp(pattern);
                          if (val!.isEmpty) {
                            return "Password required! ";
                          }
                          return null;
                        },
                        controller: userController.passwordController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 0.0),
                            ),
                            isDense: true,
                            label: Text("Password")),
                      ),
                      // const SizedBox(height: Sizes.s24),
                      // CustomTextField(
                      //   label: 'Password',
                      //   formControl: loginForm.control('password') as FormControl,
                      //   required: true,
                      // ),
                      // const SizedBox(height: Sizes.s8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomTextButton(
                          title: 'forget password?',
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgetPassword(),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: Sizes.s24),
                      ReactiveFormConsumer(
                        builder: (context, formGroup, child) {
                          return CustomElevatedButton(
                            title: 'Log In',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                userController.signInUser(context);
                              }
                            },
                            // onPressed: () => Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => loginForm
                            //                 .control('email')
                            //                 .value
                            //                 .toString()
                            //                 .toLowerCase() ==
                            //             'admin'
                            //         ? AdminHome()
                            //         : const UserHome(),
                            //   ),
                          );
                        },
                      ),
                      const SizedBox(height: Sizes.s16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Do not have an account?',
                            style: TextStyle(
                              color: CustomColors.pageContentColor1,
                              fontSize: Sizes.s16,
                              fontWeight: FontWeight.w600,
                              fontFamily: CustomFonts.sitkaFonts,
                            ),
                          ),
                          CustomTextButton(
                            title: 'sign up Now',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Functions for validation of text and email
  String? validateText(String _formText) {
    if (_formText.isEmpty) {
      return 'Field is required';
    }
    return null;
  }
  // Function for email authentication. E.g if he has enter @ sign in the email or not.
}
