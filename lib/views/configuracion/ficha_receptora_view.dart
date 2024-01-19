import 'package:flutter/material.dart';
import 'package:horse_power/services/firebase_service.dart';
import 'package:horse_power/theme/theme.dart';
import 'package:horse_power/widgets/text/text_widget.dart';
import 'package:horse_power/widgets/textfield/textfield_widget.dart';
import 'package:flutter/services.dart';

class FichaReceptoraView extends StatefulWidget {
  const FichaReceptoraView({super.key});

  @override
  State<FichaReceptoraView> createState() => _FichaReceptoraViewState();
}

class _FichaReceptoraViewState extends State<FichaReceptoraView> {
  TextEditingController receptoraController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Map args = (ModalRoute.of(context)!.settings.arguments ?? {}) as Map;
    receptoraController.text = args.containsKey('uid') ? args['receptora'] : '';
    return LayoutBuilder(builder: (context, c) {
      return Scaffold(
          appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: ThemeModel().colorPrimario,
              title: TextWidget.titleLarge(
                texto: args.containsKey('uid') ? 'Editar receptora' : 'Nueva receptora',
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
                          labelTitulo: 'Receptora:',
                          controller: receptoraController,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (args.containsKey('uid')) {
                              updateReceptora(args['uid'], receptoraController.text).then((_) {
                                Navigator.pop(context);
                              });
                            } else {
                              addReceptora(
                                receptoraController.text,
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
