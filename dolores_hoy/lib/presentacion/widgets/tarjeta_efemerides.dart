import 'package:flutter/material.dart';
import '../../dominio/modelos_tablero.dart';

class TarjetaEfemerides extends StatelessWidget {
  final ModeloEfemeride? datos;
  final List<String>? festivos;

  const TarjetaEfemerides({super.key, required this.datos, required this.festivos});

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
                Icon(Icons.history_edu, color: Colors.brown),
                SizedBox(width: 8),
                Text('Historia & Próximos Asuetos', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(),
            if (datos != null) ...[
              Text(datos!.titulo, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
              Text(datos!.extracto, maxLines: 4, overflow: TextOverflow.ellipsis),
            ],
            const SizedBox(height: 12),
            const Text('Próximos Días Festivos Nacionales:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            if (festivos != null)
              ...festivos!.map((f) => Text('• $f', style: const TextStyle(fontSize: 12)))
            else
              const Text('Error al cargar agenda nacional.', style: TextStyle(color: Colors.red, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}