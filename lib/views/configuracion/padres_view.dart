import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horse_power/services/firebase_service.dart';
import 'package:horse_power/theme/theme.dart';
import 'package:horse_power/utils/utils.dart';
import 'package:horse_power/widgets/text/text_widget.dart';

class PadresView extends StatefulWidget {
  const PadresView({super.key});

  @override
  State<PadresView> createState() => _PadresViewState();
}

class _PadresViewState extends State<PadresView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: ThemeModel().colorPrimario,
        title: const Text(
          'Padres',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: getPadres(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return snapshot.data!.isEmpty
                        ? Center(
                            child: SizedBox(
                                width: Sizes(context).ancho * 0.8,
                                height: Sizes(context).alto * 0.5,
                                child: Column(
                                  children: [
                                    TextWidget.textLarge(texto: 'Aun no hay datos para mostrar'),
                                    Image.asset(
                                      'assets/sin_datos.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ],
                                )))
                        : Dismissible(
                            key: Key(snapshot.data?[index]['uid']),
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (direction) async {
                              bool result = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Confirmar'),
                                      content: Text('Esta seguro de eliminar ${snapshot.data?[index]['padre']}?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              return Navigator.pop(context, false);
                                            },
                                            child: const Text('Cancelar')),
                                        TextButton(
                                            onPressed: () {
                                              return Navigator.pop(context, true);
                                            },
                                            child: const Text('Confirmar')),
                                      ],
                                    );
                                  });
                              return result;
                            },
                            background: Container(
                              margin: const EdgeInsets.only(right: 20),
                              alignment: Alignment.centerRight,
                              color: Colors.red,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            onDismissed: (direction) async {
                              await deletePadre(snapshot.data?[index]['uid']);
                              snapshot.data?.removeAt(index);
                            },
                            child: ListTile(
                              hoverColor: ThemeModel().colorPrimario,
                              selectedColor: ThemeModel().colorPrimario,
                              title: Text(snapshot.data?[index]['padre'] ?? ''),
                              onTap: () async {
                                await Navigator.pushNamed(context, 'fichaPadre', arguments: {
                                  "padre": snapshot.data?[index]['padre'],
                                  "uid": snapshot.data?[index]['uid'],
                                });
                                setState(() {});
                              },
                            ),
                          );
                  }),
            );
          } else {
            return Center(
                child: SizedBox(
                    width: Sizes(context).ancho * 0.8,
                    height: Sizes(context).alto * 0.5,
                    child: Column(
                      children: [
                        TextWidget.textLarge(texto: 'Aun no hay datos para mostrar'),
                        Image.asset(
                          'assets/sin_datos.png',
                          fit: BoxFit.contain,
                        ),
                      ],
                    )));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'tag4',
        onPressed: () async {
          await Navigator.pushNamed(context, 'fichaPadre');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
