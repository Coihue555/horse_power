import 'package:flutter/material.dart';
import 'package:horse_power/services/firebase_service.dart';
import 'package:horse_power/theme/theme.dart';
import 'package:horse_power/utils/utils.dart';
import 'package:horse_power/widgets/text/text_widget.dart';

class CaballosView extends StatefulWidget {
  const CaballosView({super.key});

  @override
  State<CaballosView> createState() => _CaballosViewState();
}

class _CaballosViewState extends State<CaballosView> {
  late Future<List<dynamic>> lstMadres;
  late Future<List<dynamic>> lstPadres;
  late Future<List<dynamic>> lstReceptoras;

  @override
  void initState() {
    super.initState();
    lstMadres = getMadres();
    lstPadres = getPadres();
    lstReceptoras = getReceptoras();
  }

  Future<String>? getMadreDescription(String? madreUid) async {
    if (madreUid == null) return '';
    var madre = await lstMadres.then((madres) => madres.firstWhere((madre) => madre['uid'] == madreUid, orElse: () => {}));
    return madre['madre'];
  }

  Future<String>? getPadreDescription(String? padreUid) async {
    if (padreUid == null) return '';
    var padre = await lstPadres.then((padres) => padres.firstWhere((padre) => padre['uid'] == padreUid, orElse: () => {}));
    return padre['padre'];
  }

  Future<String>? getReceptoraDescription(String? receptoraUid) async {
    if (receptoraUid == null) return '';
    var receptora = await lstReceptoras.then((padres) => padres.firstWhere((receptora) => receptora['uid'] == receptoraUid, orElse: () => {}));
    return receptora['receptora'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getHorses(),
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
                                      content: Text('Esta seguro de eliminar ${snapshot.data?[index]['horses']}?'),
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
                              await deleteHorse(snapshot.data?[index]['uid']);
                              snapshot.data?.removeAt(index);
                            },
                            child: ListTile(
                              hoverColor: ThemeModel().colorPrimario,
                              selectedColor: ThemeModel().colorPrimario,
                              title: Text(snapshot.data?[index]['name']),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nacido: ${snapshot.data?[index]['fechaNac'] ?? ''}'),
                                  FutureBuilder(
                                      future: getMadreDescription(snapshot.data?[index]['madre']),
                                      builder: (context, snapshotMadre) {
                                        return Text('Madre: ${snapshotMadre.data}');
                                      }),
                                  FutureBuilder(
                                      future: getPadreDescription(snapshot.data?[index]['padre']),
                                      builder: (context, snapshotPadre) {
                                        return Text('Padre: ${snapshotPadre.data}');
                                      }),
                                  FutureBuilder(
                                      future: getReceptoraDescription(snapshot.data?[index]['receptora']),
                                      builder: (context, snapshotReceptora) {
                                        return Text('Receptora: ${snapshotReceptora.data}');
                                      }),
                                ],
                              ),
                              onTap: () async {
                                await Navigator.pushNamed(context, 'fichaCaballo', arguments: {
                                  "name": snapshot.data?[index]['name'],
                                  "uid": snapshot.data?[index]['uid'],
                                  "madre": snapshot.data?[index]['madre'],
                                  "padre": snapshot.data?[index]['padre'],
                                  "receptora": snapshot.data?[index]['receptora'],
                                  "fechaNac": snapshot.data?[index]['fechaNac'],
                                  "lstImagenes": snapshot.data?[index]['lstImagenes'],
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
        heroTag: 'tag2',
        onPressed: () async {
          await Navigator.pushNamed(context, 'fichaCaballo');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
