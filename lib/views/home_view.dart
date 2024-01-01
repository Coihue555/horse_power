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
        title: const Text('Horse Power'),
      ),
      body: FutureBuilder(
        future: getPeople(),
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
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      onDismissed: (direction) async {
                        await deletePeople(snapshot.data?[index]['uid']);
                        snapshot.data?.removeAt(index);
                      },
                      child: ListTile(
                        title: Text(snapshot.data?[index]['name']),
                        onTap: () async {
                          await Navigator.pushNamed(context, 'editName',
                              arguments: {"name": snapshot.data?[index]['name'], "uid": snapshot.data?[index]['uid']});
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
