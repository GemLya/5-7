import 'package:flutter/material.dart';
import 'tablero_viewmodel.dart';
import 'widgets/tarjeta_meteo.dart';
import 'widgets/tarjeta_financiera.dart';
import 'widgets/tarjeta_efemerides.dart';
import 'widgets/tarjeta_nasa.dart';

class PantallaTablero extends StatelessWidget {
  final TableroViewModel model;
  const PantallaTablero({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dolores Hoy - Panel Ejecutivo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => model.cargarInformacionTablero(),
          )
        ],
      ),
      body: ListenableBuilder(
        listenable: model,
        builder: (context, child) {
          if (model.estado == EstadoTablero.cargando) {
            return const Center(child: CircularProgressIndicator());
          }

          if (model.estado == EstadoTablero.errorTotal) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.gpp_bad, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(model.mensajeErrorGlobal, textAlign: TextAlign.center),
                    ElevatedButton(
                      onPressed: () => model.cargarInformacionTablero(),
                      child: const Text('Reintentar'),
                    )
                  ],
                ),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(12),
            children: [
              if (model.estado == EstadoTablero.errorParcial)
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.bottom(12),
                  decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(8)),
                  child: const Row(
                    children: [
                      Icon(Icons.warning, color: Colors.orangeAccent),
                      SizedBox(width: 8),
                      Expanded(child: Text('Conexión inestable: Algunos módulos muestran datos degradados.', style: TextStyle(fontSize: 12))),
                    ],
                  ),
                ),
              TarjetaMeteo(datos: model.datos.clima),
              TarjetaFinanciera(datos: model.datos.finanzas),
              TarjetaEfemerides(datos: model.datos.efemeride, festivos: model.datos.diasFestivos),
              TarjetaNasa(datos: model.datos.nasa),
            ],
          );
        },
      ),
    );
  }
}