import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:horse_power/global/environment.dart';
import 'package:horse_power/services/upload_image.dart';
import 'package:horse_power/widgets/text/text_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageUploadWidget extends StatefulWidget {
  const ImageUploadWidget({Key? key, required this.onImagesSelected, required this.imagesOnline, this.prefixDownload}) : super(key: key);
  final Function(List<String>) onImagesSelected;
  final List<String> imagesOnline;
  final String? prefixDownload;

  @override
  ImageUploadWidgetState createState() => ImageUploadWidgetState();
}

class ImageUploadWidgetState extends State<ImageUploadWidget> {
  List<XFile?> selectedImages = List.generate(7, (index) => null);

  Future<void> pickImage(int index, ImageSource opcion) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: opcion);

    selectedImages[index] = pickedFile;

    final uploaded = await uploadImage(File(selectedImages[index]!.path));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Subiendo imagen seleccionada')));
    }
    if (mounted) {
      if (uploaded.containsKey('Ok')) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Imagen subida correctamente')));
      }
    }

    widget.imagesOnline[index] = uploaded['url'];
    widget.onImagesSelected(widget.imagesOnline.map((image) => image).toList());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: selectedImages.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      if (widget.imagesOnline[index] == '') {
                        return AlertDialog(
                          scrollable: true,
                          title: TextWidget.headLineSmall(texto: 'Elija una opcion:'),
                          content: Column(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    pickImage(index, ImageSource.gallery);
                                    Navigator.pop(context);
                                  },
                                  child: TextWidget.textMedium(texto: 'Subir archivo')),
                              ElevatedButton(
                                  onPressed: () {
                                    pickImage(index, ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                  child: TextWidget.textMedium(texto: 'Tomar foto')),
                            ],
                          ),
                        );
                      } else {
                        return PrevizFullImage(
                          urlImagen: widget.imagesOnline[index],
                          prefixDownload: widget.prefixDownload,
                        );
                      }
                    },
                  );
                },
                child: Column(
                  children: [
                    TextWidget.textMedium(texto: lstNomImagenes[index]),
                    Container(
                      width: 100,
                      height: 100,
                      decoration:
                          BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey), borderRadius: const BorderRadius.all(Radius.circular(5))),
                      child: widget.imagesOnline[index] == ''
                          ? const Icon(Icons.add)
                          : Image.network(
                              height: 100,
                              widget.imagesOnline[index],
                              fit: BoxFit.cover,
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
                    ),
                    if (widget.imagesOnline[index] != '')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              // Handle delete action
                              setState(() {
                                // Perform deletion logic here
                                widget.imagesOnline[index] = '';
                                widget.onImagesSelected(widget.imagesOnline.map((image) => image).toList());
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () async {
                              // Handle edit action
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    scrollable: true,
                                    title: TextWidget.headLineSmall(texto: 'Elija una opcion:'),
                                    content: Column(
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              pickImage(index, ImageSource.gallery);
                                              Navigator.pop(context);
                                            },
                                            child: TextWidget.textMedium(texto: 'Subir archivo')),
                                        ElevatedButton(
                                            onPressed: () {
                                              pickImage(index, ImageSource.camera);
                                              Navigator.pop(context);
                                            },
                                            child: TextWidget.textMedium(texto: 'Tomar foto')),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class PrevizFullImage extends StatelessWidget {
  const PrevizFullImage({
    super.key,
    required this.urlImagen,
    this.prefixDownload,
  });

  final String urlImagen;
  final String? prefixDownload;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: const EdgeInsets.all(5),
      content: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Stack(
          children: [
            Image.network(
              urlImagen,
              fit: BoxFit.contain,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value:
                          loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1) : null,
                    ),
                  );
                }
              },
            ),
            Positioned(
                top: 10,
                right: 10,
                child: InkWell(
                  onTap: () {
                    saveImage(
                      context,
                      urlImagen,
                      prefixDownload,
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration:
                        BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey), borderRadius: const BorderRadius.all(Radius.circular(10))),
                    child: TextWidget.textLarge(texto: 'Descargar'),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

Future<void> saveImage(BuildContext context, String urlImage, String? prefixDownload) async {
  String? message;
  final scaffoldMessenger = ScaffoldMessenger.of(context);

  try {
    // Download image
    final http.Response response = await http.get(Uri.parse(urlImage));

    // Get temporary directory
    final dir = await getTemporaryDirectory();

    // Create an image name
    var filename = '${dir.path}/${prefixDownload ?? ''}.png';

    // Save to filesystem
    final file = File(filename);
    await file.writeAsBytes(response.bodyBytes);

    // Ask the user to save it
    final params = SaveFileDialogParams(sourceFilePath: file.path);
    final finalPath = await FlutterFileDialog.saveFile(params: params);

    if (finalPath != null) {
      message = 'Imagen guardada';
    }
  } catch (e) {
    message = 'HA ocurrido un error al querer guardar la imagen';
  }

  if (message != null) {
    scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
  }
}
