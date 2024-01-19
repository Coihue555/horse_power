import 'package:horse_power/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: TextWidget.headLineSmall(texto: 'INICIO'),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/',
              );
            },
          ),
          ListTile(
            title: TextWidget.headLineSmall(texto: 'MADRES'),
            onTap: () {
              Navigator.pushNamed(
                context,
                'lstMadres',
              );
            },
          ),
          ListTile(
            title: TextWidget.headLineSmall(texto: 'PADRES'),
            onTap: () {
              Navigator.pushNamed(
                context,
                'lstPadres',
              );
            },
          ),
          ListTile(
            title: TextWidget.headLineSmall(texto: 'RECEPTORAS'),
            onTap: () {
              Navigator.pushNamed(
                context,
                'lstReceptoras',
              );
            },
          )
        ],
      ),
    );
  }
}
