import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:untitled_design/database/contact_list.dart';
import 'package:untitled_design/database/database.dart';
import 'package:untitled_design/database/user.dart';
import 'package:untitled_design/styles/styles.dart';
import 'package:untitled_design/widgets/widgets.dart';

import '../../../../controllers/UserController.dart';
import '../../../app.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  UserController b = Get.put(UserController());

  final FormGroup contactForm = FormGroup({
    'name1': FormControl(),
    'phoneNumber1': FormControl<int>(),
    'name2': FormControl(),
    'phoneNumber2': FormControl<int>(),
    'name3': FormControl(),
    'phoneNumber3': FormControl<int>(),
  });

  @override
  _write(String text) async {
    UserController a = new UserController();
    a.index(text);
  }

  Future<String> bringInfo(which) async {
    var re = await b.readInfo('${which.toString()}');
    print("re:" + re);
    String which_ = await b.readInfo(which);
    print("which_:" + which_); //Just for now I need to find which one is better
    if (b.readInfo('$which') != "") return re.toString();

    return "Empty";
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);
    // final abc = Provider.of<List<ContactList>>(context);
    return StreamBuilder<ContactData>(
      stream: DatabaseService(user?.userId).contactData,
      builder:(context, snapshot){
        if(snapshot.hasData){

          ContactData? contactData = snapshot.data;
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
                        Text( 'Contacts' ,
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
                      child: ReactiveForm(
                        formGroup: contactForm,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            CustomCardTile(
                              icon: 'person',
                              title: '${contactData?.cntct1Name}',
                              iconData: contactData?.cntct1Name == "Add Contact Name"
                                  ? Icons.control_point_outlined
                                  : Icons.edit_outlined,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddEditContact(
                                      isFirst: true,
                                      isSec: false,
                                      isThird: false,
                                      uid: user?.userId,
                                      name: contactData?.cntct1Name,
                                      number: contactData?.cntct1Num,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: Sizes.s24),
                            CustomCardTile(
                              icon: 'person',
                              title: '${contactData?.cntct2Name}',
                              iconData: contactData?.cntct2Name == "Add Contact Name"
                                  ? Icons.control_point_outlined
                                  : Icons.edit_outlined,
                              onTap: () {
                                _write('2');

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddEditContact(
                                      isFirst: false,
                                      isSec: true,
                                      isThird: false,
                                      uid: user?.userId,
                                      name: contactData?.cntct2Name,
                                      number: contactData?.cntct2Num,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: Sizes.s24),
                            CustomCardTile(
                              icon: 'person',
                              title: '${contactData?.cntct3Name}',
                              iconData: contactData?.cntct3Name == "Add Contact Name"
                                  ? Icons.control_point_outlined
                                  : Icons.edit_outlined,
                              onTap: () {
                                _write('3');

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddEditContact(
                                      isFirst: false,
                                      isSec: false,
                                      isThird: true,
                                      uid: user?.userId,
                                      name: contactData?.cntct3Name,
                                      number: contactData?.cntct3Num,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }else{
          return Scaffold(
            body: Center(
              child: Text("No Data"),
            ),
          );
        }

      },
    );
  }
}
