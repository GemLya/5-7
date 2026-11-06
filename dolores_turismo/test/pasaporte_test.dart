import 'package:flutter_test/flutter_test.dart';
import 'package:dolores_turismo/dominio/geo.dart';
import 'package:dolores_turismo/dominio/hito.dart';
import 'package:dolores_turismo/dominio/pasaporte.dart';

void main() {
  group('Lógica de Negocio del Pasaporte Turístico', () {
    const hitoPrueba = HitoTuristico(
      id: 'test_id',
      nombre: 'Lugar de Prueba',
      descripcion: '...',
      ubicacion: Coordenada(21.1570, -100.9320),
      modelo3dId: 'null',
    );

    test('Rechaza el sellado si la distancia excede el umbral tolerado', () {
      final pasaporte = Pasaporte();
      final posicionLejana = const Coordenada(21.1650, -100.9320); 

      final exito = pasaporte.estamparSello(hitoPrueba, posicionLejana);

      expect(exito, isFalse);
      expect(pasaporte.tieneSello('test_id'), isFalse);
    });

    test('Permite el sellado si el usuario está físicamente sobre el hito', () {
      final pasaporte = Pasaporte();
      final posicionCercana = const Coordenada(21.15701, -100.93201); 

      final exito = pasaporte.estamparSello(hitoPrueba, posicionCercana);

      expect(exito, isTrue);
      expect(pasaporte.tieneSello('test_id'), isTrue);
    });
  });
}