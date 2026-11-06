import 'package:flutter/material.dart';
import '../dominio/modelos_tablero.dart';
import '../dominio/repositorio_datos.dart';

enum EstadoTablero { cargando, exito, errorParcial, errorTotal }

class TableroViewModel extends ChangeNotifier {
  final RepositorioDatos api;

  TableroViewModel({required this.api});

  EstadoTablero estado = EstadoTablero.cargando;
  ModeloDatosTablero datos = const ModeloDatosTablero();
  String mensajeErrorGlobal = '';

  Future<void> cargarInformacionTablero() async {
    estado = EstadoTablero.cargando;
    notifyListeners();

    ModeloClima? climaRes;
    ModeloFinanciero? finanzasRes;
    List<String>? diasFestivosRes;
    ModeloEfemeride? efemerideRes;
    ModeloNasa? nasaRes;

    // Ejecución masiva asíncrona concurrente en paralelo
    final llamadas = await Future.wait([
      api.obtenerClima().then((v) => climaRes = v).catchError((_) => null),
      api.obtenerFinanzas().then((v) => finanzasRes = v).catchError((_) => null),
      api.obtenerDiasFestivos().then((v) => diasFestivosRes = v).catchError((_) => null),
      api.obtenerEfemerideHistorica().then((v) => efemerideRes = v).catchError((_) => null),
      api.obtenerImagenAstronómica().then((v) => nasaRes = v).catchError((_) => null),
    ]);

    datos = ModeloDatosTablero(
      clima: climaRes,
      finanzas: finanzasRes,
      diasFestivos: diasFestivosRes,
      efemeride: efemerideRes,
      nasa: nasaRes,
    );

    if (datos.esVacio) {
      estado = EstadoTablero.errorTotal;
      mensajeErrorGlobal = 'No se pudo obtener información de ningún servicio de red de forma exitosa.';
    } else if (datos.tieneErroresParciales) {
      estado = EstadoTablero.errorParcial;
    } else {
      estado = EstadoTablero.exito;
    }

    notifyListeners();
  }
}