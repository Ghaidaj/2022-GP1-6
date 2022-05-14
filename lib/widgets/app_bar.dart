import 'package:flutter/material.dart';
import 'package:untitled_design/styles/styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    this.title,
    this.automaticallyImplyLeading = false,
    Key? key,
  }) : super(key: key);
  final String? title;
  final bool automaticallyImplyLeading;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: Center(
        child: Text(
          title ?? '',
          style: const TextStyle(
            color: CustomColors.pageNameAndBorderColor,
            fontWeight: FontWeight.bold,
            fontFamily: CustomFonts.sitkaFonts,
          ),
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
