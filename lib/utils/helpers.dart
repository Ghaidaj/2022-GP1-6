import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:url_launcher/url_launcher.dart';

class Helpers {
  static Future<void> makeCall(phone) async {
    try {
      String url = phone;
      if (await canLaunch(url))
        await launch(url);
      else
        print("could not launch call app");
    } catch (e) {
      print(e);
    }
  }

  static String hashPassword(String password) {
    var encode = utf8.encode(password);
    var hash = sha1.convert(encode);
    return hash.toString();
  }
}
