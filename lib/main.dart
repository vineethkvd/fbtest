import 'package:fbtest/screens/adduser.dart';
import 'package:fbtest/screens/homepage.dart';
import 'package:fbtest/screens/updateuser.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/':(context) => HomePage(),
        '/adduser':(context) => AddUser(),
        '/updateuser':(context) => UpdateUser()
      },
      initialRoute: '/',
    );
  }
}
