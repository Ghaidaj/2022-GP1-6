import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:untitled_design/controllers/UserController.dart';
import 'package:untitled_design/styles/styles.dart';
import 'package:untitled_design/utils/utils.dart';
import 'package:untitled_design/widgets/widgets.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);
  UserController userController = Get.find();
  final forgetPasswordForm = FormGroup({
    'email': FormControl(validators: [Validators.required]),
  });
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: const EdgeInsets.all(Sizes.s8),
          child: ReactiveForm(
            formGroup: forgetPasswordForm,
            child: Column(
              children: [
                Row(
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
                      'Forget Password',
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.s24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: Sizes.s88),
                        SizedBox(
                          height: Sizes.s136,
                          // width: Sizes.s136,
                          child: Image.asset('logo'.png),
                        ),
                        const Text(
                          'please enter your email',
                          style: TextStyle(
                            fontSize: Sizes.sPageContent,
                            fontWeight: FontWeight.w600,
                            fontFamily: CustomFonts.sitkaFonts,
                            color: CustomColors.pageContentColor2,
                          ),
                        ),
                        const SizedBox(height: Sizes.s8),
                        const SizedBox(height: Sizes.s24),
                        // CustomTextField(
                        //   label: 'Email',
                        //   formControl:
                        //       forgetPasswordForm.control('email') as FormControl,
                        //   required: true,
                        // ),
                        TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) return "Valid Email required";
                            return null;
                          },
                          controller: userController.emailController,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 0.0),
                              ),
                              isDense: true,
                              label: Text("Email")),
                        ),
                        const SizedBox(height: Sizes.s32),
                        ReactiveFormConsumer(
                          builder: (context, formGroup, child) {
                            return CustomElevatedButton(
                              title: 'send',
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  userController.forgotPassword(context);
                                }
                              },
                            );
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
      ),
    );
  }
}
