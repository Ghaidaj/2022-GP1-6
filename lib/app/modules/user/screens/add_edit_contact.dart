import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:untitled_design/app/modules/user/screens/contacts.dart';
import 'package:untitled_design/database/database.dart';
import 'package:untitled_design/database/user.dart';
import 'package:untitled_design/styles/styles.dart';
import 'package:untitled_design/widgets/elevated_button.dart';
import 'package:untitled_design/widgets/text_field.dart';
import 'package:untitled_design/controllers/UserController.dart';
import 'package:get/get.dart';
//For File reading :
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';



class AddEditContact extends StatelessWidget {
  final bool isFirst;
  final bool isSec;
  final bool isThird;
  final String? uid;
  final String? name;
  final String? number;
  AddEditContact({
    required this.isFirst,
    required this.isSec,
    required this.isThird,
    required this.uid,
    required this.name,
    required this.number,
  });
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameCtr= TextEditingController();
  TextEditingController numberCtr= TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);
    return StreamBuilder<ContactData>(
      stream: DatabaseService(user?.userId).contactData,
      builder: (context, snapshot) {
        ContactData? data= snapshot.data;
        if(snapshot.hasData){
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
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
                        Text(
                          name!,
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
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.s32,
                        vertical: MediaQuery.of(context).size.height * 0.23,
                      ),
                      child: Column(
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  // initialValue: name,
                                  controller: nameCtr,
                                  validator: (val) => val!.isEmpty ? 'Enter Valid Name' : null   ,
                                  decoration: InputDecoration(
                                    labelText: '${name}',
                                    hintText: 'Contact Name',
                                    suffixIconColor: CustomColors.pageContentColor1,
                                    prefixIconColor: CustomColors.pageContentColor1,
                                    contentPadding: const EdgeInsets.only(left: 16, top: 10, bottom: 14),
                                    focusColor: CustomColors.pageNameAndBorderColor,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: CustomColors.pageNameAndBorderColor, width: 1),
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: CustomColors.pageNameAndBorderColor,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: Sizes.s24),
                                TextFormField(
                                  // initialValue: number,
                                  controller: numberCtr,
                                  validator:(val) {
                          String pattern =
                          r'((\05)|0)[.\- ]?[0-9][.\- ]?[0-9][.\- ]?[0-9]';
                          RegExp regex = RegExp(pattern);
                          if (val!.isEmpty) {
                           return "Phone required!";
                          } else if (!regex.hasMatch(val)) {
                           return 'Invalid Phone number format with 05 in the beginning!';
                          } else if (val.length != 10) {
                           return 'Please enter phone number with length of 10';
                          }
                          return null;
                          } ,
                                  decoration: InputDecoration(
                                    labelText: '${number}',
                                    hintText: 'Contact Number',
                                    suffixIconColor: CustomColors.pageContentColor1,
                                    prefixIconColor: CustomColors.pageContentColor1,
                                    contentPadding: const EdgeInsets.only(left: 16, top: 10, bottom: 14),
                                    focusColor: CustomColors.pageNameAndBorderColor,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: CustomColors.pageNameAndBorderColor, width: 1),
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: CustomColors.pageNameAndBorderColor,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: Sizes.s24),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all(CustomColors.pageContentColor1),
                                        ),
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancel')),
                                    const SizedBox(width: Sizes.s16),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all(CustomColors.pageContentColor1),
                                        ),
                                        onPressed: ()async{
                                          if(_formKey.currentState!.validate()){
                                            if(isFirst){
                                              await DatabaseService(uid).updateUserData(
                                                  nameCtr.text, data?.cntct2Name,
                                                  data?.cntct3Name, numberCtr.text,
                                                  data?.cntct2Num, data?.cntct3Num);

                                              Navigator.pop(context);
                                            }else if(isSec){
                                              await DatabaseService(uid).updateUserData(
                                                  data?.cntct1Name, nameCtr.text,
                                                  data?.cntct3Name, data?.cntct1Num,
                                                  numberCtr.text, data?.cntct3Num);
                                              Navigator.pop(context);
                                            }else if(isThird){
                                              await DatabaseService(uid).updateUserData(
                                                  data?.cntct1Name,data?.cntct2Name ,
                                                  nameCtr.text, data?.cntct1Num,data?.cntct2Num,
                                                  numberCtr.text);
                                              Navigator.pop(context);
                                            }
                                          }
                                        },
                                        child: Text('Update')),
                                  ],
                                )

                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }else{
          return CircularProgressIndicator();

        }
      });
  }
}


// Commented code
////import 'package:path_provider/path_provider.dart';
// UserController b = new UserController();
//
// const AddEditContact({
// required this.name,
// required this.phoneNumber,
// Key? key, required this.title,
// }) : super(key: key);
// final FormControl name, phoneNumber;
// final String title;
// @override
// Future<String> _read() async {
//   String text = "";
//   UserController a = new UserController();
//   text = await a.readIndex();
//
//   if (text != null)
//     return text;
//   else
//     print("Error in Contact Operations.. [2]");
//   return "1";
// }
//
// @override
// Future<String> bringInfo(which, index) async {
//   which = which.toString() + index.toString();
//
//   String re = await b.readInfo('$which');
//
//   if (b.readInfo('$which') != "") return re;
//   return "not set";
// }
//
// @override
// Future<String> bringInfoPhone(which, index) async {
//   which = which.toString() + index.toString();
//
//   String re = await b.readInfoPhone('$which');
//
//   if (b.readInfo('$which') != "") return re;
//   return "not set";
// }
//
// @override
// Widget build(BuildContext context) {
//   // String index = _read().toString(); //NEED AWAIT  // commented
//   return SafeArea(
//     child: Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: CustomColors.backgroundColor,
//       body: Padding(
//         padding: const EdgeInsets.all(Sizes.s8),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                   onPressed: () => Navigator.pop(context),
//                   icon: const Icon(
//                     Icons.arrow_back,
//                     color: CustomColors.pageContentColor1,
//                   ),
//                 ),
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontFamily: CustomFonts.sitkaFonts,
//                     color: CustomColors.pageNameAndBorderColor,
//                     fontSize: Sizes.sPageName,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(width: MediaQuery.of(context).size.width * 0.1),
//               ],
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: Sizes.s32,
//                 vertical: MediaQuery.of(context).size.height * 0.23,
//               ),
//               child: Column(
//                 children: [
//                   CustomTextField(
//                     label: name.value != null ? name.value : 'contact name',
//                     formControl: name,
//                   ),
//                   const SizedBox(height: Sizes.s24),
//                   CustomTextField(
//                     label: phoneNumber.value != null
//                         ? phoneNumber.value
//                         : 'contact phone number',
//                     formControl: phoneNumber,
//                   ),
//                   const SizedBox(height: Sizes.s24),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       CustomElevatedButton(
//                         title: 'Cancel',
//                         onPressed: () => Navigator.pop(context),
//                       ),
//                       CustomElevatedButton(
//                         title: 'Done',
//                         onPressed: () async {
//                           name.updateValue(name.value);
//                           phoneNumber.updateValue(phoneNumber.value);
//                           FocusScope.of(context).unfocus();
//
//                           UserController userController = Get.find();
//                           String ind = await _read();
//                           userController.DoContact(
//                               context, ind, name.value, phoneNumber.value);
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }
