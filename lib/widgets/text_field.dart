import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:untitled_design/styles/colors/colors.dart';
import 'package:untitled_design/styles/layouts/layouts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.formControl,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.circularRadius = 6,
    this.height = Sizes.s32,
    this.required = false,
    Key? key,
  }) : super(key: key);
  final String? label;
  final String? hint;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final double circularRadius;
  final double height;
  final bool required;
  final FormControl formControl;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: !required ? height : null,
      child: ReactiveTextField(
        formControl: formControl,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontFamily: CustomFonts.sitkaFonts,
          fontSize: 16,
          color: Color(0xFF444150),
        ),
        cursorColor: CustomColors.pageContentColor1,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          suffixIconColor: CustomColors.pageContentColor1,
          prefixIconColor: CustomColors.pageContentColor1,
          contentPadding: const EdgeInsets.only(left: 16, top: 10, bottom: 14),
          focusColor: CustomColors.pageNameAndBorderColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(circularRadius)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: CustomColors.pageNameAndBorderColor, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(circularRadius)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: CustomColors.pageNameAndBorderColor,
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(circularRadius)),
          ),
          labelText: label ?? '',
          labelStyle: const TextStyle(
              color: CustomColors.pageContentColor1,
              fontFamily: CustomFonts.sitkaFonts),
          hintText: hint ?? '',
          hintStyle: const TextStyle(
            color: CustomColors.pageContentColor2,
            fontFamily: CustomFonts.sitkaFonts,
          ),
        ),
      ),
    );
  }
}
