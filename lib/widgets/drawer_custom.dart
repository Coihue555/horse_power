import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horse_power/theme/theme.dart';
import 'package:horse_power/views/auth.dart';
import 'package:horse_power/widgets/text/text_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final User? user = Auth().currentUser;
    return Drawer(
      backgroundColor: Colors.white,
      child: Stack(
        children: [
          ListView(
            children: [
              SizedBox(height: 200, child: Image.asset('assets/images/icon-710x599-android.png')),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget.headLineMedium(texto: 'Horse Power'),
                    TextWidget.textSmall(texto: 'v0.1'),
                  ],
                ),
              ),
              const Divider(
                height: 4,
                thickness: 0.5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextWidget.textLarge(maxlineas: 3, texto: 'Usuario: ${user?.email}'),
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                ),
                title: TextWidget.headLineSmall(texto: 'Inicio'),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/',
                  );
                },
              ),
              // ListTile(
              //   leading: const Icon(
              //     FontAwesomeIcons.horse,
              //   ),
              //   title: TextWidget.headLineSmall(texto: 'Madres'),
              //   onTap: () {
              //     Navigator.pushNamed(
              //       context,
              //       'lstMadres',
              //     );
              //   },
              // ),
              // ListTile(
              //   leading: const Icon(
              //     FontAwesomeIcons.horseHead,
              //   ),
              //   title: TextWidget.headLineSmall(texto: 'Padres'),
              //   onTap: () {
              //     Navigator.pushNamed(
              //       context,
              //       'lstPadres',
              //     );
              //   },
              // ),
              // ListTile(
              //   leading: const Icon(
              //     FontAwesomeIcons.houseChimneyMedical,
              //   ),
              //   title: TextWidget.headLineSmall(texto: 'Receptoras'),
              //   onTap: () {
              //     Navigator.pushNamed(
              //       context,
              //       'lstReceptoras',
              //     );
              //   },
              // ),
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.fileMedical,
                ),
                title: TextWidget.headLineSmall(texto: 'Casos Clínicos'),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'lstCasos',
                  );
                },
              )
            ],
          ),
          Positioned(
            bottom: 0,
            child: InkWell(
              onTap: () {
                Auth().signOut();
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ThemeModel().colorPrimario,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    TextWidget.headLineSmall(
                      texto: 'Cerrar Sesión',
                      colorTextoDark: Colors.white,
                      colorTextoLight: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
