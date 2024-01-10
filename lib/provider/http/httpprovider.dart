import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import 'httpprovider_task.dart';

class HttpProvider {
  static final HttpProvider _instancia = HttpProvider._internal();
  int isolateTask = 0;

  factory HttpProvider() {
    return _instancia;
  }

  HttpProvider._internal();

  IOClient httpCertificado() {
    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return IOClient(ioc);
  }

  Future<Map<String, dynamic>> httpAccion(String funcion, String url,
      {Map<String, String>? headers,
      Object? body,
      Encoding? encoding,
      Uint8List? fileBytes,
      String? imagenNombre}) async {
    Map<String, dynamic> respuesta = {};
    bool runIsolate = false;
    if (!kIsWeb) {
      isolateTask++;
      if (isolateTask <= 5) {
        runIsolate = true;
      }
    }
    final httpProviderTask = HttpProviderTask(
        funcion: funcion,
        url: url,
        headers: headers,
        body: body,
        encoding: encoding,
        fileBytes: fileBytes,
        imagenNombre: imagenNombre,
        httpMovil: (!kIsWeb) ? httpCertificado() : null,
        httpWeb: http.Client());
    if (runIsolate) {
      respuesta = await httpProviderTask.downLoadInBackground();
      isolateTask--;
    } else {
      respuesta = await httpProviderTask.downLoad(null);
    }
    return respuesta;
  }
}
