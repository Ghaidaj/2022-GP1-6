import 'package:flutter/material.dart';
import 'package:untitled_design/styles/styles.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    required this.title,
    required this.onPressed,
    this.height = Sizes.s24,
    this.width = Sizes.s88,
    Key? key,
  }) : super(key: key);
  final String title;
  final VoidCallback onPressed;
  final double height, width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(CustomColors.pageContentColor1),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: CustomFonts.sitkaFonts,
          ),
        ),
      ),
    );
  }
}
