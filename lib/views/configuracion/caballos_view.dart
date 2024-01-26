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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: lstHorses,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        lstHorses = filterHorsesByName(value);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Buscar por Nombre o Nro Chip',
                      labelStyle: TextStyle(color: ThemeModel().colorPrimario),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        var item = snapshot.data?[index];
                        return Dismissible(
                          key: Key(item['uid']),
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (direction) async {
                            bool result = await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Confirmar'),
                                    content: Text('Esta seguro de eliminar ${item['name']}?'),
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
                            await deleteHorse(item['uid']);
                            snapshot.data?.removeAt(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                            child: InkWell(
                                onTap: () async {
                                  await Navigator.pushNamed(context, 'fichaCaballo', arguments: {
                                    "name": item['name'],
                                    "nroChip": item['nroChip'],
                                    "uid": item['uid'],
                                    "madre": item['madre'],
                                    "padre": item['padre'],
                                    "receptora": item['receptora'],
                                    "fechaNac": item['fechaNac'],
                                    "centroEmb": item['centroEmb'],
                                    "lstImagenes": item['lstImagenes'],
                                  });
                                  setState(() {});
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Card(
                                    elevation: 0,
                                    child: ListTile(
                                      tileColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      leading: item['lstImagenes'][0] == ''
                                          ? Image.asset(
                                              'assets/no-image.jpg',
                                              fit: BoxFit.contain,
                                            )
                                          : Image.network(
                                              item['lstImagenes'][0],
                                              fit: BoxFit.contain,
                                            ),
                                      title: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextWidget.titleLarge(texto: item['name']),
                                          TextWidget.titleLarge(texto: item['nroChip'] ?? ''),
                                        ],
                                      ),
                                      subtitle: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          if (item['fechaNac'] != null && item['fechaNac'] != '') Text('Nacido: ${item['fechaNac'] ?? ''}'),
                                          FutureBuilder(
                                              future: getItemDescription('madre', item['madre'], lstMadres),
                                              builder: (context, snapshotMadre) {
                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                  return const CircularProgressIndicator();
                                                } else if (snapshot.hasError) {
                                                  return Text("Errorrrr: ${snapshot.error}");
                                                } else {
                                                  return Text('Madre: ${snapshotMadre.data ?? ''}');
                                                }
                                              }),
                                          FutureBuilder(
                                              future: getItemDescription('padre', item['padre'], lstPadres),
                                              builder: (context, snapshotPadre) {
                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                  return const CircularProgressIndicator();
                                                } else if (snapshot.hasError) {
                                                  return Text("Errorrrr: ${snapshot.error}");
                                                } else {
                                                  return Text('Padre: ${snapshotPadre.data ?? ''}');
                                                }
                                              }),
                                          FutureBuilder(
                                              future: getItemDescription('receptora', item['receptora'], lstReceptoras),
                                              builder: (context, snapshotReceptora) {
                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                  return const CircularProgressIndicator();
                                                } else if (snapshot.hasError) {
                                                  return Text("Errorrrr: ${snapshot.error}");
                                                } else {
                                                  return Text('Nº Receptora: ${snapshotReceptora.data ?? ''}');
                                                }
                                              }),
                                          if (item['centroEmb'] != null && item['centroEmb'] != '') Text('Centro Embriones: ${item['centroEmb'] ?? ''}'),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        );
                      }),
                ),
              ],
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
