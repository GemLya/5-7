import 'dart:async';
import '../dominio/geo.dart';
import '../dominio/sensor.dart';

class SimuladorHardware implements InterfazSensores {
  final _controladorPosicion = StreamController<Coordenada>.broadcast();
  final _controladorRumbo = StreamController<double>.broadcast();

  Coordenada _posicionActual = const Coordenada(21.1570, -100.9325);
  double _rumboActual = 0.0;

  @override
  Stream<Coordenada> get streamPosicion async* {
    yield _posicionActual;
    yield* _controladorPosicion.stream;
  }

  @override
  Stream<double> get streamRumbo async* {
    yield _rumboActual;
    yield* _controladorRumbo.stream;
  }

  void moverPasos(double rumbo, double metros) {
    _posicionActual = desplazarPunto(_posicionActual, rumbo, metros);
    _controladorPosicion.add(_posicionActual);
  }

  void cambiarRumbo(double nuevoRumbo) {
    _rumboActual = (nuevoRumbo + 360) % 360;
    _controladorRumbo.add(_rumboActual);
  }

  void disponer() {
    _controladorPosicion.close();
    _controladorRumbo.close();
  }
}