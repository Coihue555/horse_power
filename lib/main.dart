import 'package:flutter/material.dart';
import 'package:horse_power/views/add_name_view.dart';
import 'package:horse_power/views/edit_name_view.dart';
import 'package:horse_power/views/home_view.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, title: 'Horse Power', initialRoute: '/', routes: {
      '/': (context) => const Home(),
      'addName': (context) => const AddNameView(),
      'editName': (context) => const EditNameView(),
    });
  }
}
