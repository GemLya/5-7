import 'package:dolores_rally/dominio/geo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'ayudas.dart';

void main() {
  group('Geodesia - Pruebas directas e inversas', () {
    test('Ida y vuelta conserva las magnitudes métricas', () {
      for (final r in [0.0, 90.0, 180.0, 270.0]) {
        final dest = destino(origen, r, 250);
        expect(distanciaMetros(origen, dest), closeTo(250, 0.05));
        expect(diferenciaAngular(rumboGrados(origen, dest), r).abs(), lessThan(0.05));
      }
    });
  });
}