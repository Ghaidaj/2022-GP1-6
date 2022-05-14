import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:untitled_design/app/modules/user/screens/categories.dart';
import 'package:untitled_design/app/modules/user/screens/nearest_type_fi.dart';
import 'package:untitled_design/constants/messages.dart';
import 'package:untitled_design/controllers/medicalHistoryController.dart';
import 'package:untitled_design/database/database.dart';
import 'package:untitled_design/database/user.dart';

import '../../../../controllers/UserController.dart';
import '../../../../controllers/profileController.dart';
import '../../../../styles/styles.dart';
import '../../../../widgets/widgets.dart';
import 'package:geolocator/geolocator.dart';

var contact1Num = null;
var contact2Num = null;
var contact3Num = null;

class SendCircumstances extends StatefulWidget {
  const SendCircumstances({Key? key}) : super(key: key);

  @override
  State<SendCircumstances> createState() => _SendCircumstancesState();
}

class _SendCircumstancesState extends State<SendCircumstances> {
  final String username = Get.find<UserController>().userNameController.text;

  int _start = 5;
  Timer? _timer;
  late GpsManager _gpsManager;
  @override
  void initState() {
    super.initState();
    _gpsManager = GpsManager();
    _getUserLocation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);

    return StreamBuilder<ContactData>(
      stream: DatabaseService(user?.userId).contactData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ContactData? contactData = snapshot.data;
          contact1Num = contactData?.cntct1Num;
          contact2Num = contactData?.cntct2Num;
          contact3Num = contactData?.cntct3Num;
          return Scaffold(
            backgroundColor: CustomColors.backgroundColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: CustomColors.backgroundColor,
              automaticallyImplyLeading: false,
              title: const Center(
                child: Text(
                  'Help Me',
                  style: TextStyle(
                    color: CustomColors.pageNameAndBorderColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: CustomFonts.sitkaFonts,
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(Sizes.s16),
              child: Center(
                child: _gpsManager.userPosition != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Your location and situation will be sent to your contacts within',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: CustomFonts.sitkaFonts,
                              color: CustomColors.pageContentColor1,
                              fontSize: Sizes.sPageContent,
                            ),
                          ),
                          const SizedBox(height: Sizes.s24),
                          Text('00:0$_start'),
                          const SizedBox(height: Sizes.s24),
                          CustomElevatedButton(
                            height: Sizes.s40,
                            width: Sizes.s96,
                            onPressed: () => Navigator.pop(context),
                            title: 'Cancel',
                          )
                        ],
                      )
                    : Text("Please wait for Access Location...."),
              ),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  void startTimer() {
    const sec = Duration(seconds: 1);
    _timer = Timer.periodic(
      sec,
      (Timer timer) async {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
          await sendSms();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Categories(text: 'Help Me'),
            ),
          );
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Future<void> sendSms() async {
    var phoneCnt1 = contact1Num ?? 'Add Contact Num';
    var phoneCnt2 = contact2Num ?? 'Add Contact Num';
    var phoneCnt3 = contact3Num ?? 'Add Contact Num';

    var hypertension = null;
    var heartDisease = null;
    var bloodGroup = null;
    var diabetic = null;
    var medCollection = FirebaseFirestore.instance.collection('medicalHistory');
    var medQuerySnapshot = await medCollection.get();
    for (var medQueryDocSnapShot in medQuerySnapshot.docs) {
      Map<String, dynamic> data = medQueryDocSnapShot.data();
      hypertension = data['hypertension'];
      heartDisease = data['heartDisease'];
      bloodGroup = data['bloodGroup'];
      diabetic = data['diabetic'];
    }
    const platform = const MethodChannel('sendSms');
    //
    try {
      String phoneNumbers; // Get to send numbers with comma
      if (phoneCnt1 != 'Add Contact Num' &&
          phoneCnt2 != 'Add Contact Num' &&
          phoneCnt3 != 'Add Contact Num') {
        phoneNumbers = "$phoneCnt1,$phoneCnt2,$phoneCnt3";
      } else if (phoneCnt1 != 'Add Contact Num' &&
          phoneCnt2 != 'Add Contact Num') {
        phoneNumbers = "$phoneCnt1,$phoneCnt2";
      } else if (phoneCnt1 != 'Add Contact Num' &&
          phoneCnt3 != 'Add Contact Num') {
        phoneNumbers = "$phoneCnt1,$phoneCnt3";
      } else if (phoneCnt2 != 'Add Contact Num' &&
          phoneCnt3 != 'Add Contact Num') {
        phoneNumbers = "$phoneCnt2,$phoneCnt3";
      } else {
        phoneNumbers = "$phoneCnt1";
      }
      if (hypertension == true) {
        setState(() {
          hypertension = 'Yes';
        });
      }
      if (heartDisease == true) {
        setState(() {
          heartDisease = 'Yes';
        });
      }
      if (diabetic == true) {
        setState(() {
          diabetic = 'Yes';
        });
      }
      print(phoneNumbers);
      print(phoneCnt1);
      print(phoneCnt2);
      print(phoneCnt3);
      String message =
          Messages.emergencyMessage.replaceAll("#UserName#", "$username")
          // .replaceAll('#hypertension#', '${hypertension}')
          //  .replaceAll('#heartDisease#', '$heartDisease')
          //  .replaceAll('#bloodGroup#', '$bloodGroup')
          // .replaceAll('#diabetic#', '$diabetic')
          ; // Get Current UserName

      if (_gpsManager.userPosition != null) {
        message = message
            .replaceAll("#Lat#", _gpsManager.userPosition!.latitude.toString())
            .replaceAll(
                "#Long#", _gpsManager.userPosition!.longitude.toString());
      }

      final String result = await platform.invokeMethod('send',
          <String, dynamic>{"phoneNumbers": phoneNumbers, "message": message});

      print(result);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  _getUserLocation() async {
    await _gpsManager.getCoordinates();
    if (_gpsManager.userPosition != null) {
      startTimer();
    }
  }
}
