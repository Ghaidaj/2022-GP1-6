import 'package:flutter/material.dart';
import 'package:untitled_design/styles/styles.dart';
import 'package:untitled_design/utils/utils.dart';

class CustomCardTile extends StatelessWidget {
  const CustomCardTile({
    required this.icon,
    required this.title,
    this.onTap,
    this.iconData = Icons.arrow_forward,
    Key? key,
  }) : super(key: key);
  final String icon, title;
  final VoidCallback? onTap;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: Sizes.s64,
        child: Card(
          elevation: 5,
          child: ListTile(
            leading: SizedBox(
              height: Sizes.s40,
              child: Image.asset(icon.png),
            ),
            title: Text(
              title,
              style: const TextStyle(
                color: CustomColors.pageContentColor1,
                fontWeight: FontWeight.bold,
                fontSize: Sizes.sPageContent,
                fontFamily: CustomFonts.sitkaFonts,
              ),
            ),
            trailing: Icon(
              iconData,
              color: CustomColors.pageContentColor1,
              size: Sizes.s32 + 4,
            ),
          ),
        ),
      ),
    );
  }
}
