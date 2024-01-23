import 'dart:io';
import 'package:flutter/material.dart';
import 'package:horse_power/global/environment.dart';
import 'package:horse_power/services/upload_image.dart';
import 'package:horse_power/widgets/text/text_widget.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadWidget extends StatefulWidget {
  const ImageUploadWidget({Key? key, required this.onImagesSelected, required this.imagesOnline}) : super(key: key);
  final Function(List<String>) onImagesSelected;
  final List<String> imagesOnline;

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
      height: 120,
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
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration:
                          BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey), borderRadius: const BorderRadius.all(Radius.circular(5))),
                      child: widget.imagesOnline[index] == ''
                          ? const Icon(Icons.add)
                          : Image.network(
                              widget.imagesOnline[index],
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
                    ),
                    TextWidget.textMedium(texto: lstNomImagenes[index]),
                  ],
                ),
              ),
            );
          }),
    );
  }
}