import 'package:flutter_test/flutter_test.dart';
import 'package:dolores_hoy/dominio/cache_politica.dart';

void main() {
  group('Controlador de Expiración TTL de Datos', () {
    test('Valida correctamente registros dentro de la ventana de tiempo', () {
      const politica = CachePolitica(ttl: Duration(minutes: 5));
      final momentoValido = DateTime.now().subtract(const Duration(minutes: 2));

      expect(politica.esValido(momentoValido), isTrue);
    });

    test('Invalida registros que exceden el tiempo de vida máximo', () {
      const politica = CachePolitica(ttl: Duration(minutes: 5));
      final momentoExpirado = DateTime.now().subtract(const Duration(minutes: 6));

      expect(politica.esValido(momentoExpirado), isFalse);
    });
  });
}