import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:untitled_design/controllers/UserController.dart';
import 'package:untitled_design/controllers/profileController.dart';
import 'package:untitled_design/styles/styles.dart';
import 'package:untitled_design/utils/utils.dart';
import 'package:untitled_design/widgets/drop_down.dart';
import 'package:untitled_design/widgets/widgets.dart';

class UserProfile extends StatelessWidget {
  UserProfile({Key? key}) : super(key: key);
  final String username = Get.find<UserController>().userNameController.text;
  final _controller = Get.put(ProfileController());

  void _saveProfile(BuildContext context) {
    _controller.saveUserProfile();
    Navigator.pop(context);
    Get.find<UserController>()
        .showSnackBar('Profile updated successfully', context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
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
                'Profile',
                style: TextStyle(
                  fontFamily: CustomFonts.sitkaFonts,
                  color: CustomColors.pageNameAndBorderColor,
                  fontSize: Sizes.sPageName,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomTextButton(
                  title: 'save', onPressed: () => _saveProfile(context)),
            ],
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(Sizes.s8),
          child: ReactiveForm(
            formGroup: _controller.userProfileForm,
            child: ListView(
              padding: const EdgeInsets.all(Sizes.s24),
              children: [
                CustomCircleAvatar(
                  child: Image.asset('profilePage'.png),
                  radius: 40,
                ),
                const SizedBox(height: Sizes.s16),
                Text(
                  username,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: CustomFonts.sitkaFonts,
                    color: CustomColors.pageContentColor2,
                    fontWeight: FontWeight.w600,
                    fontSize: Sizes.sPageContent,
                  ),
                ),
                const SizedBox(height: Sizes.s24),
                CustomTextField(
                  formControl: _controller.userProfileForm.control('firstName')
                      as FormControl,
                  label: 'First name',
                ),
                const SizedBox(height: Sizes.s24),
                CustomTextField(
                  formControl: _controller.userProfileForm.control('lastName')
                      as FormControl,
                  label: 'Last name',
                ),
                const SizedBox(height: Sizes.s24),
                CustomTextField(
                  formControl: _controller.userProfileForm
                      .control('phoneNumber') as FormControl,
                  label: 'Phone number',
                ),
                const SizedBox(height: Sizes.s24),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CustomDropDown(
                        label: 'Gender',
                        formControl: _controller.userProfileForm
                            .control('gender') as FormControl,
                        items: const ['Male', 'Female'],
                      ),
                    ),
                    const SizedBox(width: Sizes.s16),
                    Expanded(
                      child: CustomDatePicker(
                        label: 'Birthday',
                        formControl: _controller.userProfileForm
                            .control('birthDate') as FormControl<DateTime>,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Sizes.s24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        formControl: _controller.userProfileForm
                            .control('height') as FormControl,
                        label: 'Height',
                      ),
                    ),
                    const SizedBox(width: Sizes.s16),
                    Expanded(
                      child: CustomTextField(
                        formControl: _controller.userProfileForm
                            .control('weight') as FormControl,
                        label: 'Weight',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Sizes.s24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Are you from deaf-mute category?',
                      style: TextStyle(
                        fontFamily: CustomFonts.sitkaFonts,
                        fontWeight: FontWeight.w600,
                        fontSize: Sizes.s16, //sPageContent
                        color: CustomColors.pageContentColor2,
                      ),
                    ),
                    Container(
                      height: Sizes.s24 + 2,
                      width: Sizes.s48,
                      decoration: BoxDecoration(
                        color: CustomColors.backgroundColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: CustomColors.pageNameAndBorderColor),
                      ),
                      child: ReactiveSwitch(
                        activeColor: CustomColors.pageContentColor1,
                        formControl: _controller.userProfileForm
                            .control('deafMute') as FormControl<bool>,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
