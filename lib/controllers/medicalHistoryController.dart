import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:untitled_design/controllers/UserController.dart';

class MedicalHistoryController extends GetxController {
  Map<String, dynamic> medicalHistoryPatch = {};

  final medicalHistoryForm = FormGroup({
    'hypertension': FormControl<bool>(),
    'heartDisease': FormControl<bool>(),
    'bloodGroup': FormControl(),
    'diabetic': FormControl<bool>(),
    'otherIllnesses': FormControl(),
    'allergicTo': FormControl(),
    'medicationDetails': FormControl(),
  });

  void saveMedicalHistory() async {
    bool updated = false;
    try {
      await FirebaseFirestore.instance
          .collection('medicalHistory')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc['userID'] == Get.find<UserController>().refId) {
            FirebaseFirestore.instance
                .collection('medicalHistory')
                .doc(doc.id)
                .update(medicalHistoryForm.value);
            FirebaseFirestore.instance
                .collection('medicalHistory')
                .doc(doc.id)
                .update({'userID': Get.find<UserController>().refId});
            updated = true;
          }
        }
      });
      if (!updated) {
        DocumentReference ref = await FirebaseFirestore.instance
            .collection('medicalHistory')
            .add(medicalHistoryForm.value);
        ref.update({'userID': Get.find<UserController>().refId});
      }
    } catch (e) {
      print("Expetion in Save.");
      print(e);
    }
  }

  Future<void> patchData() async {
    try {
      print("The ID in Get.find<UserController>().refId found is:" +
          Get.find<UserController>().refId.toString());
      bool newRecord = true;
      await FirebaseFirestore.instance
          .collection('medicalHistory')
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          for (var doc in querySnapshot.docs) {
            if (doc['userID'] == Get.find<UserController>().refId) {
              newRecord = false;
              medicalHistoryPatch = {
                'hypertension': doc['hypertension'],
                'heartDisease': doc['heartDisease'],
                'bloodGroup': doc['bloodGroup'],
                'diabetic': doc['diabetic'],

              };
              break;
            }
          }
        }
      });
      if (newRecord) {
        medicalHistoryPatch = {
          'hypertension': false,
          'heartDisease': false,
          'bloodGroup': '',
          'diabetic': false,
          'otherIllnesses': '',
          'allergicTo': '',
          'medicationDetails': '',
        };
      }
      medicalHistoryForm.patchValue(medicalHistoryPatch);
    } catch (e) {
      print("Expetion in patchData");
      print(e);
    }
  }
}
