import 'package:flutter/material.dart';
import 'package:horse_power/services/firebase_service.dart';
import 'package:horse_power/theme/theme.dart';
import 'package:horse_power/widgets/dropdown_widget.dart';
import 'package:horse_power/widgets/image_loader.dart';
import 'package:horse_power/widgets/text/text_widget.dart';
import 'package:flutter/services.dart';
import 'package:horse_power/widgets/textfield/textfield_widget.dart';

class FichaCasoView extends StatefulWidget {
  const FichaCasoView({super.key});

  @override
  State<FichaCasoView> createState() => _FichaCasoViewState();
}

class _FichaCasoViewState extends State<FichaCasoView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController fechaCasoController = TextEditingController();
  TextEditingController observacionesController = TextEditingController();
  List<String> lstImagenes = List<String>.filled(7, '');
  String selectedHorse = '';
  late Future<List<dynamic>> lstHorses;
  late Map args = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      args = (ModalRoute.of(context)!.settings.arguments as Map);
      cargarDatos({...args});
    });
    lstHorses = getHorses();
  }

  void cargarDatos(Map<dynamic, dynamic> args) async {
    if (args.containsKey('uid')) {
      fechaCasoController.text = args.containsKey('uid') ? args['fechaCaso'] : '';
      observacionesController.text = args.containsKey('uid') ? args['observaciones'] : '';
      selectedHorse = args['caballo'];
      var tempList = <String>[];
      for (var element in args['lstImagenes']) {
        tempList.add(element);
      }
      lstImagenes = tempList;
      nameController.text = selectedHorse;
    }
    if (args.containsKey('desdeFicha')) {
      if (args['desdeFicha'] == 'S') {
        selectedHorse = args['caballo'];
        nameController.text = selectedHorse;
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    //nameController.dispose();
    observacionesController.dispose();
    fechaCasoController.dispose();
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
              texto: args.containsKey('uid') ? 'Editar Caso' : 'Nuevo Caso',
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
                      FutureBuilder(
                          future: getItemDescription('name', selectedHorse, lstHorses),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text("Errorrrr: ${snapshot.error}");
                            } else {
                              return DynamicDropDown(
                                label: 'horse',
                                lstItems: getHorses(),
                                valorSeleccionado: snapshot.data,
                                onChanged: (p0) {
                                  selectedHorse = p0;
                                  nameController.text = selectedHorse;
                                },
                              );
                            }
                          }),
                      TextfieldWidget.fecha(
                          controller: fechaCasoController,
                          labelTitulo: 'Fecha de Atención:',
                          onChanged: (p0) {
                            fechaCasoController.text = p0;
                          },
                          onSubmitted: (value) {
                            fechaCasoController.text = value;
                          }),
                      TextfieldWidget.multilinea(
                        maxLines: 10,
                        labelTitulo: 'Observaciones:',
                        controller: observacionesController,
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
                          if (nameController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Debe seleccionar un Caballo')));
                          } else if (observacionesController.text.length < 10) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('La observacion debe tener mas de 10 carácteres')));
                          } else {
                            if (args.containsKey('uid')) {
                              await updateCaso(args['uid'], nameController.text, fechaCasoController.text, observacionesController.text, lstImagenes).then((_) {
                                Navigator.pushNamed(
                                  context,
                                  'lstCasos',
                                );
                              });
                            } else {
                              addCaso(nameController.text, fechaCasoController.text, observacionesController.text, lstImagenes).then((_) {
                                Navigator.pushNamed(
                                  context,
                                  'lstCasos',
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
