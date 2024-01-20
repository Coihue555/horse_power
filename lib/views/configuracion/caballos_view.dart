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
  late Future<List<dynamic>> lstHorses;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    lstMadres = getMadres();
    lstPadres = getPadres();
    lstReceptoras = getReceptoras();
    lstHorses = getHorses();
  }

  Future<List<dynamic>> filterHorsesByName(String name) async {
    List<dynamic> allHorses = await getHorses();
    if (name.isEmpty) {
      return allHorses;
    }

    // Filter the list by name
    return allHorses.where((horse) => horse['name'].toLowerCase().contains(name.toLowerCase())).toList();
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  // Filter the list based on the search input
                  lstHorses = filterHorsesByName(value);
                });
              },
              decoration: InputDecoration(
                labelText: 'Buscar por nombre',
                labelStyle: TextStyle(color: ThemeModel().colorPrimario),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: lstHorses,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return snapshot.data!.isEmpty
                            ? Center(
                                child: SizedBox(
                                    width: Sizes(context).ancho,
                                    height: Sizes(context).alto * 0.5,
                                    child: Column(
                                      children: [
                                        TextWidget.textLarge(texto: 'No hay datos para mostrar'),
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
                                  alignment: Alignment.centerRight,
                                  color: Colors.red,
                                  child: const Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onDismissed: (direction) async {
                                  await deleteHorse(snapshot.data?[index]['uid']);
                                  snapshot.data?.removeAt(index);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                  child: InkWell(
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
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: ThemeModel().colorPrimario), borderRadius: const BorderRadius.all(Radius.circular(10))),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              padding: const EdgeInsets.only(left: 10),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: ThemeModel().colorPrimario,
                                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                                              child: TextWidget.titleLarge(
                                                  colorTextoDark: Colors.white, colorTextoLight: Colors.white, texto: snapshot.data?[index]['name'])),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Flexible(
                                                    flex: 1,
                                                    child: Image.asset(
                                                      'assets/horse_front.png',
                                                      fit: BoxFit.contain,
                                                    )),
                                                Flexible(
                                                  flex: 4,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 5),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
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
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                      });
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
          ),
        ],
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
