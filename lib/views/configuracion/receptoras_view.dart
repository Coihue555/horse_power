import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horse_power/services/firebase_service.dart';
import 'package:horse_power/theme/theme.dart';
import 'package:horse_power/utils/utils.dart';
import 'package:horse_power/widgets/text/text_widget.dart';

class ReceptorasView extends StatefulWidget {
  const ReceptorasView({super.key});

  @override
  State<ReceptorasView> createState() => _ReceptorasViewState();
}

class _ReceptorasViewState extends State<ReceptorasView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: ThemeModel().colorPrimario,
        title: const Text(
          'Receptoras',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: getReceptoras(),
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
                                      content: Text('Esta seguro de eliminar ${snapshot.data?[index]['receptora']}?'),
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
                              await deleteReceptora(snapshot.data?[index]['uid']);
                              snapshot.data?.removeAt(index);
                            },
                            child: ListTile(
                              hoverColor: ThemeModel().colorPrimario,
                              selectedColor: ThemeModel().colorPrimario,
                              title: Text(snapshot.data?[index]['receptora'] ?? ''),
                              onTap: () async {
                                await Navigator.pushNamed(context, 'fichaReceptora', arguments: {
                                  "receptora": snapshot.data?[index]['receptora'],
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
        heroTag: 'tag5',
        onPressed: () async {
          await Navigator.pushNamed(context, 'fichaReceptora');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
