import 'package:flutter/material.dart';
import '../../dominio/modelos_tablero.dart';

class TarjetaNasa extends StatelessWidget {
  final ModeloNasa? datos;
  const TarjetaNasa({super.key, required this.datos});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            backgroundColor: Colors.deepSpace,
            title: const Text('NASA - Imagen Cósmica de Hoy', style: TextStyle(color: Colors.white, fontSize: 14)),
            leading: const Icon(Icons.rocket_launch, color: Colors.cyanAccent),
            primary: false,
          ),
          if (datos != null) ...[
            Image.network(
              datos!.urlImagen,
              fit: BoxFit.cover,
              height: 180,
              width: double.infinity,
              errorBuilder: (_, __, ___) => Container(
                height: 100,
                color: Colors.black26,
                child: const Center(child: Text('Formato multimedia espacial no renderizable.')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(datos!.explicacion, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11)),
            )
          ] else
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Fallo de respuesta del API Gateway de NASA APOD.', style: TextStyle(color: Colors.red)),
            ),
        ],
      ),
    );
  }
}

extension on Colors {
  static Color get deepSpace => const Color(0xFF0B3D91);
}