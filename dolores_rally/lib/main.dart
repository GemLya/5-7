import 'dart:math';
import 'package:flutter/material.dart';
import 'datos/almacen_prefs.dart';
import 'datos/fuentes_reales.dart';
import 'dominio/catalogo.dart';
import 'presentacion/pantalla_rally.dart';
import 'presentacion/rally_viewmodel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    title: 'Rally de la Independencia AR',
    home: HomeRally(),
  ));
}

class HomeRally extends StatelessWidget {
  const HomeRally({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rally AR')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PantallaRally(
            crearVm: () => RallyViewModel(
              posicion: PosicionGps(),
              brujula: BrujulaReal(),
              almacen: AlmacenPrefs(),
              personajes: personajes,
              centro: plazaPrincipal,
              random: Random(),
            ),
          ))),
          child: const Text('Comenzar Rally'),
        ),
      ),
    );
  }
}