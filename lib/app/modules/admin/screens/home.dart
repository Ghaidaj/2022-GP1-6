import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:untitled_design/app/app.dart';
import 'package:untitled_design/controllers/UserController.dart';
import 'package:untitled_design/controllers/adminHomeController.dart';
import 'package:untitled_design/styles/styles.dart';
import 'package:untitled_design/utils/utils.dart';
import 'package:untitled_design/widgets/widgets.dart';

class AdminHome extends StatelessWidget {
  AdminHome({Key? key}) : super(key: key);

  final _controller = Get.put(AdminHomeController());

  void _onEdit(BuildContext context, String username) async {
    await _controller.patchUserData(username);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminProfile(
          username: username,
        ),
      ),
    );
  }

  void _onDelete(BuildContext context, String username) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogBox(
        deleteUser: username,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(Sizes.s8),
          child: ReactiveForm(
            formGroup: _controller.searchForm,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        UserController a = new UserController();
                        a.signOut();
                        Get.offAll(Login());
                      },
                      icon: const Icon(
                        Icons.logout,
                        size: Sizes.sPageName,
                        color: CustomColors.pageContentColor1,
                      ),
                    ),
                    const Text(
                      'List of Users',
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.s8,
                    vertical: Sizes.s24,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildIconCard('userIcon', 'Admin Name', () {}),
                      _buildIconCard(
                        'menu',
                        'DashBoard',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Dashboard(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Sizes.s24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.s8),
                  child: CustomTextField(
                    formControl:
                        _controller.searchForm.control('search') as FormControl,
                    required: false,
                    prefixIcon: const Icon(
                      Icons.search_sharp,
                      color: CustomColors.pageNameAndBorderColor,
                    ),
                    suffixIcon: ReactiveValueListenableBuilder(
                      formControl: _controller.searchForm.control('search'),
                      builder: (context, control, child) {
                        if (control.value == '') {
                          _controller.searchUser();
                          return const SizedBox.shrink();
                        } else {
                          _controller.searchUser();
                          return IconButton(
                            onPressed: () async {
                              control.value = '';
                              // await _controller.searchUser();
                            },
                            icon: const Icon(
                              Icons.clear,
                              color: CustomColors.pageNameAndBorderColor,
                            ),
                          );
                        }
                      },
                    ),
                    hint: 'search for a user',
                    circularRadius: Sizes.s8 / 2,
                    height: Sizes.s40,
                  ),
                ),
                const SizedBox(height: Sizes.s24),
                Obx(
                  () => Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: Sizes.s8),
                      shrinkWrap: true,
                      itemCount: _controller.users.length,
                      itemBuilder: (_, index) {
                        return Column(
                          children: [
                            CustomListTile(
                              leading: const CustomCircleAvatar(
                                child: Icon(
                                  Icons.person_outlined,
                                  size: Sizes.s32,
                                ),
                              ),
                              title: _controller.users[index],
                              trailing: SizedBox(
                                width: Sizes.s88,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () => _onEdit(
                                          context, _controller.users[index]),
                                      child: const Icon(
                                        Icons.edit_outlined,
                                        size: Sizes.s40,
                                        color: CustomColors.pageContentColor1,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => _onDelete(
                                          context, _controller.users[index]),
                                      child: const Icon(
                                        Icons.clear_outlined,
                                        size: Sizes.s40,
                                        color: CustomColors.pageContentColor1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: Sizes.s8),
                          ],
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
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
