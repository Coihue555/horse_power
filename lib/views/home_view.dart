import 'package:flutter/material.dart';

import '../services/firebase_service.dart';

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
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Horse Power',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: getHorses(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(snapshot.data?[index]['uid']),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) async {
                        bool result = await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Confirmar'),
                                content: Text('Esta seguro de eliminar a ${snapshot.data?[index]['name']}?'),
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
                        alignment: Alignment.center,
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
                        hoverColor: Colors.blueAccent,
                        selectedColor: Colors.blueAccent,
                        title: Text(snapshot.data?[index]['name']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nacido: ${snapshot.data?[index]['fechaNac'] ?? ''}'),
                            Text('Madre: ${snapshot.data?[index]['madre'] ?? ''}'),
                            Text('Padre: ${snapshot.data?[index]['padre'] ?? ''}'),
                            Text('Receptora: ${snapshot.data?[index]['receptora'] ?? ''}'),
                          ],
                        ),
                        onTap: () async {
                          await Navigator.pushNamed(context, 'editName', arguments: {
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
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, 'addName');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
