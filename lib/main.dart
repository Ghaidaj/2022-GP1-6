import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:untitled_design/app/modules/user/screens/maps.dart';
import 'package:untitled_design/controllers/UserController.dart';
import 'package:untitled_design/database/user.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initPermissions();
    return StreamProvider<FirebaseUser?>.value(
      value: UserController().user,
      initialData: null,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: GetMaterialApp(
          scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
          debugShowCheckedModeBanner: false,
          title: '',
          theme: ThemeData(),
          home: SafeArea(child: Login()),
        ),
      ),
    );
  }

  Future<void> initPermissions() async {
    GpsManager gpsManager = GpsManager();
    await gpsManager.checkPermission();
  }
}
