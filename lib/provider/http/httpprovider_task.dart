import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:horse_power/global/environment.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class HttpProviderTask {
  final String url;
  final String funcion;

  final Map<String, String>? headers;
  final Object? body;
  final Encoding? encoding;
  final Uint8List? fileBytes;
  final String? imagenNombre;

  final IOClient? httpMovil;
  final http.Client? httpWeb;

  HttpProviderTask(
      {required this.funcion, required this.url, this.headers, this.body, this.encoding, this.fileBytes, this.imagenNombre, this.httpMovil, this.httpWeb});

  Future<Map<String, dynamic>> downLoadInBackground() async {
    try {
      // crear el puerto
      final recivePort = ReceivePort();
      // ejecutar el Isolate Spawn y esperar a que se complete
      await Isolate.spawn(downLoad, recivePort.sendPort);
      // toma y retorna la respuesta del Isolate
      return await recivePort.first;
    } catch (error) {
      log('Sucedio el error $error ');
      return {};
    }
  }

  Future<Map<String, dynamic>> downLoad(SendPort? sendPort) async {
    final uriurl = Uri.parse(url);
    http.Response response;
    Map<String, dynamic> respuesta;

    var httpClient = (!kIsWeb) ? httpMovil : httpWeb;

    try {
      switch (funcion) {
        case 'GET':
          response = await httpClient!.get(uriurl, headers: headers);
          break;
        case 'POST':
          response = await httpClient!.post(uriurl, headers: headers, body: body, encoding: encoding).timeout(const Duration(seconds: 10));
          break;
        case 'PUT':
          response = await httpClient!.put(uriurl, headers: headers, body: body, encoding: encoding).timeout(const Duration(seconds: 10));
          log(response.statusCode.toString());
          log(response.body);
          break;
        case 'DELETE':
          response = await httpClient!.delete(uriurl, headers: headers, body: body, encoding: encoding).timeout(const Duration(seconds: 10));
          break;
        case 'UPLOAD':

          ///Solo en web es obligatorio el [fileBytes] ya que en movil utiliza el path
          if (fileBytes == null && kIsWeb) {
            throw 'para realizar un upload de un archivo se requiere del valor de fileBytes';
          }
          if (headers == null) {
            throw 'para realizar un upload de un archivo se requiere de los headers ';
          }
          if (!headers!.containsKey(Environment.destinoImagen)) {
            throw 'para realizar un upload de un archivo se requiere que en los headers se haya espesificado el valor de destinoImagen';
          }
          final request = http.MultipartRequest('POST', uriurl);

          ///Si se trata de web utiliza [MultipartFile.fromBytes]
          if (kIsWeb) {
            request.files.add(http.MultipartFile.fromBytes('file', fileBytes!, filename: imagenNombre));
          }

          ///Ai es movil utiliza [MultipartFile.fromPath] para subir la imagen
          else {
            request.files.add(await http.MultipartFile.fromPath('file', imagenNombre!));
          }
          request.headers.addAll(headers!);
          var res = await request.send().timeout(const Duration(seconds: 10));

          response = await http.Response.fromStream(res).timeout(const Duration(seconds: 10));
          break;
        default:
          throw 'Falta Definir la Funcion (GET, PUT, POST , DELETE o UPLOAD';
      }
      respuesta = _response(response);
    } on TimeoutException catch (error) {
      respuesta = _error(error.message.toString(), 'GET', url);
    } on SocketException {
      respuesta = _socketException();
    } catch (error) {
      respuesta = _error(error.toString(), funcion, url);
    }
    if (sendPort != null) {
      Isolate.exit(sendPort, respuesta);
    } else {
      return respuesta;
    }
  }

  Map<String, dynamic> _socketException() {
    return {Environment.dataNOk: 'Sin conexión a Internet', Environment.status: '000', Environment.errorHttp: 'Sin conexión a Internet'};
  }

  Map<String, dynamic> _error(Object error, String funcion, String url) {
    return {Environment.dataNOk: 'Error inesperdo en $funcion $url', Environment.status: '000', Environment.errorHttp: 'Error inesperdo $error'};
  }

  Map<String, dynamic> _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        if (response.body.isEmpty) {
          return {
            Environment.dataNOk: 'No Existen Datos',
            Environment.errorHttp: 'No Existen Datos',
            Environment.status: '000',
          };
        }
        return {
          Environment.dataOk: response.body,
          Environment.status: '${response.statusCode}',
        };
      case 400:
        return {
          Environment.dataNOk: response.body,
          Environment.status: '${response.statusCode}',
          Environment.errorHttp: response.body,
        };
      case 401:
      case 403:
        return {
          Environment.dataOk: response.body,
          Environment.status: '${response.statusCode}',
          Environment.inStatus: '450',
        };
      case 404:
        if (funcion == 'DELETE') {
          return {
            Environment.dataOk: response.body,
            Environment.status: '${response.statusCode}',
          };
        }
        return {
          Environment.dataNOk: 'No Existe',
          Environment.status: '${response.statusCode}',
          Environment.errorHttp: response.body.toString(),
        };

      case 416:
        return {
          Environment.dataNOk: 'Rango de Datos No Satifactorio',
          Environment.status: '${response.statusCode}',
          Environment.errorHttp: response.body.toString()
        };
      case 450:
        return {
          Environment.dataOk: response.body,
          Environment.status: '${response.statusCode}',
          Environment.inStatus: '450',
        };
      case 499:
        return {
          Environment.dataOk: response.body,
          Environment.status: '${response.statusCode}',
          Environment.inStatus: '450',
        };
      case 500:
        return {
          Environment.dataNOk: 'Error del servidor interno',
          Environment.status: '${response.statusCode}',
          Environment.errorHttp: response.body.toString(),
        };
      default:
        return {
          Environment.dataNOk: 'Ocurrió un error durante la comunicación con el servidor',
          Environment.status: '${response.statusCode}',
          Environment.errorHttp: response.body.toString()
        };
    }
  }
}
