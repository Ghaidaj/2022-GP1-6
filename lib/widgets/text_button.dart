import 'package:flutter/material.dart';
import 'package:untitled_design/styles/styles.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    required this.title,
    required this.onPressed,
    this.fontSize,
    Key? key,
  }) : super(key: key);
  final String title;
  final VoidCallback onPressed;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          color: CustomColors.pageContentColor1,
          fontSize: fontSize ?? Sizes.s16,
          fontFamily: CustomFonts.sitkaFonts,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
