import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horse_power/global/environment.dart';
import 'package:horse_power/utils/utils.dart';
import 'package:horse_power/widgets/text/text_widget.dart';
import 'package:horse_power/widgets/textfield/textfield_widget.dart';
import 'package:image_picker/image_picker.dart';

import '../services/firebase_service.dart';

class EditHorseView extends StatefulWidget {
  const EditHorseView({super.key});

  @override
  State<EditHorseView> createState() => _EditHorseViewState();
}

class _EditHorseViewState extends State<EditHorseView> {
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
                                  lstImagenes[index] == ''
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
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Container();
                                    // return CargarImagen(
                                    //   tituloImagen: lstNomImagenes[index],
                                    //   onTap: (value) {
                                    //     lstFiles[index] = XFile(value);
                                    //     setState(() {});
                                    //   },
                                    // );
                                  },
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                      width: 50,
                                      height: Sizes(context).alto * 0.2,
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
