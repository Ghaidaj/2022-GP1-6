import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:untitled_design/app/modules/register/user_signup_auth.dart';
import 'package:untitled_design/controllers/UserController.dart';
import 'package:untitled_design/styles/styles.dart';
import 'package:untitled_design/utils/utils.dart';
import 'package:untitled_design/widgets/widgets.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  final UserController userController = Get.find();
  final signUpForm = FormGroup({
    'username': FormControl(validators: [Validators.required]),
    'email': FormControl(validators: [Validators.required]),
    'phoneNumber': FormControl(validators: [Validators.required]),
    'password': FormControl(validators: [Validators.required]),
    'confirmPassword': FormControl(validators: [Validators.required]),
  });

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                'Signup',
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
        body: Padding(
          padding: const EdgeInsets.all(Sizes.s8),
          child: ReactiveForm(
            formGroup: signUpForm,
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.s24,
                  vertical: Sizes.s24,
                ),
                children: <Widget>[
                  const SizedBox(height: Sizes.s16),
                  SizedBox(
                    height: Sizes.s136,
                    // width: Sizes.s136,
                    child: Image.asset('logo'.png),
                  ),
                  const SizedBox(height: Sizes.s24),
                  // CustomTextField(
                  //   label: 'Username',
                  //   formControl: signUpForm.control('username') as FormControl,
                  //   required: true,
                  // ),
                  TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'User name required!';
                      }
                      return null;
                    },
                    controller: userController.userNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 0.0),
                        ),
                        isDense: true,
                        label: Text("Username")),
                  ),
                  const SizedBox(height: Sizes.s24),
                  // CustomTextField(
                  //   label: 'Email',
                  //   formControl: signUpForm.control('email') as FormControl,
                  //   required: true,
                  // ),
                  TextFormField(
                    validator: (val) {
                      String pattern = r'\w+@\w+\.\w+';
                      RegExp regex = RegExp(pattern);
                      if (val!.isEmpty) {
                        return 'Email required!';
                      } else if (!regex.hasMatch(val)) {
                        return 'Invalid Email Format';
                      }
                      return null;
                    },
                    controller: userController.emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 0.0),
                        ),
                        isDense: true,
                        label: Text("Email")),
                  ),
                  const SizedBox(height: Sizes.s24),
                  // CustomTextField(
                  //   label: 'Phone number',
                  //   formControl: signUpForm.control('phoneNumber') as FormControl,
                  //   required: true,
                  // ),
                  TextFormField(
                    validator: (val) {
                      String pattern =
                          r'((\05)|0)[.\- ]?[0-9][.\- ]?[0-9][.\- ]?[0-9]';
                      RegExp regex = RegExp(pattern);
                      if (val!.isEmpty) {
                        return "Phone required!";
                      } else if (!regex.hasMatch(val)) {
                        return 'Invalid Phone number format!';
                      } else if (val.length != 10) {
                        return 'Please enter phone number with length of 10';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: userController.phoneController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 0.0),
                        ),
                        isDense: true,
                        label: Text("Phone number")),
                  ),
                  const SizedBox(height: Sizes.s24),
                  // CustomTextField(
                  //   label: 'Password',
                  //   formControl: signUpForm.control('password') as FormControl,
                  //   required: true,
                  // ),
                  TextFormField(
                    validator: (val) {
                      print("************" + val.toString());
                      String pattern = r"^(?=.[A-Za-z])(?=.\d)[A-Za-z\d]{8,}$";
                      RegExp regex = RegExp(pattern);
                      if (val!.isEmpty || //||             !regex.hasMatch(val)
                          val.length < 8) {
                        return "Password required (more than 8 characters 1 upper case!)";
                      }
                      return null;
                    },
                    obscureText: true,
                    controller: userController.passwordController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 0.0),
                        ),
                        isDense: true,
                        label: Text("Password")),
                  ),
                  const SizedBox(height: Sizes.s24),
                  // CustomTextField(
                  //   label: 'Confirm password',
                  //   formControl:
                  //       signUpForm.control('confirmPassword') as FormControl,
                  //   required: true,
                  // ),
                  TextFormField(
                    validator: (val) {
                      String pattern = r"^(?=.[A-Za-z])(?=.\d)[A-Za-z\d]{8,}$";
                      RegExp regex = RegExp(pattern);
                      if (val!.isEmpty || //||!regex.hasMatch(val)
                          val.length < 8) {
                        return "Password required (more than 8 characters 1 upper case!)";
                      }
                      return null;
                    },
                    obscureText: true,
                    controller: userController.confirmPasswordController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 0.0),
                        ),
                        isDense: true,
                        label: Text("Confirm password")),
                  ),
                  const SizedBox(height: Sizes.s20),
                  Card(
                    elevation: 0,
                    color: CustomColors.backgroundColor,
                    shadowColor: CustomColors.shadow,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Sizes.s8 / 2),
                        side:
                            const BorderSide(color: Colors.black, width: 0.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(Sizes.s16),
                      child: Column(
                        children: [
                          const Text('Add your relative\'s information'),
                          const SizedBox(height: Sizes.s24),
                          TextFormField(
                            validator: (val) {
                              return null;
                            },
                            controller: userController.contactNameController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 0.0),
                                ),
                                isDense: true,
                                label: Text("Contact Name")),
                          ),
                          const SizedBox(height: Sizes.s24),
                          TextFormField(
                            validator: (val) {
                              String pattern =
                                  r'((\05)|0)[.\- ]?[0-9][.\- ]?[0-9][.\- ]?[0-9]';
                              RegExp regex = RegExp(pattern);
                              if (val!.isEmpty) {
                                return "Phone required!";
                              } else if (!regex.hasMatch(val)) {
                                return 'Invalid Phone number format!';
                              } else if (val.length != 10) {
                                return 'Please enter phone number with length of 10';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            controller: userController.contactNumberController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 0.0),
                                ),
                                isDense: true,
                                label: Text("Contact Number")),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: Sizes.s24),

                  ReactiveFormConsumer(
                    builder: (context, formGroup, child) {
                      return Row(
                        children: [
                          const Spacer(),
                          CustomElevatedButton(
                              title: 'Signup',
                              onPressed: () async{
                                if (_formKey.currentState!.validate()) {
                                  if (userController.passwordController.text ==
                                      userController
                                          .confirmPasswordController.text) {
                                    sendOTP();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserEmailAuth()),
                                    );
                                    //userController.showSnackBar(
                                    //"Signing up...", context);
                                    // userController.signUpUser(context);
                                  } else {
                                    userController.showSnackBar(
                                        "Password not match", context);
                                  }
                                }
                              }),
                          const Spacer(),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Send OTP Method
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
// // Alert Dialoge
//   Widget alertDialog(String title, String message) {
//     return AlertDialog(
//       title: Text("$title"),
//       content: Text("$message"),
//     );
//   }
}
