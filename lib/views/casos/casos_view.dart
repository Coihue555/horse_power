import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horse_power/services/firebase_service.dart';
import 'package:horse_power/theme/theme.dart';
import 'package:horse_power/widgets/text/text_widget.dart';

class CasosView extends StatefulWidget {
  const CasosView({super.key});

  @override
  State<CasosView> createState() => _CasosViewState();
}

class _CasosViewState extends State<CasosView> {
  late Future<List<dynamic>> lstHorses;
  late Future<List<dynamic>> lstCasos;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    lstCasos = getCasos();
    lstHorses = getHorses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Casos Clínicos',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: lstCasos,
        builder: (context, snapshotCasos) {
          if (snapshotCasos.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshotCasos.hasError) {
            return Text("Errorrrr: ${snapshotCasos.error}");
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    //autofocus: true,
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        lstCasos = findMatchingCases(value);
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
                      itemCount: snapshotCasos.data?.length,
                      itemBuilder: (context, index) {
                        var item = snapshotCasos.data?[index];
                        return Dismissible(
                          key: Key(item['uid']),
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (direction) async {
                            bool result = await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Confirmar'),
                                    content: Text('Esta seguro de eliminar el caso de ${item['caballo']}?'),
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
                            await deleteCaso(item['uid']);
                            snapshotCasos.data?.removeAt(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                            child: InkWell(
                                onTap: () async {
                                  await Navigator.pushNamed(context, 'fichaCaso', arguments: {
                                    "uid": item['uid'],
                                    "caballo": item['caballo'],
                                    "fechaCaso": item['fechaCaso'],
                                    "observaciones": item['observaciones'],
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
                                      title: FutureBuilder(
                                          future: getItemName('name', item['caballo'], lstHorses),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return const CircularProgressIndicator();
                                            } else if (snapshot.hasError) {
                                              return Text("Errorrrr: ${snapshot.error}");
                                            } else {
                                              return Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      TextWidget.headLineSmall(texto: snapshot.data ?? ''),
                                                      TextWidget.headLineSmall(texto: item['fechaCaso'] ?? ''),
                                                    ],
                                                  ),
                                                  const Divider(
                                                    thickness: 0.5,
                                                    height: 2,
                                                  )
                                                ],
                                              );
                                            }
                                          }),
                                      subtitle: TextWidget.titleMedium(maxlineas: 2, overflow: TextOverflow.fade, texto: item['observaciones']),
                                    ),
                                  ),
                                )),
                          ),
                        );
                      }),
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'tag2b',
        onPressed: () async {
          await Navigator.pushNamed(context, 'fichaCaso');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
