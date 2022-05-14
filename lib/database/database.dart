
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled_design/database/contact_list.dart';
import 'package:untitled_design/database/user.dart';

class DatabaseService{
  final String? uid;
  DatabaseService([this.uid]);

  // Collection refrence
  final CollectionReference contact = FirebaseFirestore.instance.collection('contacts');
  //Function for Creating a collection
  Future updateUserData(String? cntct1Name,String? cntct2Name , String? cntct3Name,
      String? cntct1Num, String? cntct2Num , String? cntct3Num )async{

    return await contact.doc(uid).set({
      'contact-1-name' : cntct1Name,
      'contact-2-name' : cntct2Name,
      'contact-3-name' : cntct3Name,
      'contact-1-number' : cntct1Num,
      'contact-2-number' : cntct2Num,
      'contact-3-number' : cntct3Num,
    });
  }
  // gettingsnapSHot for our ContactData Class
  ContactData _getContactDataFromSnapshot(DocumentSnapshot snapshot){
    return ContactData(
      uid: uid,
      cntct1Name: snapshot['contact-1-name'],
      cntct2Name: snapshot['contact-2-name'],
      cntct3Name: snapshot['contact-3-name'],
      cntct1Num: snapshot['contact-1-number'],
      cntct2Num: snapshot['contact-2-number'],
      cntct3Num: snapshot['contact-3-number'],
    );
  }

  // creating a list for using QuerySnapShot
  List<ContactList> _contactListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return ContactList(
        cntct1Name: doc['contact-1-name'] ?? 'Add Contact' ,
        cntct2Name: doc['contact-2-name'] ?? 'Add Contact' ,
        cntct3Name: doc['contact-3-name'] ?? 'Add Contact' ,
        cntct1Num: doc['contact-1-number'] ?? 'Add number',
        cntct2Num: doc['contact-2-number'] ?? 'Add number',
        cntct3Num: doc['contact-3-number'] ?? 'Add number',
      );
    }).toList();
  }

  // setting up stream for contacts
  Stream<List<ContactList>> get contacts{
    return contact.snapshots()
    .map((_contactListFromSnapshot));
  }

  // Stream for contactsData
  Stream<ContactData> get contactData{
    return contact.doc(uid).snapshots()
    .map(_getContactDataFromSnapshot);
  }
}