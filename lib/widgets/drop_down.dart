import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:untitled_design/styles/styles.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({
    required this.formControl,
    required this.items,
    this.label,
    this.fontSize,
    Key? key,
  }) : super(key: key);
  final FormControl formControl;
  final List<String>? items;
  final String? label;
  final double? fontSize;
  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  List<DropdownMenuItem> items = [];

  void _onInit() {
    if (widget.items != null) {
      items = widget.items!
          .map((value) => DropdownMenuItem(value: value, child: Text(value)))
          .toList();
    }
  }

  @override
  void initState() {
    super.initState();
    _onInit();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveDropdownField(
      style: TextStyle(
        fontSize: widget.fontSize,
        height: 0.9,
        color: CustomColors.pageContentColor1,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 16, top: 10, bottom: 14),
        focusColor: CustomColors.pageNameAndBorderColor,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: CustomColors.pageNameAndBorderColor, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: CustomColors.pageNameAndBorderColor,
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        labelText: widget.label ?? '',
        labelStyle: const TextStyle(
            color: CustomColors.pageContentColor1,
            fontFamily: CustomFonts.sitkaFonts),
        hintText: '',
        hintStyle: const TextStyle(
            color: CustomColors.pageContentColor2,
            fontFamily: CustomFonts.sitkaFonts),
      ),
      formControl: widget.formControl,
      items: items,
    );
  }
}
