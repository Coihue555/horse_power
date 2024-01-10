import 'package:flutter/material.dart';
import 'package:horse_power/utils/reg_exp_utils.dart';
import 'package:horse_power/widgets/text/text_widget.dart';
import 'package:horse_power/widgets/textfield/textfield_widget.dart';

class RecuperarContrasenaWidget extends StatefulWidget {
  const RecuperarContrasenaWidget({
    super.key,
    required this.maxWidth,
    required this.controller1,
    required this.controller2,
  });
  final double maxWidth;
  final TextEditingController controller1;
  final TextEditingController controller2;

  @override
  State<RecuperarContrasenaWidget> createState() => _RecuperarContrasenaWidgetState();
}

class _RecuperarContrasenaWidgetState extends State<RecuperarContrasenaWidget> {
  bool obscureText1 = true;
  bool obscureText2 = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        TextfieldWidget.contrasena(
            controller: widget.controller1,
            labelTitulo: 'Nueva contraseña',
            obscureText: obscureText1,
            onChanged: (p0) {
              _determinaMensaje();
              setState(() {});
            },
            ontap: () {
              obscureText1 = !obscureText1;
              setState(() {});
            }),
        const SizedBox(
          height: 10,
        ),
        TextfieldWidget.contrasena(
            controller: widget.controller2,
            labelTitulo: 'Repetir contraseña',
            obscureText: obscureText2,
            onChanged: (p0) {
              _determinaMensaje();
              setState(() {});
            },
            ontap: () {
              obscureText2 = !obscureText2;
              setState(() {});
            }),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: widget.maxWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _NivelSeguridadRecuadro(
                  enBlanco: widget.controller1.text.length < 4,
                  border: const Border(
                    top: BorderSide(width: 0.3, color: Colors.black54),
                    bottom: BorderSide(width: 0.3, color: Colors.black54),
                    left: BorderSide(width: 0.3, color: Colors.black54),
                  ),
                  maxWidth: widget.maxWidth,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
                  color: determinarColor(widget.controller1.text),
                  cumpleCondicion: widget.controller1.text.isNotEmpty),
              _NivelSeguridadRecuadro(
                  enBlanco: widget.controller1.text.length < 4,
                  border: const Border(top: BorderSide(width: 0.3, color: Colors.black54), bottom: BorderSide(width: 0.3, color: Colors.black54)),
                  maxWidth: widget.maxWidth,
                  color: determinarColor(widget.controller1.text),
                  cumpleCondicion: RegExpUtils.validaPassword(NivelSeguridadPassword.medio, widget.controller1.text)),
              _NivelSeguridadRecuadro(
                  enBlanco: widget.controller1.text.length < 4,
                  border: const Border(
                    top: BorderSide(width: 0.3, color: Colors.black54),
                    bottom: BorderSide(width: 0.3, color: Colors.black54),
                    right: BorderSide(width: 0.3, color: Colors.black54),
                  ),
                  maxWidth: widget.maxWidth,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                  color: determinarColor(widget.controller1.text),
                  cumpleCondicion: RegExpUtils.validaPassword(NivelSeguridadPassword.alto, widget.controller1.text)),
            ],
          ),
        ),
        if (_determinaMensaje().isNotEmpty) ...[
          const SizedBox(height: 10),
          TextWidget.textMedium(
            texto: _determinaMensaje(),
            maxlineas: 4,
          )
        ]
      ],
    );
  }

  String _determinaMensaje() {
    String error = '';
    String? contrasena = widget.controller1.text;
    String? repContrasena = widget.controller2.text;

    ///Nivel de seguridad Bajo
    if (contrasena.length < 8) {
      error = 'La contraseña debe poseer al menos 8 dígitos';
    }
    if (error.isEmpty) {
      if (!RegExpUtils.validarSiContieneNumero(contrasena)) {
        error = 'La contraseña debe poseer al menos 1 número';
      }
    }
    if (error.isEmpty) {
      if (!RegExpUtils.validarSiContieneLetras(contrasena)) {
        error = 'La contraseña debe poseer al menos 1 letra';
      }
    }
    if (error.isEmpty) {
      if (!RegExpUtils.validaPassword(NivelSeguridadPassword.alto, contrasena)) {
        error = 'La contraseña debe contener carácter especial, números, letras minúsculas y mayúsculas';
      }
    }
    if (error.isEmpty) {
      if (repContrasena.length >= 8 && contrasena.length >= 8 && repContrasena != contrasena) {
        error = 'Las contraseña no son iguales';
      }
    }
    return error;
  }
}

Color determinarColor(String texto) {
  Color color = Colors.grey[350]!;
  if (texto.isEmpty) {
    return color;
  }
  if (texto.length >= 4) {
    color = Colors.red;
  }
  if (RegExpUtils.validaPassword(NivelSeguridadPassword.medio, texto)) {
    color = Colors.yellow;
  }
  if (RegExpUtils.validaPassword(NivelSeguridadPassword.alto, texto)) {
    color = Colors.green;
  }

  return color;
}

class _NivelSeguridadRecuadro extends StatelessWidget {
  const _NivelSeguridadRecuadro(
      {Key? key, required this.color, required this.cumpleCondicion, this.borderRadius, required this.maxWidth, required this.border, required this.enBlanco})
      : super(key: key);
  final Color color;
  final bool enBlanco;
  final bool cumpleCondicion;
  final BorderRadius? borderRadius;
  final BoxBorder border;
  final double maxWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: border, color: cumpleCondicion ? color : Colors.white),
      child: Container(
        alignment: Alignment.centerRight,
        height: 2.5,
        width: maxWidth / 3.542,
        decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: enBlanco
                ? Colors.grey[350]!
                : cumpleCondicion
                    ? color
                    : Colors.white),
      ),
    );
  }
}
