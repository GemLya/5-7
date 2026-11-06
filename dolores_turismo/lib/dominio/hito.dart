import 'geo.dart';

class HitoTuristico {
  final String id;
  final String nombre;
  final String descripcion;
  final Coordenada ubicacion;
  final String modelo3dId;

  const HitoTuristico({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.ubicacion,
    required this.modelo3dId,
  });
}