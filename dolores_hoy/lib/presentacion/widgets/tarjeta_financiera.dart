import 'package:flutter/material.dart';
import '../../dominio/modelos_tablero.dart';

class TarjetaFinanciera extends StatelessWidget {
  final ModeloFinanciero? datos;
  const TarjetaFinanciera({super.key, required this.datos});

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
                Icon(Icons.monetization_on, color: Colors.green),
                SizedBox(width: 8),
                Text('Divisas & Finanzas de Mercado', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(),
            if (datos != null)
              Text('1 ${datos!.base} = \$${datos!.tipoCambioUsd.toStringAsFixed(2)} MXN', 
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
            else
              const Text('Tipo de cambio no disponible por el momento.', style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}