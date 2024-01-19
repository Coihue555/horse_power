import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horse_power/global/environment.dart';
import 'package:horse_power/services/select_image.dart';
import 'package:horse_power/services/upload_image.dart';
import 'package:horse_power/widgets/text/text_widget.dart';
import 'package:horse_power/widgets/textfield/textfield_widget.dart';
import 'package:image_picker/image_picker.dart';

import '../services/firebase_service.dart';

class EditNameView extends StatefulWidget {
  const EditNameView({super.key});

  @override
  State<EditNameView> createState() => _EditNameViewState();
}

class _EditNameViewState extends State<EditNameView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController nameMotherController = TextEditingController();
  TextEditingController nameFatherController = TextEditingController();
  TextEditingController nameReceiverController = TextEditingController();
  TextEditingController fechaNacController = TextEditingController();
  List<dynamic> lstImagenes = List<String>.filled(7, '');
  List<XFile?> lstFiles = List<XFile?>.filled(7, XFile(''));
  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)!.settings.arguments as Map;
    nameController.text = args['name'] ?? '';
    nameMotherController.text = args['madre'] ?? '';
    nameFatherController.text = args['padre'] ?? '';
    nameReceiverController.text = args['receptora'] ?? '';
    fechaNacController.text = args['fechaNac'] ?? '';
    lstImagenes = args['lstImagenes'] as List<dynamic>;
    return Scaffold(
        appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.blueAccent,
            title: Text(
              'Editar ${args['name']}',
              style: const TextStyle(color: Colors.white),
            )),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextfieldWidget.texto(
                  labelTitulo: 'Nombre del caballo:',
                  controller: nameController,
                ),
                TextfieldWidget.fecha(
                    controller: fechaNacController,
                    labelTitulo: 'Fecha de Nacimiento:',
                    onChanged: (p0) {
                      fechaNacController.text = p0;
                    },
                    onSubmitted: (value) {
                      fechaNacController.text = value;
                    }),
                TextfieldWidget.texto(
                  labelTitulo: 'Nombre de la madre:',
                  controller: nameMotherController,
                ),
                TextfieldWidget.texto(
                  labelTitulo: 'Nombre del padre:',
                  controller: nameFatherController,
                ),
                TextfieldWidget.texto(
                  labelTitulo: 'Madre receptora:',
                  controller: nameReceiverController,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 230,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: lstImagenes.length,
                      itemBuilder: (context, index) {
                        if (lstImagenes[index] != '') {
                          return SizedBox(
                              height: 100,
                              width: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  lstFiles[index] == XFile('')
                                      ? Image.file(File(lstFiles[index]!.path))
                                      : Image.network(
                                          lstImagenes[index],
                                          fit: BoxFit.contain,
                                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            } else {
                                              return Center(
                                                child: CircularProgressIndicator(
                                                  value: loadingProgress.expectedTotalBytes != null
                                                      ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                                      : null,
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                  TextWidget.textSmall(texto: lstNomImagenes[index]),
                                ],
                              ));
                        } else {
                          return Container(
                            width: 100,
                            height: 100,
                            padding: const EdgeInsets.all(5),
                            child: InkWell(
                              onTap: () async {
                                lstFiles[index] = await getImage();
                                setState(() {
                                  lstImagenes[index] = lstFiles[index]!.path;
                                });
                                if (lstImagenes[index] == null) {
                                  return;
                                }
                                final uploaded = await uploadImage(File(lstImagenes[index]));
                                setState(() {
                                  lstImagenes[index] = uploaded['url'];
                                  lstFiles[index] = uploaded['path'];
                                });
                                if (mounted) {
                                  if (uploaded.containsKey('Ok')) {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Imagen subida correctamente')));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error al subir la imagen')));
                                  }
                                }
                              },
                              child: Column(
                                children: [
                                  Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.grey,
                                      child: const Icon(
                                        Icons.add_a_photo_outlined,
                                        color: Colors.white,
                                      )),
                                  TextWidget.textSmall(texto: lstNomImagenes[index]),
                                ],
                              ),
                            ),
                          );
                        }
                      }),
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        await updateHorse(args['uid'], nameController.text, nameMotherController.text, nameFatherController.text, nameReceiverController.text,
                            fechaNacController.text, []).then((_) {
                          Navigator.pop(context);
                        });
                      },
                      child: const Text('Actualizar')),
                )
              ],
            ),
          ),
        ));
  }
}
