import 'package:flutter/material.dart';
import 'turismo_viewmodel.dart';

class PantallaPasaporte extends StatelessWidget {
  final TurismoViewModel model;
  const PantallaPasaporte({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi Pasaporte Dolorense')),
      body: ListenableBuilder(
        listenable: model,
        builder: (context, child) {
          return ListView.builder(
            itemCount: model.hitos.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final hito = model.hitos[index];
              final visitado = model.pasaporte.tieneSello(hito.id);

              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 12),
                color: visitado ? Colors.green.shade50 : Colors.grey.shade100,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: visitado ? Colors.green : Colors.grey,
                    child: Icon(visitado ? Icons.workspace_premium : Icons.lock_outline, color: Colors.white),
                  ),
                  title: Text(hito.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(hito.descripcion),
                  trailing: Text(
                    visitado ? 'SELLADO' : 'PENDIENTE',
                    style: TextStyle(
                      color: visitado ? Colors.green.shade700 : Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}