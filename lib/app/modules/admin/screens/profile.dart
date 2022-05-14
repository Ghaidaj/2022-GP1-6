import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:untitled_design/controllers/adminHomeController.dart';
import 'package:untitled_design/styles/styles.dart';
import 'package:untitled_design/utils/utils.dart';
import 'package:untitled_design/widgets/widgets.dart';

class AdminProfile extends StatelessWidget {
  AdminProfile({required this.username, Key? key}) : super(key: key);
  final String username;
  final _controller = Get.put(AdminHomeController());

  void _onDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogBox(
        deleteUser: username,
        pop: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(Sizes.s8),
          child: ReactiveForm(
            formGroup: _controller.adminProfileForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      'Profile',
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.s32, vertical: Sizes.s16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomCircleAvatar(
                        child: Image.asset('profilePage'.png),
                        radius: 40,
                      ),
                      const SizedBox(height: Sizes.s64),
                      CustomTextField(
                        label: 'First name',
                        formControl: _controller.adminProfileForm
                            .control('firstName') as FormControl,
                      ),
                      const SizedBox(height: Sizes.s24),
                      CustomTextField(
                        label: 'Last name',
                        formControl: _controller.adminProfileForm
                            .control('lastName') as FormControl,
                      ),
                      const SizedBox(height: Sizes.s24),
                      CustomTextField(
                          label: 'Phone number',
                          formControl: _controller.adminProfileForm
                              .control('phoneNumber') as FormControl),
                      const SizedBox(height: Sizes.s72),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomElevatedButton(
                            title: 'Edit',
                            onPressed: () async {
                              await _controller.editUserProfile(username);
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(width: Sizes.s16),
                          CustomElevatedButton(
                            title: 'Delete',
                            onPressed: () => _onDelete(context),
                          ),
                        ],
                      )
                    ],
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
