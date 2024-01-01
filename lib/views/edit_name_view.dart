import 'package:flutter/material.dart';

import '../services/firebase_service.dart';

class EditNameView extends StatefulWidget {
  const EditNameView({super.key});

  @override
  State<EditNameView> createState() => _EditNameViewState();
}

class _EditNameViewState extends State<EditNameView> {
  TextEditingController editNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)!.settings.arguments as Map;
    editNameController.text = args['name'];
    return Scaffold(
        appBar: AppBar(title: const Text('Editar nombre')),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Text('Nombre:'),
              TextField(
                controller: editNameController,
                decoration: const InputDecoration(hintText: 'Nombre nuevo'),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await updatePeople(args['uid'], editNameController.text).then((_) {
                      Navigator.pop(context);
                    });
                  },
                  child: const Text('Actualizar'))
            ],
          ),
        ));
  }
}
