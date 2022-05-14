import 'package:flutter/material.dart';
import 'package:untitled_design/styles/styles.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({required this.child, this.radius = 21.0, Key? key})
      : super(key: key);
  final Widget child;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: CustomColors.pageNameAndBorderColor,
      radius: radius,
      child: CircleAvatar(
        foregroundColor: CustomColors.pageNameAndBorderColor,
        backgroundColor: CustomColors.backgroundColor,
        radius: radius - 1,
        child: child,
      ),
    );
  }
}
