import 'geo.dart';

class ElementoProyectado {
  final String id;
  final double xRelativo; 
  final double escala;
  final double distancia;

  const ElementoProyectado({
    required this.id,
    required this.xRelativo,
    required this.escala,
    required this.distancia,
  });
}

class MotorProyeccionAR {
  final double fovHorizontal;
  final double maxDistancia;

  const MotorProyeccionAR({this.fovHorizontal = 60.0, this.maxDistancia = 150.0});

  ElementoProyectado? proyectar(Coordenada usuario, double rumboUsuario, Coordenada hito, String id) {
    final distancia = calcularDistancia(usuario, hito);
    if (distancia > maxDistancia) return null;

    final rumboHito = calcularRumbo(usuario, hito);
    var deltaAngulo = rumboHito - rumboUsuario;

    if (deltaAngulo > 180) deltaAngulo -= 360;
    if (deltaAngulo < -180) deltaAngulo += 360;

    if (deltaAngulo.abs() > (fovHorizontal / 2)) return null;

    final xRelativo = (deltaAngulo / (fovHorizontal / 2)); 
    final escala = (1.0 - (distancia / maxDistancia)).clamp(0.2, 1.0);

    return ElementoProyectado(id: id, xRelativo: xRelativo, escala: escala, distancia: distancia);
  }
}