import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reminder_app/auth/login_screen.dart';
import 'package:reminder_app/firebase_options.dart';
import 'package:reminder_app/general/general.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  
  Platform.isAndroid
      ? await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCSGB0WTLmQEFuufR3K8wXdb-nucNWzqKE",
        appId: "1:812955848930:android:1e16c8f482b5e8951fcebb",
        messagingSenderId: "812955848930",
        projectId: "fir-example-33c88"
    )
  ) :

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //FirebaseAuth.instance.signOut();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
       home:
      // sharedPreferences!.getString("uid") != null
      //     ? HomeScreen():
           LoginScreen(),
    );
  }
}
