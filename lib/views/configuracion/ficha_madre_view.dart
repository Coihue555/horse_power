import 'package:flutter/material.dart';
import 'package:horse_power/services/firebase_service.dart';
import 'package:horse_power/theme/theme.dart';
import 'package:horse_power/widgets/text/text_widget.dart';
import 'package:horse_power/widgets/textfield/textfield_widget.dart';
import 'package:flutter/services.dart';

class FichaMadreView extends StatefulWidget {
  const FichaMadreView({super.key});

  @override
  State<FichaMadreView> createState() => _FichaMadreViewState();
}

class _FichaMadreViewState extends State<FichaMadreView> {
  TextEditingController madreController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Map args = (ModalRoute.of(context)!.settings.arguments ?? {}) as Map;
    madreController.text = args.containsKey('uid') ? args['madre'] : '';
    return LayoutBuilder(builder: (context, c) {
      return Scaffold(
          appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: ThemeModel().colorPrimario,
              title: TextWidget.titleLarge(
                texto: args.containsKey('uid') ? 'Editar madre' : 'Nueva madre',
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
                          labelTitulo: 'Madre:',
                          controller: madreController,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (args.containsKey('uid')) {
                              updateMadre(args['uid'], madreController.text).then((_) {
                                Navigator.pop(context);
                              });
                            } else {
                              addMadre(
                                madreController.text,
                              ).then((_) {
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
