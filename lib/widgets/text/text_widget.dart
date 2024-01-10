import 'package:flutter/material.dart';

part 'text_model.dart';

class TextWidget extends StatelessWidget {
  final Widget child;

  const TextWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }

  factory TextWidget.textSmall(
      {required String texto,
      Color? colorTextoLight,
      Color? colorTextoDark,
      FontWeight? tipoFuente,
      int? maxlineas,
      TextAlign? textAling,
      TextOverflow? overflow,
      TextDecoration? decoration,
      bool? ocultarTexto}) = _TextSmallWidget;

  factory TextWidget.textMedium(
      {required String texto,
      Color? colorTextoLight,
      Color? colorTextoDark,
      FontWeight? tipoFuente,
      int? maxlineas,
      TextAlign? textAling,
      TextOverflow? overflow,
      TextDecoration? decoration,
      bool? ocultarTexto}) = _TextMediumWidget;

  factory TextWidget.textLarge(
      {required String texto,
      Color? colorTextoLight,
      Color? colorTextoDark,
      FontWeight? tipoFuente,
      int? maxlineas,
      TextAlign? textAling,
      TextOverflow? overflow,
      TextDecoration? decoration,
      bool? ocultarTexto}) = _TextLargeWidget;

  factory TextWidget.titleSmall(
      {required String texto,
      Color? colorTextoLight,
      Color? colorTextoDark,
      FontWeight? tipoFuente,
      int? maxlineas,
      TextAlign? textAling,
      TextOverflow? overflow,
      TextDecoration? decoration,
      bool? ocultarTexto}) = _TitleSmallWidget;

  factory TextWidget.titleMedium(
      {required String texto,
      Color? colorTextoLight,
      Color? colorTextoDark,
      FontWeight? tipoFuente,
      int? maxlineas,
      TextAlign? textAling,
      TextOverflow? overflow,
      TextDecoration? decoration,
      bool? ocultarTexto}) = _TitleMediumWidget;

  factory TextWidget.titleLarge(
      {required String texto,
      Color? colorTextoLight,
      Color? colorTextoDark,
      FontWeight? tipoFuente,
      int? maxlineas,
      TextAlign? textAling,
      TextOverflow? overflow,
      TextDecoration? decoration,
      bool? ocultarTexto}) = _TitleLargeWidget;

  factory TextWidget.headLineSmall(
      {required String texto,
      Color? colorTextoLight,
      Color? colorTextoDark,
      FontWeight? tipoFuente,
      int? maxlineas,
      TextAlign? textAling,
      TextOverflow? overflow,
      TextDecoration? decoration,
      bool? ocultarTexto}) = _HeadLineSmallWidget;

  factory TextWidget.headLineMedium(
      {required String texto,
      Color? colorTextoLight,
      Color? colorTextoDark,
      FontWeight? tipoFuente,
      int? maxlineas,
      TextAlign? textAling,
      TextOverflow? overflow,
      TextDecoration? decoration,
      bool? ocultarTexto}) = _HeadLineMediumWidget;

  factory TextWidget.headLineLarge(
      {required String texto,
      Color? colorTextoLight,
      Color? colorTextoDark,
      FontWeight? tipoFuente,
      int? maxlineas,
      TextAlign? textAling,
      TextOverflow? overflow,
      TextDecoration? decoration,
      bool? ocultarTexto}) = _HeadLineLargeWidget;
  factory TextWidget.fromValue(
      {required String texto,
      required TipoTexto tipoTexto,
      Color? colorTextoLight,
      Color? colorTextoDark,
      FontWeight? tipoFuente,
      int? maxlineas,
      TextAlign? textAling,
      TextOverflow? overflow,
      TextDecoration? decoration,
      bool? ocultarTexto}) = _FromValueWidget;
}

enum TipoTexto {
  textSmall('teS', 'Texto pequeño'),
  textMedium('teM', 'Texto mediano'),
  textLarge('teL', 'Texto grande'),
  titleSmall('tiS', 'Titulo pequeño'),
  titleMedium('tiM', 'Titulo mediano'),
  titleLarge('tiL', 'Titulo grande'),
  headLineSmall('hS', 'Cabecera pequeña'),
  headLineMedium('hM', 'Cabecera mediana'),
  headLineLarge('hL', 'Cabecera grande');

  final String valor;
  final String descripcion;
  const TipoTexto(this.valor, this.descripcion);
}
