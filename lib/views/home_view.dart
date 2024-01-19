import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horse_power/views/configuracion/caballos_view.dart';
import 'package:horse_power/widgets/drawer_custom.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Horse Power',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: const MenuLateral(),
      body: const CaballosView(),
      floatingActionButton: FloatingActionButton(
        heroTag: 'tag1',
        onPressed: () async {
          await Navigator.pushNamed(context, 'fichaCaballo');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
