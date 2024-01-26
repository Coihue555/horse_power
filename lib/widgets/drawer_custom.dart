import 'package:flutter/material.dart';
import 'package:horse_power/widgets/text/text_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
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
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.horse,
            ),
            title: TextWidget.headLineSmall(texto: 'Madres'),
            onTap: () {
              Navigator.pushNamed(
                context,
                'lstMadres',
              );
            },
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.horseHead,
            ),
            title: TextWidget.headLineSmall(texto: 'Padres'),
            onTap: () {
              Navigator.pushNamed(
                context,
                'lstPadres',
              );
            },
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.houseChimneyMedical,
            ),
            title: TextWidget.headLineSmall(texto: 'Receptoras'),
            onTap: () {
              Navigator.pushNamed(
                context,
                'lstReceptoras',
              );
            },
          ),
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
    );
  }
}
