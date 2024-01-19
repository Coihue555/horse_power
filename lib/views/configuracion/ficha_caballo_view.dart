import 'package:flutter/material.dart';
import 'package:horse_power/services/firebase_service.dart';
// import 'dart:io';
// import 'package:horse_power/global/environment.dart';
// import 'package:horse_power/services/select_image.dart';
// import 'package:horse_power/services/upload_image.dart';
import 'package:horse_power/theme/theme.dart';
import 'package:horse_power/widgets/dropdown_widget.dart';
import 'package:horse_power/widgets/text/text_widget.dart';
import 'package:horse_power/widgets/textfield/textfield_widget.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class FichaCaballoView extends StatefulWidget {
  const FichaCaballoView({super.key});

  @override
  State<FichaCaballoView> createState() => _FichaCaballoViewState();
}

class _FichaCaballoViewState extends State<FichaCaballoView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController nameMotherController = TextEditingController();
  TextEditingController nameFatherController = TextEditingController();
  TextEditingController nameReceiverController = TextEditingController();
  TextEditingController fechaNacController = TextEditingController();
  List<String> lstImagenes = List<String>.filled(7, '');
  List<XFile?> lstFiles = List<XFile?>.filled(7, XFile(''));
  late Future<List<dynamic>> lstMadres;
  late Future<List<dynamic>> lstPadres;
  late Future<List<dynamic>> lstReceptoras;

  @override
  void initState() {
    super.initState();
    lstMadres = getMadres();
    lstPadres = getPadres();
    lstReceptoras = getReceptoras();
  }

  @override
  Widget build(BuildContext context) {
    final Map args = (ModalRoute.of(context)!.settings.arguments ?? {}) as Map;
    nameController.text = args.containsKey('uid') ? args['name'] : '';
    nameMotherController.text = args.containsKey('uid') ? args['madre'] : '';
    nameFatherController.text = args.containsKey('uid') ? args['padre'] : '';
    nameReceiverController.text = args.containsKey('uid') ? args['receptora'] : '';
    fechaNacController.text = args.containsKey('uid') ? args['fechaNac'] : '';
    //lstImagenes = args.containsKey('uid') ? args['lstImagenes'] as List<String> : <String>[];
    return LayoutBuilder(builder: (context, c) {
      return Scaffold(
          appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: ThemeModel().colorPrimario,
              title: TextWidget.titleLarge(
                texto: args.containsKey('uid') ? 'Editar caballo' : 'Nueva caballo',
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
                        DynamicDropDown(
                          label: 'madre',
                          lstItems: lstMadres,
                          onChanged: (p0) {
                            nameMotherController.text = p0;
                          },
                        ),
                        DynamicDropDown(
                          label: 'padre',
                          lstItems: lstPadres,
                          onChanged: (p0) {
                            nameFatherController.text = p0;
                          },
                        ),
                        DynamicDropDown(
                          label: 'receptora',
                          lstItems: lstReceptoras,
                          onChanged: (p0) {
                            nameReceiverController.text = p0;
                          },
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width,
                        //   height: 230,
                        //   child: ListView.builder(
                        //       scrollDirection: Axis.horizontal,
                        //       itemCount: lstImagenes.length,
                        //       itemBuilder: (context, index) {
                        //         if (lstImagenes[index] != '') {
                        //           return SizedBox(
                        //               height: 100,
                        //               width: 200,
                        //               child: Column(
                        //                 mainAxisAlignment: MainAxisAlignment.center,
                        //                 children: [
                        //                   lstFiles[index] == XFile('')
                        //                       ? Image.file(File(lstFiles[index]!.path))
                        //                       : Image.network(
                        //                           lstImagenes[index],
                        //                           fit: BoxFit.contain,
                        //                           loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        //                             if (loadingProgress == null) {
                        //                               return child;
                        //                             } else {
                        //                               return Center(
                        //                                 child: CircularProgressIndicator(
                        //                                   value: loadingProgress.expectedTotalBytes != null
                        //                                       ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                        //                                       : null,
                        //                                 ),
                        //                               );
                        //                             }
                        //                           },
                        //                         ),
                        //                   TextWidget.textSmall(texto: lstNomImagenes[index]),
                        //                 ],
                        //               ));
                        //         } else {
                        //           return Container(
                        //             width: 100,
                        //             height: 100,
                        //             padding: const EdgeInsets.all(5),
                        //             child: InkWell(
                        //               onTap: () async {
                        //                 lstFiles[index] = await getImage();
                        //                 setState(() {
                        //                   lstImagenes[index] = lstFiles[index]!.path;
                        //                 });
                        //                 if (lstImagenes[index] == null) {
                        //                   return;
                        //                 }
                        //                 final uploaded = await uploadImage(File(lstImagenes[index]));
                        //                 setState(() {
                        //                   lstImagenes[index] = uploaded['url'];
                        //                   lstFiles[index] = uploaded['path'];
                        //                 });
                        //                 if (mounted) {
                        //                   if (uploaded.containsKey('Ok')) {
                        //                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Imagen subida correctamente')));
                        //                   } else {
                        //                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error al subir la imagen')));
                        //                   }
                        //                 }
                        //               },
                        //               child: Column(
                        //                 children: [
                        //                   Container(
                        //                       height: 50,
                        //                       width: 50,
                        //                       color: Colors.grey,
                        //                       child: const Icon(
                        //                         Icons.add_a_photo_outlined,
                        //                         color: Colors.white,
                        //                       )),
                        //                   TextWidget.textSmall(texto: lstNomImagenes[index]),
                        //                 ],
                        //               ),
                        //             ),
                        //           );
                        //         }
                        //       }),
                        // ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (args.containsKey('uid')) {
                              await updateHorse(args['uid'], nameController.text, nameMotherController.text, nameFatherController.text,
                                      nameReceiverController.text, fechaNacController.text, lstImagenes)
                                  .then((_) {
                                Navigator.pop(context);
                              });
                            } else {
                              addHorse(nameController.text, nameMotherController.text, nameFatherController.text, nameReceiverController.text,
                                      fechaNacController.text, lstImagenes)
                                  .then((_) {
                                Navigator.pop(context);
                              });
                            }
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
