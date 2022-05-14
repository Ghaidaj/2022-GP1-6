import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AdminHomeController extends GetxController {
  RxList<String> users = <String>[].obs;

  final searchForm = FormGroup({
    'search': FormControl(value: ''),
  });

  final adminProfileForm = FormGroup({
    'firstName': FormControl(),
    'lastName': FormControl(),
    'phoneNumber': FormControl(),
  });

  Future<void> getAllUsers() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        List<String> _users = [];
        for (var doc in querySnapshot.docs) {
          _users.add(doc['username']);
        }
        // users.clear();
        users.value = _users;
      }
    });
  }

  Future<void> searchUser() async {
    String username = searchForm.control('search').value;
    if (username.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('Users')
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          List<String> _users = [];
          for (var doc in querySnapshot.docs) {
            if (doc['username'] == username) {
              _users.add(doc['username']);
            }
          }
          users.clear();
          users.value = _users;
        }
      });
    } else {
      await getAllUsers();
    }
  }

  Future<void> deleteUser(String username) async {
    String _userId = '';
    await FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          if (doc['username'] == username) {
            _userId = doc.id;
            await FirebaseFirestore.instance
                .collection('Users')
                .doc(_userId)
                .delete();
            await getAllUsers();
            break;
          }
        }
      }
    });
    await FirebaseFirestore.instance
        .collection('userProfile')
        .get()
        .then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          if (doc['userID'] == _userId) {
            await FirebaseFirestore.instance
                .collection('userProfile')
                .doc(doc.id)
                .delete();
            break;
          }
        }
      }
    });
    await FirebaseFirestore.instance
        .collection('medicalHistory')
        .get()
        .then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          if (doc['userID'] == _userId) {
            await FirebaseFirestore.instance
                .collection('medicalHistory')
                .doc(doc.id)
                .delete();
            break;
          }
        }
      }
    });
  }

  Future<void> editUserProfile(String username) async {
    String _userId = '';
    bool newRecord = true;
    await FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          if (doc['username'] == username) {
            _userId = doc['userID'];
            await FirebaseFirestore.instance
                .collection('Users')
                .doc(_userId)
                .update(
                {'phone': adminProfileForm.control('phoneNumber').value});
            break;
          }
        }
      }
    });

    await FirebaseFirestore.instance
        .collection('userProfile')
        .get()
        .then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          if (doc['userID'] == _userId) {
            newRecord = false;
            await FirebaseFirestore.instance
                .collection('userProfile')
                .doc(doc.id)
                .update(adminProfileForm.value);
            break;
          }
        }
      }
    });
    if (newRecord) {
      DocumentReference ref = await FirebaseFirestore.instance
          .collection('userProfile')
          .add(adminProfileForm.value);
      ref.update({'userID': _userId});
    }
  }

  Future<void> patchUserData(String username) async {
    String _userId = '';
    Map<String, dynamic> _adminData = {
      'firstName': '',
      'lastName': '',
      'phoneNumber': ''
    };
    await FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          if (doc['username'] == username) {
            _userId = doc['userID'];
            break;
          }
        }
      }
    });
    await FirebaseFirestore.instance
        .collection('userProfile')
        .get()
        .then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          if (doc['userID'] == _userId) {
            _adminData['firstName'] = doc['firstName'];
            _adminData['lastName'] = doc['lastName'];
            _adminData['phoneNumber'] = doc['phoneNumber'];
            break;
          }
        }
      }
    });
    adminProfileForm.patchValue(_adminData);
  }
}