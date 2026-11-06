import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dominio/modelos_tablero.dart';
import '../dominio/repositorio_datos.dart';

class ApiCliente implements RepositorioDatos {
  final http.Client cliente;
  const ApiCliente({required this.cliente});

  @override
  Future<ModeloClima> obtenerClima() async {
    // Coordenadas aproximadas de Dolores Hidalgo, Gto.
    final url = Uri.parse('https://open-meteo.com');
    final respuesta = await cliente.get(url).timeout(const Duration(seconds: 6));
    if (respuesta.statusCode == 200) {
      final json = jsonDecode(respuesta.body);
      final actual = json['current_weather'];
      return ModeloClima(
        temperatura: (actual['temperature'] as num).toDouble(),
        condicion: 'Código WMO: ${actual['weathercode']}',
      );
    }
    throw Exception('Error al consultar servidor meteorológico');
  }

  @override
  Future<ModeloFinanciero> obtenerFinanzas() async {
    final url = Uri.parse('https://er-api.com');
    final respuesta = await cliente.get(url).timeout(const Duration(seconds: 6));
    if (respuesta.statusCode == 200) {
      final json = jsonDecode(respuesta.body);
      final tasas = json['rates'];
      return ModeloFinanciero(
        tipoCambioUsd: (tasas['MXN'] as num).toDouble(),
        base: 'USD',
      );
    }
    throw Exception('Error al consultar mercado de divisas');
  }

  @override
  Future<List<String>> obtenerDiasFestivos() async {
    final url = Uri.parse('https://nager.at');
    final respuesta = await cliente.get(url).timeout(const Duration(seconds: 6));
    if (respuesta.statusCode == 200) {
      final List json = jsonDecode(respuesta.body);
      return json.take(3).map((item) => "${item['date']}: ${item['localName']}").toList();
    }
    throw Exception('Error al consultar calendario de festivos');
  }

  @override
  Future<ModeloEfemeride> obtenerEfemerideHistorica() async {
    final url = Uri.parse('https://wikipedia.org');
    final respuesta = await cliente.get(url).timeout(const Duration(seconds: 6));
    if (respuesta.statusCode == 200) {
      final json = jsonDecode(respuesta.body);
      return ModeloEfemeride(
        titulo: json['title'] ?? 'Dolores Hidalgo',
        extracto: json['extract'] ?? 'Sin extracto disponible.',
      );
    }
    throw Exception('Error al consultar enciclopedia digital');
  }

  @override
  Future<ModeloNasa> obtenerImagenAstronómica() async {
    // Se utiliza el endpoint demo público provisto por la documentación de la NASA
    final url = Uri.parse('https://nasa.gov');
    final respuesta = await cliente.get(url).timeout(const Duration(seconds: 6));
    if (respuesta.statusCode == 200) {
      final json = jsonDecode(respuesta.body);
      return ModeloNasa(
        urlImagen: json['url'] ?? 'https://nasa.gov',
        explicacion: json['explanation'] ?? 'Imagen astronómica del día.',
      );
    }
    throw Exception('Error al conectar con los servidores de la NASA');
  }
}