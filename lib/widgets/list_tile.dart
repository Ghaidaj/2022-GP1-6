import 'package:flutter/material.dart';
import 'package:untitled_design/styles/styles.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    required this.leading,
    required this.title,
    required this.trailing,
    Key? key,
  }) : super(key: key);
  final Widget leading;
  final String title;
  final Widget trailing;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: leading,
        title: Text(
          '\t\t' + title,
          style: const TextStyle(
            color: CustomColors.pageContentColor2,
            fontSize: Sizes.s20,
            fontFamily: CustomFonts.sitkaFonts,
          ),
        ),
        trailing: trailing,
      ),
    );
  }
}
