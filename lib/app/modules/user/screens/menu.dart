import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled_design/app/app.dart';
import 'package:untitled_design/app/modules/user/screens/contacts.dart';
import 'package:untitled_design/styles/styles.dart';
import 'package:untitled_design/widgets/widgets.dart';

import '../../../../controllers/UserController.dart';

class UserMenu extends StatelessWidget {
  const UserMenu({Key? key}) : super(key: key);

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
                  const Text(
                    'Menu',
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
                  top: MediaQuery.of(context).size.height * 0.2,
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    CustomCardTile(
                      icon: 'contact',
                      title: 'Contact',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Contacts(),
                        ),
                      ),
                    ),
                    const SizedBox(height: Sizes.s24),
                    CustomCardTile(
                        icon: 'history',
                        title: 'Medical History',
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MedicalHistory(),
                              ),
                            )),
                    const SizedBox(height: Sizes.s24),
                    CustomCardTile(
                      icon: 'language',
                      title: 'Language',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Language(),
                        ),
                      ),
                    ),
                    const SizedBox(height: Sizes.s24),
                    CustomCardTile(
                      icon: 'logout',
                      title: 'Logout',
                      onTap: () async {
                        UserController a = new UserController();
                        await a.signOut();
                        Get.offAll(Login());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
