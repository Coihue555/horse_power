import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horse_power/theme/theme.dart';
import 'package:horse_power/utils/reg_exp_utils_cdm.dart';
import 'package:horse_power/widgets/datepicker/datepicker.dart';
import 'package:horse_power/widgets/datepicker/timepicker.dart';
import 'package:horse_power/widgets/text/text_widget.dart';

part 'textfield_model.dart';

class TextfieldWidget extends StatelessWidget {
  const TextfieldWidget({
    super.key,
    required this.child,
    this.controller,
    this.labelTitulo,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.maxWidth,
    this.focusNode,
    this.altoCampo,
    this.leftWidget,
    this.rightWidget,
    this.disabled,
    this.tituloNegrita = !kIsWeb,
  });
  final TextEditingController? controller;
  final String? labelTitulo;
  final String? hintText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final double? maxWidth;
  final FocusNode? focusNode;
  final double? altoCampo;
  final Widget? leftWidget;
  final Widget? rightWidget;
  final Widget child;
  final bool? disabled;
  final bool? tituloNegrita;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (leftWidget != null)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: leftWidget ?? Container(),
              ),
            if (labelTitulo != null && labelTitulo != '')
              Flexible(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: Text(
                    labelTitulo!,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: ThemeModel().sizeTituloTextfield,
                        color: ThemeModel().colorTitulosCajasDeTexto,
                        fontWeight: tituloNegrita ?? false ? FontWeight.bold : null),
                  ),
                ),
              ),
            if (rightWidget != null)
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: rightWidget ?? Container(),
              ),
          ],
        ),
        AbsorbPointer(
          absorbing: disabled ?? false,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: maxWidth ?? MediaQuery.of(context).size.width,
            ),
            height: altoCampo,
            alignment: Alignment.topCenter,
            child: child,
          ),
        ),
        if (hintText != null)
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              hintText!,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: ThemeModel().sizeDescripcionTextfield,
                    color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.7),
                  ),
            ),
          ),
      ],
    );
  }

  factory TextfieldWidget.contrasena({
    TextEditingController? controller,
    required String labelTitulo,
    String? hintText,
    Function(String)? onChanged,
    Function(String)? onSubmitted,
    double? maxWidth,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    required bool obscureText,
    required Function() ontap,
    List<String>? autofillHints,
    Widget? leftWidget,
    Widget? rightWidget,
    bool? tituloNegrita,
    Widget? labelInterno,
  }) = _TextfieldContrasenaWidget;

  // factory TextfieldWidget.telefono({
  //   TextEditingController? controller,
  //   required String labelTitulo,
  //   String? hintText,
  //   Function(String)? onChanged,
  //   Function(String)? onSubmitted,
  //   FocusNode? focusNode,
  //   TextInputAction? textInputAction,
  //   List<String>? autofillHints,
  //   Widget? leftWidget,
  //   Widget? rightWidget,
  //   bool? tituloNegrita,
  // }) = _TextfieldTelefonoWidget;

  factory TextfieldWidget.texto(
      {TextEditingController? controller,
      String? labelTitulo,
      String? hintText,
      Function(String)? onChanged,
      Function(String)? onSubmitted,
      double? maxWidth,
      FocusNode? focusNode,
      TextInputAction? textInputAction,
      List<String>? autofillHints,
      Widget? leftWidget,
      Widget? rightWidget,
      bool? disabled,
      Widget? labelInterno,
      bool? tituloNegrita,
      Widget? suffixIcon}) = _TextfieldTextWidget;

  factory TextfieldWidget.email({
    TextEditingController? controller,
    required String labelTitulo,
    String? hintText,
    Function(String)? onChanged,
    Function(String)? onSubmitted,
    double? maxWidth,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    List<String>? autofillHints,
    Widget? leftWidget,
    Widget? rightWidget,
    bool? tituloNegrita,
    Widget? labelInterno,
  }) = _TextfieldEmailWidget;

  factory TextfieldWidget.numero(
      {TextEditingController? controller,
      String? labelTitulo,
      String? hintText,
      Function(String)? onChanged,
      Function(String)? onSubmitted,
      double? maxWidth,
      FocusNode? focusNode,
      TextInputAction? textInputAction,
      List<String>? autofillHints,
      Widget? leftWidget,
      Widget? rightWidget,
      Widget? labelInterno,
      bool? tituloNegrita,
      Widget? suffixIcon}) = _TextfieldNumeroWidget;

  factory TextfieldWidget.fecha(
      {TextEditingController? controller,
      required String labelTitulo,
      String? hintText,
      Function(String)? onChanged,
      required Function(String) onSubmitted,
      FocusNode? focusNode,
      TextInputAction? textInputAction,
      List<String>? autofillHints,
      Widget? leftWidget,
      List<TextInputFormatter>? inputFormatters,
      Widget? rightWidget,
      Widget? labelInterno,
      bool? tituloNegrita,
      bool? selectorInterno}) = _TextfieldFechaWidget;

  factory TextfieldWidget.hora({
    TextEditingController? controller,
    required String labelTitulo,
    String? hintText,
    Function(String)? onChanged,
    required Function(String) onSubmitted,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    List<String>? autofillHints,
    List<TextInputFormatter>? inputFormatters,
    Widget? leftWidget,
    Widget? rightWidget,
    bool? tituloNegrita,
  }) = _TextfieldHoraWidget;

  // factory TextfieldWidget.busqueda({
  //   required String labelTitulo,
  //   String? hintText,
  //   Function()? onNuevo,
  //   String? tituloNuevo,
  //   TipoBusqueda? tipoBusqueda,
  //   bool? showTooltip,
  //   required List<ItemModel> lstOpciones,
  //   ItemModel? valorDefecto,
  //   Function(ItemModel)? onChanged,

  //   ///Evento para tomar el valor al precionar enter
  //   Function(String)? onSubmitted,
  //   Widget? leftWidget,
  //   Widget? rightWidget,
  //   Widget? labelInterno,
  //   Widget? suffixIcon,
  //   //Function(FocusNode)? onFocusNodeCreate,
  //   bool? tituloNegrita,
  // }) = _TextfieldBusquedaWidget;

  factory TextfieldWidget.validaClave({
    required TextEditingController controller,
    String? hintText,
    Function(String)? onChanged,
    Function(String)? onSubmitted,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    required bool obscureText,
    required Function() ontap,
    Widget? leftWidget,
    Widget? rightWidget,
    bool? tituloNegrita,
  }) = _TextfieldValidaClaveWidget;

  factory TextfieldWidget.multilinea({
    TextEditingController? controller,
    int? minLines,
    int? maxLines,
    String? labelTitulo,
    String? hintText,
    Function(String)? onChanged,
    Function(String)? onSubmitted,
    double? maxWidth,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    List<String>? autofillHints,
    Widget? leftWidget,
    Widget? rightWidget,
    bool? disabled,
    bool? tituloNegrita,
  }) = _TextfieldMultilineaWidget;
  factory TextfieldWidget.numeroReal(
      {TextEditingController? controller,
      String? labelTitulo,
      String? hintText,
      Function(String)? onChanged,
      Function(String)? onSubmitted,
      double? maxWidth,
      FocusNode? focusNode,
      TextInputAction? textInputAction,
      List<String>? autofillHints,
      Widget? leftWidget,
      Widget? rightWidget,
      bool? disabled,
      Widget? labelInterno,
      bool? tituloNegrita,
      Widget? suffixIcon}) = _TextfieldNumeroRealWidget;
  factory TextfieldWidget.fromValue({
    required TipoTextField tipoTextField,
    TextEditingController? controller,
    int? minLines,
    int? maxLines,
    String? labelTitulo,
    String? hintText,
    Function(String)? onChanged,
    Function(String)? onSubmitted,
    double? maxWidth,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    List<String>? autofillHints,
    Widget? leftWidget,
    Widget? rightWidget,
    bool? disabled,
    bool? obscureText,
    bool? tituloNegrita,
    Function()? ontap,
    double? altoCampo,
  }) = _TextfielFromValueWidget;
}

enum TipoTextField {
  texto('t', 'texto'),
  numero('num', 'numero'),
  numeroReal('numReal', 'numero Real'),
  email('e', 'email'),
  contrasena('c', 'contrasena'),
  telefono('t', 'telefono'),
  fecha('f', 'fecha'),
  hora('h', 'hora'),
  // busqueda('b', 'busqueda'),
  multilinea('m', 'multilinea');

  final String valor;
  final String descripcion;
  const TipoTextField(this.valor, this.descripcion);
}
