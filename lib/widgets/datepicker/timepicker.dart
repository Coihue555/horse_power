// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimepickerWidget extends StatefulWidget {
  const TimepickerWidget({
    super.key,
    this.initialTime,
    required this.onHoraSeleccionada,
  });
  final ValueChanged<String> onHoraSeleccionada;
  final String? initialTime;

  @override
  State<TimepickerWidget> createState() => _TimepickerWidgetState();
}

class _TimepickerWidgetState extends State<TimepickerWidget> {
  late TimeOfDay horaSeleccionada;
  late TimeOfDay initialTime;

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    initialTime = TimeOfDay.now();
  }

  TimeOfDay inicializar(String? hora) {
    log(hora.toString());
    try {
      if (hora != null && hora != '') {
        DateTime aux = DateFormat('HH:mm').parse(hora);
        return TimeOfDay.fromDateTime(aux);
      } else {
        return TimeOfDay.now();
      }
    } catch (e) {
      log('error al parsear hora inicial en datePicker $e');
      return TimeOfDay.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      canRequestFocus: false,
      onTap: () async {
        horaSeleccionada = inicializar(widget.initialTime);
        initialTime = inicializar(widget.initialTime);

        TimeOfDay? hora = (defaultTargetPlatform == TargetPlatform.iOS)
            ? await _mostrarSelectorHoraIos(
                context,
                initialTime,
              )
            : await _mostrarSelectorHoraAndroid(
                context,
                initialTime,
              );

        if (hora != null) {
          widget.onHoraSeleccionada.call('${hora.hour.toString().padLeft(2, '0')}:${hora.minute.toString().padLeft(2, '0')}');
        }
      },
      child: const Icon(
        Icons.timer,
        color: Colors.grey,
      ),
    );
  }

  Future<TimeOfDay?> _mostrarSelectorHoraAndroid(
    BuildContext context,
    TimeOfDay initialTime,
  ) async {
    TimeOfDay? horaAndroid = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: TimePickerDialog(
              orientation: Orientation.portrait,
              initialEntryMode: TimePickerEntryMode.dialOnly,
              initialTime: initialTime,
            ));
      },
    );
    if (mounted) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
    return horaAndroid;
  }

  Future<TimeOfDay?> _mostrarSelectorHoraIos(BuildContext context, TimeOfDay initialTime) async {
    TimeOfDay? horaIos = await showCupertinoModalPopup(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                          color: Theme.of(context).dialogBackgroundColor,
                          alignment: Alignment.centerRight,
                          child: const Text(
                            'Cancelar',
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      CupertinoButton(
                          color: Theme.of(context).dialogBackgroundColor,
                          alignment: Alignment.centerRight,
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
                        initialDateTime: DateTime.now(),
                        mode: CupertinoDatePickerMode.time,
                        use24hFormat: true,
                        onDateTimeChanged: (val) {
                          horaSeleccionada = TimeOfDay(hour: val.hour, minute: val.minute);
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
    return horaIos;
  }
}
