import 'package:flutter/material.dart';
import 'package:horse_power/services/firebase_service.dart';
import 'package:horse_power/theme/theme.dart';
import 'package:horse_power/widgets/text/text_widget.dart';
import 'package:horse_power/widgets/textfield/textfield_widget.dart';
import 'package:flutter/services.dart';

class FichaPadreView extends StatefulWidget {
  const FichaPadreView({super.key});

  @override
  State<FichaPadreView> createState() => _FichaPadreViewState();
}

class _FichaPadreViewState extends State<FichaPadreView> {
  TextEditingController padreController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Map args = (ModalRoute.of(context)!.settings.arguments ?? {}) as Map;
    padreController.text = args.containsKey('uid') ? args['padre'] : '';
    return LayoutBuilder(builder: (context, c) {
      return Scaffold(
          appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: ThemeModel().colorPrimario,
              title: TextWidget.titleLarge(
                texto: args.containsKey('uid') ? 'Editar padre' : 'Nueva padre',
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
                          labelTitulo: 'Padre:',
                          controller: padreController,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (args.containsKey('uid')) {
                              updatePadre(args['uid'], padreController.text).then((_) {
                                Navigator.pop(context);
                              });
                            } else {
                              addPadre(
                                padreController.text,
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
