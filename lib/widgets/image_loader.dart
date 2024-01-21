import 'dart:io';
import 'package:flutter/material.dart';
import 'package:horse_power/global/environment.dart';
import 'package:horse_power/theme/theme.dart';
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

  Future<void> _pickImage(int index) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImages[index] = pickedFile;
    });

    widget.onImagesSelected(selectedImages.where((image) => image != null).map((image) => image!.path).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget.textLarge(
          texto: 'Subir imagenes:',
          colorTextoDark: ThemeModel().colorPrimario,
          colorTextoLight: ThemeModel().colorPrimario,
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 120,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: selectedImages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => _pickImage(index),
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              color: Colors.white, border: Border.all(color: Colors.grey), borderRadius: const BorderRadius.all(Radius.circular(5))),
                          child: selectedImages[index] != null
                              ? Image.file(
                                  File(selectedImages[index]!.path),
                                  fit: BoxFit.cover,
                                )
                              : widget.imagesOnline[index] == ''
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
        )
      ],
    );
  }
}
