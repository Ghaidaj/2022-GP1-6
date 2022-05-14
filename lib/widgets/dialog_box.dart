import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled_design/controllers/adminHomeController.dart';
import 'package:untitled_design/styles/styles.dart';
import 'package:untitled_design/widgets/elevated_button.dart';

class CustomDialogBox extends StatelessWidget {
  final String title, descriptions, btn1Text, btn2Text;
  final List<Widget>? actions;
  final String? deleteUser;
  final bool pop;

  const CustomDialogBox({
    Key? key,
    this.title = 'Hint',
    this.descriptions = 'Are you sure you want to delete this user?',
    this.btn1Text = 'Yes',
    this.btn2Text = 'No',
    this.actions,
    this.deleteUser,
    this.pop = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        side: BorderSide(
          width: Sizes.s8 / 3,
          color: CustomColors.pageNameAndBorderColor,
        ),
      ),
      backgroundColor: CustomColors.backgroundColor,
      actionsAlignment: MainAxisAlignment.center,
      title: Center(
          child: Text(
        title,
        style: const TextStyle(
            fontFamily: CustomFonts.sitkaFonts,
            color: CustomColors.pageContentColor1),
      )),
      content: Text(
        descriptions,
        style: const TextStyle(
          color: CustomColors.pageContentColor2,
          fontSize: Sizes.s24,
          fontFamily: CustomFonts.sitkaFonts,
        ),
        textAlign: TextAlign.center,
      ),
      actions: actions ??
          [
            CustomElevatedButton(
              title: btn1Text,
              onPressed: () async {
                if (deleteUser != null) {
                  await Get.find<AdminHomeController>().deleteUser(deleteUser!);
                  if (pop) Navigator.pop(context);
                }
                Navigator.pop(context);
              },
            ),
            CustomElevatedButton(
              title: btn2Text,
              onPressed: () => Navigator.pop(context),
            ),
          ],
      actionsPadding: const EdgeInsets.only(bottom: Sizes.s8),
    );
  }
}
