import 'package:flutter/material.dart';
import 'datos/hito_repositorio.dart';
import 'datos/pasaporte_local.dart';
import 'datos/simulador_hardware.dart';
import 'presentacion/turismo_viewmodel.dart';
import 'presentacion/pantalla_mapa_ar.dart';
import 'presentacion/pantalla_pasaporte.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final vm = TurismoViewModel(
    hitoRepo: HitoRepositorio(),
    pasaporteLocal: PasaporteLocal(),
    simulador: SimuladorHardware(),
  );

  await vm.inicializarApp();

  runApp(MainApp(viewModel: vm));
}

class MainApp extends StatelessWidget {
  final TurismoViewModel viewModel;
  const MainApp({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dolores AR',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.amber),
      home: _NavegacionBase(model: viewModel),
    );
  }
}

class _NavegacionBase extends StatefulWidget {
  final TurismoViewModel model;
  const _NavegacionBase({required this.model});

  @override
  State<_NavegacionBase> createState() => _NavegacionBaseState();
}

class _NavegacionBaseState extends State<_NavegacionBase> {
  int _indiceActual = 0;

  @override
  Widget build(BuildContext context) {
    final paginas = [
      PantallaMapaAR(model: widget.model),
      PantallaPasaporte(model: widget.model),
    ];

    return Scaffold(
      body: paginas[_indiceActual],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indiceActual,
        onDestinationSelected: (idx) => setState(() => _indiceActual = idx),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.photo_camera), label: 'Visor AR'),
          NavigationDestination(icon: Icon(Icons.wallet_membership), label: 'Pasaporte'),
        ],
      ),
    );
  }
}