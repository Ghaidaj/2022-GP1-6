import 'package:flutter/material.dart';
import 'package:untitled_design/styles/styles.dart';
import 'package:untitled_design/utils/utils.dart';
import 'package:untitled_design/widgets/circle_avatar.dart';
import 'package:untitled_design/widgets/text_button.dart';

class Language extends StatelessWidget {
  const Language({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(Sizes.s8),
        child: Column(
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
                  'Language',
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
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.23,
                left: Sizes.s16,
                right: Sizes.s16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildCustomCircleAvatar(),
                  buildCustomCircleAvatar(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Sizes.s16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildText('English'),
                  buildText('Arabic'),
                ],
              ),
            ),
            const SizedBox(height: Sizes.s24),
            CustomTextButton(
              title: 'save',
              fontSize: Sizes.sPageContent,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    ));
  }

  Text buildText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: CustomColors.pageContentColor1,
        fontFamily: CustomFonts.sitkaFonts,
        fontWeight: FontWeight.bold,
        fontSize: Sizes.sPageContent,
        shadows: [Shadow(color: CustomColors.shadow, blurRadius: 3.0)],
      ),
    );
  }

  CustomCircleAvatar buildCustomCircleAvatar() {
    return CustomCircleAvatar(
      radius: Sizes.s56,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: CustomColors.shadow,
              spreadRadius: 1.5,
              blurRadius: 2,
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(Sizes.s64),
          image: DecorationImage(
            image: AssetImage('language'.png),
          ),
        ),
      ),
    );
  }
}
