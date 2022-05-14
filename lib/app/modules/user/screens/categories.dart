import 'package:flutter/material.dart';
import 'package:untitled_design/app/modules/user/screens/nearest.dart';
import 'package:untitled_design/utils/utils.dart';
import 'package:untitled_design/widgets/shadowed_card.dart';

import '../../../../styles/styles.dart';

class Categories extends StatelessWidget {
  const Categories({required this.text, Key? key}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        resizeToAvoidBottomInset: false,
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
                  Text(
                    text,
                    style: const TextStyle(
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
                    top: MediaQuery.of(context).size.height * 0.2),
                child: Column(
                  children: [
                    buildRow(
                      'Ambulance',
                      'ambulance',
                      () async =>
                          await Helpers.makeCall(PhoneNumbers.Ambulance),
                      'Civil defence',
                      'civildefence',
                      () async => await Helpers.makeCall(PhoneNumbers.Civil),
                    ),
                    const SizedBox(height: Sizes.s40),
                    buildRow(
                      'Police',
                      'police',
                      () async => await Helpers.makeCall(PhoneNumbers.Police),
                      'Other',
                      'otheremergency',
                      () async => await Helpers.makeCall(PhoneNumbers.Addition),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIconCard(
                    'map',
                    'Map',
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Nearest(text: text),
                      ),
                    ),
                    10,
                    Sizes.s8 / 3,
                  ),
                  // const Spacer(),
                  _buildIconCard(
                    'chatbot',
                    'Chatbot',
                    () {},
                    10,
                    Sizes.s8 / 3,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildRow(
    String t1,
    String i1,
    VoidCallback tap1,
    String t2,
    String i2,
    VoidCallback tap2,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShadowedCard(
          radius: 10,
          child: buildCard(tap1, i1, t1),
        ),
        const SizedBox(width: Sizes.s40),
        ShadowedCard(
          radius: 10,
          child: buildCard(
            tap2,
            i2,
            t2,
          ),
        ),
      ],
    );
  }

  InkWell buildCard(VoidCallback onTap, String icon, String title) {
    const imageSize = Sizes.s80;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Sizes.s16, horizontal: Sizes.s8),
        child: SizedBox(
          width: Sizes.s128,
          child: Column(
            children: [
              SizedBox(
                height: imageSize,
                width: imageSize,
                child: Image.asset(icon.png),
              ),
              const SizedBox(height: Sizes.s16),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: CustomFonts.sitkaFonts,
                  fontSize: Sizes.sPageContent,
                  color: CustomColors.pageContentColor2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconCard(
    String icon,
    String title,
    VoidCallback onTap, [
    double radius = 100,
    double padding = 0,
  ]) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          ShadowedCard(
            radius: radius,
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: ImageIcon(
                AssetImage(icon.png),
                size: Sizes.s40,
                color: CustomColors.pageContentColor1,
              ),
            ),
          ),
          const SizedBox(height: Sizes.s8 / 2),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: CustomFonts.sitkaFonts,
              color: CustomColors.pageContentColor1,
            ),
          ),
        ],
      ),
    );
  }
}
