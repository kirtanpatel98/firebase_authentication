import 'package:firebase_authentication/bindings/shop_bindings.dart';
import 'package:firebase_authentication/screens/products/ui/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'data/database/hive_db.dart';
import 'data/theme/app_theme.dart';
import 'screens/auth/ui/login_page.dart';

//! STATE MANAGEMENT USED GET
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initHive();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().appThemeData,
      initialBinding: ShopBindings(),
      defaultTransition: Transition.topLevel,
      home: LoginPage(),
    );
  }
}

class AuthHelper extends StatelessWidget {
  const AuthHelper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, value) {
        if (HiveX.userID == null || HiveX.userID == "") {
          return LoginPage();
        }
        return HomePage();
      },
    );
  }
}
