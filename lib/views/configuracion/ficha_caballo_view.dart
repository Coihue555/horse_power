import 'package:flutter/material.dart';
import 'package:horse_power/services/firebase_service.dart';
import 'package:horse_power/theme/theme.dart';
import 'package:horse_power/widgets/dropdown_widget.dart';
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

  Future<String>? getMadreDescription(String? madreUid) async {
    if (madreUid == null) return '';
    var madre = await lstMadres.then((madres) => madres.firstWhere((madre) => madre['uid'] == madreUid, orElse: () => {}));
    return madre['madre'];
  }

  Future<String>? getPadreDescription(String? padreUid) async {
    if (padreUid == null) return '';
    var padre = await lstPadres.then((padres) => padres.firstWhere((padre) => padre['uid'] == padreUid, orElse: () => {}));
    return padre['padre'];
  }

  Future<String>? getReceptoraDescription(String? receptoraUid) async {
    if (receptoraUid == null) return '';
    var receptora = await lstReceptoras.then((padres) => padres.firstWhere((receptora) => receptora['uid'] == receptoraUid, orElse: () => {}));
    return receptora['receptora'];
  }

  @override
  Widget build(BuildContext context) {
    final Map args = (ModalRoute.of(context)!.settings.arguments ?? {}) as Map;
    nameController.text = args.containsKey('uid') ? args['name'] : '';
    nroChipController.text = args.containsKey('uid') ? args['nroChip'] : '';
    nameMotherController.text = args.containsKey('uid') ? args['madre'] : '';
    nameFatherController.text = args.containsKey('uid') ? args['padre'] : '';
    nroReceiverController.text = args.containsKey('uid') ? args['receptora'] : '';
    fechaNacController.text = args.containsKey('uid') ? args['fechaNac'] : '';
    centroEmbController.text = args.containsKey('uid') ? args['centroEmb'] : '';
    return LayoutBuilder(builder: (context, c) {
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
                            future: getMadreDescription(nameMotherController.text),
                            builder: (context, snapshot) {
                              return DynamicDropDown(
                                label: 'madre',
                                lstItems: lstMadres,
                                valorSeleccionado: snapshot.data,
                                onChanged: (p0) {
                                  nameMotherController.text = p0;
                                },
                              );
                            }),
                        FutureBuilder(
                            future: getPadreDescription(nameFatherController.text),
                            builder: (context, snapshot) {
                              return DynamicDropDown(
                                label: 'padre',
                                lstItems: lstPadres,
                                valorSeleccionado: snapshot.data,
                                onChanged: (p0) {
                                  nameFatherController.text = p0;
                                },
                              );
                            }),
                        FutureBuilder(
                            future: getReceptoraDescription(nroReceiverController.text),
                            builder: (context, snapshot) {
                              return DynamicDropDown(
                                label: 'receptora',
                                lstItems: lstReceptoras,
                                valorSeleccionado: snapshot.data,
                                onChanged: (p0) {
                                  nroReceiverController.text = p0;
                                },
                              );
                            }),
                        TextfieldWidget.texto(
                          labelTitulo: 'Centro de embriones:',
                          controller: centroEmbController,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (args.containsKey('uid')) {
                              await updateHorse(args['uid'], nameController.text, nroChipController.text, nameMotherController.text, nameFatherController.text,
                                  nroReceiverController.text, fechaNacController.text, centroEmbController.text, []).then((_) {
                                Navigator.pushNamed(
                                  context,
                                  '/',
                                );
                              });
                            } else {
                              addHorse(nameController.text, nroChipController.text, nameMotherController.text, nameFatherController.text,
                                  nroReceiverController.text, fechaNacController.text, centroEmbController.text, []).then((_) {
                                Navigator.pushNamed(
                                  context,
                                  '/',
                                );
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
