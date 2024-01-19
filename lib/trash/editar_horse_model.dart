import 'dart:io';

import 'package:flutter/material.dart';
import 'package:horse_power/services/select_image.dart';
import 'package:horse_power/services/upload_image.dart';
import 'package:horse_power/utils/utils.dart';
import 'package:horse_power/widgets/text/text_widget.dart';

class CargarImagen extends StatefulWidget {
  const CargarImagen({
    super.key,
    required this.tituloImagen,
    required this.onTap,
  });

  final String tituloImagen;
  final Function(String) onTap;

  @override
  State<CargarImagen> createState() => _CargarImagenState();
}

class _CargarImagenState extends State<CargarImagen> {
  File? imagenUpload;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      return AlertDialog(
        content: SizedBox(
            width: c.maxWidth,
            height: c.maxHeight * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextWidget.headLineSmall(texto: 'Cargar ${widget.tituloImagen}'),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
                const SizedBox(height: 10.0),
                imagenUpload != null
                    ? Image.file(imagenUpload!) //Image.memory(await pickedFile.readAsBytes())
                    : Center(
                        child: SizedBox(
                            width: Sizes(context).ancho * 0.8,
                            height: Sizes(context).alto * 0.5,
                            child: Column(
                              children: [
                                TextWidget.textLarge(texto: 'Aun no hay datos para mostrar'),
                                Image.asset(
                                  'assets/sin_datos.png',
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ))),
                const Spacer(),
                ElevatedButton(
                    onPressed: () async {
                      final imagen = await getImage();
                      setState(() {
                        imagenUpload = File(imagen!.path);
                      });
                    },
                    child: TextWidget.textMedium(texto: 'Seleccionar imagen')),
                ElevatedButton(
                    onPressed: () async {
                      if (imagenUpload == null) {
                        return;
                      }
                      final uploaded = await uploadImage(imagenUpload!);
                      if (mounted) {
                        Navigator.pop(context);
                        if (uploaded.containsKey('Ok')) {
                          widget.onTap.call(uploaded['path']);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Imagen subida correctamente')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error al subir la imagen')));
                        }
                      }
                    },
                    child: TextWidget.textMedium(texto: 'Subir imagen'))
              ],
            )),
      );
    });
  }
}
