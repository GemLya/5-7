import 'package:flutter/material.dart';
import '../../dominio/modelos_tablero.dart';

class TarjetaMeteo extends StatelessWidget {
  final ModeloClima? datos;
  const TarjetaMeteo({super.key, required this.datos});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.wb_sunny, color: Colors.orange),
                SizedBox(width: 8),
                Text('Clima actual en Dolores Gto.', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(),
            if (datos != null) ...[
              Text('${datos!.temperatura} °C', style: Theme.of(context).textTheme.headlineMedium),
              Text(datos!.condicion, style: const TextStyle(color: Colors.grey)),
            ] else
              const Text('Servicio Meteorológico temporalmente fuera de línea.', style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}