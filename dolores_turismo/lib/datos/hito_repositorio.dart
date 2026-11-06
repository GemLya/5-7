import '../dominio/geo.dart';
import '../dominio/hito.dart';

class HitoRepositorio {
  static const Coordenada parroquiaUbicacion = Coordenada(21.1573, -100.9325);

  List<HitoTuristico> obtenerHitos() {
    return [
      const HitoTuristico(
        id: 'parroquia_dolores',
        nombre: 'Parroquia de Ntra. Sra. de los Dolores',
        descripcion: 'Lugar histórico donde se dio el Grito de la Independencia en 1810.',
        ubicacion: parroquiaUbicacion,
        modelo3dId: 'campana_independencia',
      ),
      HitoTuristico(
        id: 'museo_hidalgo',
        nombre: 'Museo Casa de Hidalgo',
        descripcion: 'La antigua morada del cura Miguel Hidalgo y Costilla.',
        ubicacion: desplazarPunto(parroquiaUbicacion, 90, 120), 
        modelo3dId: 'casa_colonial',
      ),
      HitoTuristico(
        id: 'monumento_hidalgo',
        nombre: 'Monumento a Hidalgo',
        descripcion: 'Estatua erigida en honor al Padre de la Patria en el centro de la plaza.',
        ubicacion: desplazarPunto(parroquiaUbicacion, 180, 70),
        modelo3dId: 'estatua_hidalgo',
      ),
    ];
  }
}