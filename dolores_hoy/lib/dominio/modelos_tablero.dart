class ModeloClima {
  final double temperatura;
  final String condicion;
  const ModeloClima({required this.temperatura, required this.condicion});
}

class ModeloFinanciero {
  final double tipoCambioUsd;
  final String base;
  const ModeloFinanciero({required this.tipoCambioUsd, required this.base});
}

class ModeloEfemeride {
  final String titulo;
  final String extracto;
  const ModeloEfemeride({required this.titulo, required this.extracto});
}

class ModeloNasa {
  final String urlImagen;
  final String explicacion;
  const ModeloNasa({required this.urlImagen, required this.explicacion});
}

class ModeloDatosTablero {
  final ModeloClima? clima;
  final ModeloFinanciero? finanzas;
  final List<String>? diasFestivos;
  final ModeloEfemeride? efemeride;
  final ModeloNasa? nasa;

  const ModeloDatosTablero({
    this.clima,
    this.finanzas,
    this.diasFestivos,
    this.efemeride,
    this.nasa,
  });

  bool get esVacio => clima == null && finanzas == null && diasFestivos == null && efemeride == null && nasa == null;
  bool get tieneErroresParciales => clima == null || finanzas == null || diasFestivos == null || efemeride == null || nasa == null;
}