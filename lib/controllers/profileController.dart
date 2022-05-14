import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:untitled_design/controllers/UserController.dart';

class ProfileController extends GetxController {
  Map<String, dynamic> userProfilePatch = {};

  FormGroup userProfileForm = FormGroup({
    'firstName': FormControl(),
    'lastName': FormControl(),
    'phoneNumber': FormControl(),
    'gender': FormControl(),
    'birthDate': FormControl<DateTime>(),
    'height': FormControl(),
    'weight': FormControl(),
    'deafMute': FormControl<bool>(),
  });

  Future<void> saveUserProfile() async {
    bool updated = false;
    try {
      await FirebaseFirestore.instance
          .collection('userProfile')
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          for (var doc in querySnapshot.docs) {
            if (doc['userID'] == Get.find<UserController>().refId) {
              FirebaseFirestore.instance
                  .collection('userProfile')
                  .doc(doc.id)
                  .update(userProfileForm.value);
              FirebaseFirestore.instance
                  .collection('userProfile')
                  .doc(doc.id)
                  .update({'userID': Get.find<UserController>().refId});
              updated = true;
              break;
            }
          }
        }
      });
      if (!updated) {
        DocumentReference ref = await FirebaseFirestore.instance
            .collection('userProfile')
            .add(userProfileForm.value);
        ref.update({'userID': Get.find<UserController>().refId});
      }
    } on FirebaseAuthException catch (_) {}
  }

  Future<void> patchData() async {
    bool newUser = true;
    await FirebaseFirestore.instance
        .collection('userProfile')
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          if (doc['userID'] == Get.find<UserController>().refId) {
            newUser = false;
            userProfilePatch = {
              'firstName': doc['firstName'],
              'lastName': doc['lastName'],
              'phoneNumber': doc['phoneNumber'],
              'gender': doc['gender'],
              'birthDate': doc['birthDate'] == null
                  ? doc['birthDate']
                  : doc['birthDate'].toDate(),
              'height': doc['height'],
              'weight': doc['weight'],
              'deafMute': doc['deafMute'],
            };
            break;
          }
        }
      }
    });
    if (newUser) {
      userProfilePatch = {
        'firstName': '',
        'lastName': '',
        'phoneNumber': '',
        'gender': '',
        'birthDate': null,
        'height': '',
        'weight': '',
        'deafMute': false,
      };
    }
    userProfileForm.patchValue(userProfilePatch);
  }
}
