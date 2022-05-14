class FirebaseUser{
 final String userId;
 FirebaseUser({required this.userId});
}

// Creating class for Contact Data
class ContactData{
 final String? uid;
 final String? cntct1Name;
 final String? cntct2Name;
 final String? cntct3Name;
 final String? cntct1Num;
 final String? cntct2Num;
 final String? cntct3Num;

 ContactData({
  this.uid,
  this.cntct1Name,
  this.cntct2Name,
  this.cntct3Name,
  this.cntct1Num,
  this.cntct2Num,
  this.cntct3Num
 });
}