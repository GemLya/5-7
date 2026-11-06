import 'package:flutter/material.dart';
import 'widgets/camara_ar_render.dart';
import 'widgets/canvas_brujula.dart';
import 'widgets/item_hito.dart';
import 'turismo_viewmodel.dart';

class PantallaMapaAR extends StatelessWidget {
  final TurismoViewModel model;
  const PantallaMapaAR({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: model,
        builder: (context, child) {
          return Stack(
            fit: StackFit.expand,
            children: [
              const CamaraArRender(),
              ...model.elementosVisibles.map((elemento) {
                final hito = model.hitos.firstWhere((h) => h.id == elemento.id);
                final anchoPantalla = MediaQuery.of(context).size.width;
                final posicionX = (anchoPantalla / 2) + (elemento.xRelativo * (anchoPantalla / 2)) - 50;

                return Positioned(
                  left: posicionX,
                  top: MediaQuery.of(context).size.height * 0.4,
                  child: GestureDetector(
                    onTap: () async {
                      final exito = await model.intentarEstamparSello(hito);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(exito 
                              ? '¡Sello estampado en tu Pasaporte: ${hito.nombre}!' 
                              : 'Muy lejos para estampar o ya tienes el sello.'),
                          ),
                        );
                      }
                    },
                    child: ItemHitoAR(nombre: hito.nombre, escala: elemento.escala),
                  ),
                );
              }),
              Positioned(
                top: 40,
                left: 20,
                child: CanvasBrujula(rumbo: model.rumboUsuario),
              ),
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: _ControlesSimuladorPanel(model: model),
              )
            ],
          );
        },
      ),
    );
  }
}

class _ControlesSimuladorPanel extends StatelessWidget {
  final TurismoViewModel model;
  const _ControlesSimuladorPanel({required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.black80, borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Controles del Simulador de Campo', style: TextStyle(color: Colors.white70, fontSize: 11)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => model.simulador.cambiarRumbo(model.rumboUsuario - 15),
              ),
              ElevatedButton.icon(
                label: const Text('Avanzar'),
                icon: const Icon(Icons.navigation, size: 16),
                onPressed: () => model.simulador.moverPasos(model.rumboUsuario, 5.0),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                onPressed: () => model.simulador.cambiarRumbo(model.rumboUsuario + 15),
              ),
            ],
          ),
        ],
      ),
    );
  }
}