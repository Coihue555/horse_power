import 'dart:io';

import 'package:flutter/material.dart';
import 'package:horse_power/services/firebase_service.dart';
import 'package:horse_power/services/select_image.dart';
import 'package:horse_power/services/upload_image.dart';

import '../utils/utils.dart';

class AddNameView extends StatefulWidget {
  const AddNameView({super.key});

  @override
  State<AddNameView> createState() => _AddNameViewState();
}

class _AddNameViewState extends State<AddNameView> {
  TextEditingController nameController = TextEditingController();
  File? imagenUpload;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Agregar nombre')),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Nombre:'),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Ingrese un nombre'),
              ),
              imagenUpload != null
                  ? SizedBox(
                      height: 200,
                      width: Sizes(context).ancho,
                      child: Image.file(
                        imagenUpload!,
                        fit: BoxFit.contain,
                      ))
                  : Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 200,
                      width: Sizes(context).ancho,
                      color: Colors.red,
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        final imagen = await getImage();
                        setState(() {
                          imagenUpload = File(imagen!.path);
                        });
                      },
                      child: const Text('Seleccionar imagen')),
                  ElevatedButton(
                      onPressed: () async {
                        if (imagenUpload == null) {
                          return;
                        }
                        final uploaded = await uploadImage(imagenUpload!);
                        if (mounted) {
                          if (uploaded) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Imagen subida correctamente')));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error al subir la imagen')));
                          }
                        }
                      },
                      child: const Text('Subir imagen')),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      addPeople(nameController.text).then((_) {
                        Navigator.pop(context);
                      });
                    },
                    child: const Text('Guardar')),
              )
            ],
          ),
        ));
  }
}
