import 'geo.dart';

abstract class InterfazSensores {
  Stream<Coordenada> get streamPosicion;
  Stream<double> get streamRumbo;
}