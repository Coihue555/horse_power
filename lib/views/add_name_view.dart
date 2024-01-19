import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horse_power/global/environment.dart';
import 'package:horse_power/services/firebase_service.dart';
import 'package:horse_power/services/select_image.dart';
import 'package:horse_power/services/upload_image.dart';
import 'package:horse_power/theme/theme.dart';
import 'package:horse_power/widgets/text/text_widget.dart';
import 'package:horse_power/widgets/textfield/textfield_widget.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/utils.dart';

class AddNameView extends StatefulWidget {
  const AddNameView({super.key});

  @override
  State<AddNameView> createState() => _AddNameViewState();
}

class _AddNameViewState extends State<AddNameView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController nameMotherController = TextEditingController();
  TextEditingController nameFatherController = TextEditingController();
  TextEditingController nameReceiverController = TextEditingController();
  TextEditingController fechaNacController = TextEditingController();
  List<String> lstImagenes = List<String>.filled(7, '');
  List<XFile?> lstFiles = List<XFile?>.filled(7, XFile(''));
  bool isCargando = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      return Scaffold(
          appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: ThemeModel().colorPrimario,
              title: TextWidget.titleLarge(
                texto: 'Nuevo Caballo',
                colorTextoDark: Colors.white,
                colorTextoLight: Colors.white,
              )),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: c.maxHeight,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
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
                          child: isCargando
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.builder(
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
                                              Image.network(
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
                                              isCargando = true;
                                            });
                                            lstImagenes[index] = lstFiles[index]!.path;
                                            final uploaded = await uploadImage(File(lstImagenes[index]));
                                            if (mounted) {
                                              if (uploaded.containsKey('Ok')) {
                                                lstImagenes[index] = uploaded['url'];
                                                lstFiles[index] = XFile(uploaded['path']);
                                                setState(() {
                                                  isCargando = false;
                                                });
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Imagen subida correctamente')));
                                              } else {
                                                setState(() {
                                                  isCargando = false;
                                                });
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error al subir la imagen')));
                                              }
                                            }
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                  height: c.maxHeight * 0.2,
                                                  width: Sizes(context).ancho,
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
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            addHorse(nameController.text, nameMotherController.text, nameFatherController.text, nameReceiverController.text,
                                    fechaNacController.text, lstImagenes)
                                .then((_) {
                              Navigator.pop(context);
                            });
                          },
                          child: const Text('Guardar')),
                    )
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
