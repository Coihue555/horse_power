import 'package:flutter/material.dart';
import 'package:horse_power/services/firebase_service.dart';
import 'package:horse_power/theme/theme.dart';
import 'package:horse_power/widgets/dropdown_widget.dart';
import 'package:horse_power/widgets/image_loader.dart';
import 'package:horse_power/widgets/text/text_widget.dart';
import 'package:horse_power/widgets/textfield/textfield_widget.dart';
import 'package:flutter/services.dart';

class FichaCaballoView extends StatefulWidget {
  const FichaCaballoView({super.key});

  @override
  State<FichaCaballoView> createState() => _FichaCaballoViewState();
}

class _FichaCaballoViewState extends State<FichaCaballoView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController nroChipController = TextEditingController();
  TextEditingController nameMotherController = TextEditingController();
  TextEditingController nameFatherController = TextEditingController();
  TextEditingController nroReceiverController = TextEditingController();
  TextEditingController fechaNacController = TextEditingController();
  TextEditingController centroEmbController = TextEditingController();
  List<String> lstImagenes = List<String>.filled(7, '');
  late Future<List<dynamic>> lstMadres;
  late Future<List<dynamic>> lstPadres;
  late Future<List<dynamic>> lstReceptoras;
  late Future<List<dynamic>> lstCasos;
  late Map args = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      args = (ModalRoute.of(context)!.settings.arguments as Map);
      cargarDatos({...args});
    });
    lstMadres = getMadres();
    lstPadres = getPadres();
    lstReceptoras = getReceptoras();
    lstCasos = getCasos();
  }

  void cargarDatos(Map<dynamic, dynamic> args) async {
    nameController.text = args.containsKey('uid') ? args['name'] : '';
    nroChipController.text = args.containsKey('uid') ? args['nroChip'] : '';
    nameMotherController.text = args.containsKey('uid') ? args['madre'] : '';
    nameFatherController.text = args.containsKey('uid') ? args['padre'] : '';
    nroReceiverController.text = args.containsKey('uid') ? args['receptora'] : '';
    fechaNacController.text = args.containsKey('uid') ? args['fechaNac'] : '';
    centroEmbController.text = args.containsKey('uid') ? args['centroEmb'] : '';
    if (args.containsKey('uid')) {
      var tempList = <String>[];
      for (var element in args['lstImagenes']) {
        tempList.add(element);
      }
      lstImagenes = tempList;
    }
    setState(() {});
  }

  @override
  void dispose() {
    nameController.dispose();
    nroChipController.dispose();
    nameMotherController.dispose();
    nameFatherController.dispose();
    nroReceiverController.dispose();
    fechaNacController.dispose();
    centroEmbController.dispose();
    lstImagenes.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: ThemeModel().colorPrimario,
            title: TextWidget.titleLarge(
              texto: args.containsKey('uid') ? 'Editar Caballo' : 'Nuevo Caballo',
              colorTextoDark: Colors.white,
              colorTextoLight: Colors.white,
            )),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextfieldWidget.texto(
                        labelTitulo: 'Nombre:',
                        controller: nameController,
                      ),
                      TextfieldWidget.numero(
                        labelTitulo: 'Nº de Chip:',
                        controller: nroChipController,
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
                      FutureBuilder(
                          future: getItemDescription('madre', nameMotherController.text, lstMadres),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text("Errorrrr: ${snapshot.error}");
                            } else {
                              return DynamicDropDown(
                                label: 'madre',
                                lstItems: getMadres(),
                                valorSeleccionado: snapshot.data,
                                onChanged: (p0) {
                                  nameMotherController.text = p0;
                                },
                              );
                            }
                          }),
                      FutureBuilder(
                          future: getItemDescription('padre', nameFatherController.text, lstPadres),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text("Errorrrr: ${snapshot.error}");
                            } else {
                              return DynamicDropDown(
                                label: 'padre',
                                lstItems: lstPadres,
                                valorSeleccionado: snapshot.data,
                                onChanged: (p0) {
                                  nameFatherController.text = p0;
                                },
                              );
                            }
                          }),
                      FutureBuilder(
                          future: getItemDescription('receptora', nroReceiverController.text, lstReceptoras),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text("Errorrrr: ${snapshot.error}");
                            } else {
                              return DynamicDropDown(
                                label: 'receptora',
                                lstItems: lstReceptoras,
                                valorSeleccionado: snapshot.data,
                                onChanged: (p0) {
                                  nroReceiverController.text = p0;
                                },
                              );
                            }
                          }),
                      TextfieldWidget.texto(
                        labelTitulo: 'Centro de embriones:',
                        controller: centroEmbController,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget.textLarge(
                            texto: 'Subir imagenes:',
                            colorTextoDark: ThemeModel().colorPrimario,
                            colorTextoLight: ThemeModel().colorPrimario,
                          ),
                          const SizedBox(height: 10),
                          ImageUploadWidget(
                              imagesOnline: lstImagenes,
                              onImagesSelected: (images) {
                                setState(() {
                                  lstImagenes = images;
                                });
                              }),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (nameController.text.isEmpty || nroChipController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nombre y Nº Chip no pueden estar vacios')));
                          } else {
                            if (args.containsKey('uid')) {
                              await updateHorse(
                                args['uid'],
                                nameController.text,
                                nroChipController.text,
                                nameMotherController.text,
                                nameFatherController.text,
                                nroReceiverController.text,
                                fechaNacController.text,
                                centroEmbController.text,
                                lstImagenes,
                              ).then((_) {
                                Navigator.pushNamed(
                                  context,
                                  '/',
                                );
                              });
                            } else {
                              addHorse(
                                nameController.text,
                                nroChipController.text,
                                nameMotherController.text,
                                nameFatherController.text,
                                nroReceiverController.text,
                                fechaNacController.text,
                                centroEmbController.text,
                                lstImagenes,
                              ).then((_) {
                                Navigator.pushNamed(
                                  context,
                                  '/',
                                );
                              });
                            }
                          }
                        },
                        child: const Text('Guardar')),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
