class Environment {
  static String versionApp = '1.0.1+11';
  static String nombreApp = 'HorsePower';
  static String dataOk = 'Ok';
  static String dataNOk = 'NOk';
  static String dataInexistente = 'inexistente';
  static String inStatus = 'status';
  static String msgStatus = 'msgStatus';
  static String destinoImagen = 'destinoImagen';
  static String literarIdColeccionIsar = 'idMVC';
  static String urlLogo = 'assets/logo.png';
  static String logoMiniatura = 'assets/logo.png';
  static String baseUrlCargaUsuarios = '';

  //Auth
  static String blocOnLoginAuth = 'blocOnLoginAuth';
  static String blocOnValidaDatosGuardadosAuth = 'blocOnValidaDatosGuardadosAuth';
  static String blocOnLogOutAuth = 'blocOnLogOutAuth';

  ///Casos
  static String blocOnObtieneCasos = 'OnObtieneCasos';
  static String blocOnNuevoCaso = 'OnNuevoCaso';
  static String blocOnModificaCaso = 'OnModificaCaso';
  static String blocOnValidarCaso = 'OnValidarCaso';
  static String blocOnGuardaCaso = 'OnGuardaCaso';
  static String blocOnEventoUiCaso = 'OnEventoUiCaso';
  static String blocOnGuardaSeleccionFiltro = 'OnGuardaSeleccionFiltro';

  ///Categorias
  static String blocOnObtieneCategorias = 'OnObtieneCategorias';
  static String blocOnNuevoCategoria = 'OnNuevoCategoria';
  static String blocOnModificaCategoria = 'OnModificaCategoria';
  static String blocOnValidarCategoria = 'OnValidarCategoria';
  static String blocOnGuardaCategoria = 'OnGuardaCategoria';

  ///Historial
  static String blocOnObtieneHistoriales = 'OnObtieneHistoriales';
  static String blocOnNuevoHistorial = 'OnNuevoHistorial';
  static String blocOnModificaHistorial = 'OnModificaHistorial';
  static String blocOnValidarHistorial = 'OnValidarHistorial';
  static String blocOnGuardaHistorial = 'OnGuardaHistorial';

  ///Cliente
  static String blocOnObtieneClientes = 'OnObtieneClientes';
  static String blocOnNuevoCliente = 'OnNuevoCliente';
  static String blocOnModificaCliente = 'OnModificaCliente';
  static String blocOnValidarCliente = 'OnValidarCliente';
  static String blocOnGuardaCliente = 'OnGuardaCliente';
  static String blocOnActualizaUsuarios = 'OnActualizaUsuarios';
  static String blocOnSeleccionaCliente = 'OnSeleccionaCliente';

  ///Usuario
  static String blocOnObtieneUsuarios = 'OnObtieneUsuarios';
  static String blocOnNuevoUsuario = 'OnNuevoUsuario';
  static String blocOnModificaUsuario = 'OnModificaUsuario';
  static String blocOnValidarUsuario = 'OnValidarUsuario';
  static String blocOnGuardaUsuario = 'OnGuardaUsuario';

  ///Nombre de las tablas
  static const String usuario = 'Usuario';
  static const String cliente = 'Cliente';
  static const String tecnico = 'Tecnico';
  static const String categoria = 'Categoria';
  static const String caballo = 'Caballo';

  static String errorHttp = 'http_error';
  static String status = 'status';

  static int cantRegistroPorPagina = 50;
}

enum TablaFirebase {
  usuario('Usuario');

  final String valor;
  const TablaFirebase(this.valor);

  @override
  String toString() => valor;
}

enum EstadoCaso {
  activo('A', 'Activo'),
  cancelado('N', 'Cancelado'),
  cerrado('C', 'Cerrado');

  final String valor;
  final String descripcion;
  const EstadoCaso(this.valor, this.descripcion);

  @override
  String toString() => valor;
}

enum EstadoRegistro {
  activo('A', 'Activo'),
  inactivo('I', 'Inactivo');

  final String valor;
  final String descripcion;
  const EstadoRegistro(this.valor, this.descripcion);

  @override
  String toString() => valor;
}

List<String> lstNomImagenes = ['Frente', 'Flanco izq', 'Flanco der', 'Dientes', 'Cuartos', 'Sexto', 'Septimo'];
