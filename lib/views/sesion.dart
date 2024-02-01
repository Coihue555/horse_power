import 'package:horse_power/views/auth.dart';
import 'package:horse_power/views/home_view.dart';
import 'package:horse_power/views/login_page.dart';
import 'package:flutter/material.dart';

class SesionView extends StatefulWidget {
  const SesionView({super.key});

  @override
  State<SesionView> createState() => _SesionViewState();
}

class _SesionViewState extends State<SesionView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const Home();
        } else {
          return const LoginView();
        }
      },
    );
  }
}
