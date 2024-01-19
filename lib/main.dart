import 'package:flutter/material.dart';
import 'package:horse_power/views/configuracion/caballos_view.dart';
import 'package:horse_power/views/configuracion/ficha_caballo_view.dart';
import 'package:horse_power/views/configuracion/ficha_madre_view.dart';
import 'package:horse_power/views/configuracion/ficha_padre_view.dart';
import 'package:horse_power/views/configuracion/ficha_receptora_view.dart';
import 'package:horse_power/views/configuracion/madres_view.dart';
import 'package:horse_power/views/configuracion/padres_view.dart';
import 'package:horse_power/views/configuracion/receptoras_view.dart';
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
      // 'addName': (context) => const AddNameView(),
      // 'editName': (context) => const EditHorseView(),
      'lstCaballos': (context) => const CaballosView(),
      'fichaCaballo': (context) => const FichaCaballoView(),
      'lstMadres': (context) => const MadresView(),
      'fichaMadre': (context) => const FichaMadreView(),
      'lstPadres': (context) => const PadresView(),
      'fichaPadre': (context) => const FichaPadreView(),
      'lstReceptoras': (context) => const ReceptorasView(),
      'fichaReceptora': (context) => const FichaReceptoraView(),
    });
  }
}
