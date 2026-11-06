import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'datos/api_cliente.dart';
import 'presentacion/tablero_viewmodel.dart';
import 'presentacion/pantalla_tablero.dart';

void main() {
  final clienteHttp = http.Client();
  final apiCliente = ApiCliente(cliente: clienteHttp);
  
  final viewModel = TableroViewModel(api: apiCliente);
  viewModel.cargarInformacionTablero();

  runApp(AppTablero(model: viewModel));
}

class AppTablero extends StatelessWidget {
  final TableroViewModel model;
  const AppTablero({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dolores Hoy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: PantallaTablero(model: model),
    );
  }
}