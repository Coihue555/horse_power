// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatepickerWidget extends StatefulWidget {
  const DatepickerWidget({
    super.key,
    this.fechaInicial,
    this.primerFecha,
    this.ultimaFecha,
    required this.onFechaSeleccionada,
  });
  final ValueChanged<String> onFechaSeleccionada;
  final String? fechaInicial;
  final String? primerFecha;
  final String? ultimaFecha;

  @override
  State<DatepickerWidget> createState() => _DatepickerWidgetState();
}

class _DatepickerWidgetState extends State<DatepickerWidget> {
  late DateTime fechaSeleccionada;
  late DateTime fechaIni;
  late DateTime fechaMinima;
  late DateTime fechaMaxima;
  late DateFormat format;
  String formato = 'dd/MM/yyyy';
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  DateTime inicializar(String? fecha) {
    try {
      if (fecha != null && fecha != '') {
        return format.parse(fecha);
      } else {
        return selectedDate;
      }
    } catch (e) {
      log('error al parsear fecha inicial en datePicker $e');
      return selectedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      canRequestFocus: false,
      onTap: () async {
        format = DateFormat(formato);
        fechaSeleccionada = inicializar(widget.fechaInicial);
        fechaIni = inicializar(widget.fechaInicial);
        fechaMinima = inicializar(widget.primerFecha).subtract(const Duration(days: 50000));
        fechaMaxima = inicializar(widget.primerFecha).add(const Duration(days: 50000));
        fechaIni = fechaIni.isBefore(fechaMinima) ? fechaMinima : fechaSeleccionada;
        fechaIni = fechaIni.isAfter(fechaMaxima) ? fechaMaxima : fechaIni;
        DateTime? fecha = (defaultTargetPlatform == TargetPlatform.iOS)
            ? await _mostrarSelectorFechaIos(context, formato, fechaIni, fechaMinima, fechaMaxima)
            : await _mostrarSelectorFechaAndroid(context, formato, fechaIni, fechaMinima, fechaMaxima);

        if (fecha != null) {
          widget.onFechaSeleccionada.call(format.format(fecha));
        }
      },
      child: const Icon(Icons.calendar_month_outlined, size: 27),
    );
  }

  Future<DateTime?> _mostrarSelectorFechaAndroid(
    BuildContext context,
    String formatoFecha,
    DateTime fechaInicial,
    DateTime primerFecha,
    DateTime ultimaFecha,
  ) async {
    DateTime? fecha = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDate: fechaInicial,
      firstDate: fechaInicial,
      lastDate: ultimaFecha,
      locale: const Locale('es', 'ES'),
      fieldHintText: formatoFecha,
      builder: (context, child) {
        return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: DatePickerDialog(
              initialEntryMode: DatePickerEntryMode.calendar,
              initialDate: fechaInicial,
              firstDate: primerFecha,
              lastDate: ultimaFecha,
            ));
      },
    );
    if (mounted) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
    return Future.value(fecha);
  }

  Future<DateTime?> _mostrarSelectorFechaIos(
    BuildContext context,
    String formatoFecha,
    DateTime fechaInicial,
    DateTime primerFecha,
    DateTime ultimaFecha,
  ) async {
    await showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: Container(
              height: 220,
              color: Theme.of(context).dialogBackgroundColor,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CupertinoButton(
                          padding: EdgeInsets.zero,
                          color: Theme.of(context).dialogBackgroundColor,
                          alignment: Alignment.center,
                          child: const Text(
                            'Cancelar',
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      CupertinoButton(
                          padding: EdgeInsets.zero,
                          color: Theme.of(context).dialogBackgroundColor,
                          alignment: Alignment.center,
                          child: const Text(
                            'Aceptar',
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ],
                  ),
                  const Divider(),
                  SizedBox(
                    height: 150,
                    child: CupertinoDatePicker(
                        backgroundColor: Theme.of(context).dialogBackgroundColor,
                        initialDateTime: fechaInicial,
                        minimumDate: primerFecha,
                        maximumDate: ultimaFecha,
                        mode: CupertinoDatePickerMode.date,
                        use24hFormat: true,
                        onDateTimeChanged: (val) {
                          fechaSeleccionada = val;
                          setState(() {});
                        }),
                  ),
                ],
              ),
            ),
          );
        });
    if (mounted) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
    return Future.value(fechaSeleccionada);
  }
}
