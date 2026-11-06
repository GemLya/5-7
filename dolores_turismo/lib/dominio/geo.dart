import 'dart:math' as math;

class Coordenada {
  final double lat;
  final double lon;
  const Coordenada(this.lat, this.lon);
}

const double radioTierra = 6371000.0;

double aRadianes(double grados) => grados * math.pi / 180;
double aGrados(double rad) => rad * 180 / math.pi;

double calcularDistancia(Coordenada p1, Coordenada p2) {
  final dLat = aRadianes(p2.lat - p1.lat);
  final dLon = aRadianes(p2.lon - p1.lon);
  final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(aRadianes(p1.lat)) * math.cos(aRadianes(p2.lat)) *
      math.sin(dLon / 2) * math.sin(dLon / 2);
  final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  return radioTierra * c;
}

double calcularRumbo(Coordenada p1, Coordenada p2) {
  final lon1 = aRadianes(p1.lon);
  final lon2 = aRadianes(p2.lon);
  final lat1 = aRadianes(p1.lat);
  final lat2 = aRadianes(p2.lat);

  final dLon = lon2 - lon1;
  final y = math.sin(dLon) * math.cos(lat2);
  final x = math.cos(lat1) * math.sin(lat2) -
      math.sin(lat1) * math.cos(lat2) * math.cos(dLon);

  final rumbo = aGrados(math.atan2(y, x));
  return (rumbo + 360) % 360;
}

Coordenada desplazarPunto(Coordenada origen, double rumbo, double metros) {
  final d = metros / radioTierra;
  final r = aRadianes(rumbo);
  final lat1 = aRadianes(origen.lat);
  final lon1 = aRadianes(origen.lon);

  final lat2 = math.asin(math.sin(lat1) * math.cos(d) +
      math.cos(lat1) * math.sin(d) * math.cos(r));
  final lon2 = lon1 + math.atan2(math.sin(r) * math.sin(d) * math.cos(lat1),
      math.cos(d) - math.sin(lat1) * math.sin(lat2));

  return Coordenada(aGrados(lat2), aGrados(lon2));
}