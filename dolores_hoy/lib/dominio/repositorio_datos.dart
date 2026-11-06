import 'modelos_tablero.dart';

abstract class RepositorioDatos {
  Future<ModeloClima> obtenerClima();
  Future<ModeloFinanciero> obtenerFinanzas();
  Future<List<String>> obtenerDiasFestivos();
  Future<ModeloEfemeride> obtenerEfemerideHistorica();
  Future<ModeloNasa> obtenerImagenAstronómica();
}