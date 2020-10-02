import 'dart:convert';
import 'dart:io';
import 'package:flutter_app_harry/model/casa.dart';
import 'package:flutter_app_harry/model/hechizo.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import '../app_config.dart';
import 'package:flutter_app_harry/model/peronaje.dart';

class AuthAPi {
  String _apikey2 =
      r'$2a$10$5jjkD0xH649PMLSI8eEQO.tPihsRFqUScHOLyE/59n1W3P2f93Tiu';
  final _url = "${AppConfig.apiHost}";

  Future<String> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    print(decodeData);
    return decodeData.toString();
  }

  Future<List<Personaje>> _respuestaPersonaje(Uri url) async {
    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        final List<Personaje> lstPersonaje = personajeFromJson(response.body);
        return lstPersonaje;
      }else{
        return List<Personaje>();
      }
    } catch (e) {
      return List<Personaje>();
    }
  }
  Future<List<Casa>> _respuestaCasa(Uri url) async {
    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        final List<Casa> lstCasa = casaFromJson(response.body);
        return lstCasa;
      }else{
        return List<Casa>();
      }
    } catch (e) {
      return List<Casa>();
    }
  }
  Future<List<Hechizo>> _respuestaHechizo(Uri url) async {
    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        final List<Hechizo> lstHechizo = hechizoFromJson(response.body);
        return lstHechizo;
      }else{
        return List<Hechizo>();
      }
    } catch (e) {
      return List<Hechizo>();
    }
  }

  Future<List<Personaje>> getCharacters() async {
    final url = Uri.https(_url, 'v1/characters', {
      'key': _apikey2,
    });
    return await _respuestaPersonaje(url);
  }
  Future<List<Casa>> gethouses() async {
    final url = Uri.https(_url, 'v1/houses', {
      'key': _apikey2,
    });
    return await _respuestaCasa(url);
  }
  Future<List<Hechizo>> getSpells() async {
    final url = Uri.https(_url, 'v1/spells', {
      'key': _apikey2,
    });
    return await _respuestaHechizo(url);
  }

  Future<String> sortingHat() async {
    final url = Uri.https(_url, 'v1/sortingHat');
    return await _procesarRespuesta(url);
  }
}
