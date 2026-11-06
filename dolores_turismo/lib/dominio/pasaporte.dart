import 'geo.dart';
import 'hito.dart';

class Sello {
  final String hitoId;
  final DateTime fechaVisita;
  const Sello({required this.hitoId, required this.fechaVisita});
}

class Pasaporte {
  final Map<String, Sello> _sellos = {};
  static const double radioValidacionMetros = 20.0;

  Map<String, Sello> get sellos => Map.unmodifiable(_sellos);

  bool tieneSello(String hitoId) => _sellos.containsKey(hitoId);

  bool estamparSello(HitoTuristico hito, Coordenada posicionUsuario) {
    if (_sellos.containsKey(hito.id)) return false;
    
    final distancia = calcularDistancia(posicionUsuario, hito.ubicacion);
    if (distancia <= radioValidacionMetros) {
      _sellos[hito.id] = Sello(hitoId: hito.id, fechaVisita: DateTime.now());
      return true;
    }
    return false;
  }

  void inyectarSelloHistorico(String hitoId, DateTime fecha) {
    _sellos[hitoId] = Sello(hitoId: hitoId, fechaVisita: fecha);
  }
}