part of 'text_widget.dart';

bool condicion(Color? color1, Color? color2) {
  return (color1 == null) == (color2 == null);
}

class _TextSmallWidget extends TextWidget {
  _TextSmallWidget(
      {required String texto,
      Color? colorTextoLight,
      Color? colorTextoDark,
      FontWeight? tipoFuente,
      int? maxlineas,
      TextAlign? textAling,
      TextOverflow? overflow = TextOverflow.ellipsis,
      bool? ocultarTexto = false,
      TextDecoration? decoration})
      : assert(condicion(colorTextoLight, colorTextoDark), 'Debe ingresar ambos colores'),
        super(
          child: _TextSmall(
              texto: texto,
              maxlineas: maxlineas,
              ocultarTexto: ocultarTexto,
              overflow: overflow,
              textAlign: textAling,
              colorTextoLight: colorTextoLight,
              colorTextoDark: colorTextoDark,
              decoration: decoration,
              tipoFuente: tipoFuente),
        );
}

class _TextSmall extends StatelessWidget {
  const _TextSmall({
    required this.ocultarTexto,
    required this.texto,
    required this.overflow,
    required this.textAlign,
    required this.maxlineas,
    required this.tipoFuente,
    this.colorTextoLight,
    this.colorTextoDark,
    this.decoration,
  });
  final bool? ocultarTexto;
  final String? texto;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int? maxlineas;
  final Color? colorTextoLight;
  final Color? colorTextoDark;
  final FontWeight? tipoFuente;
  final TextDecoration? decoration;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    //bool isDarkMode = context.read<MenuBloc>().state.theme == ThemeMode.dark;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        ((ocultarTexto ?? false) ? '***************' : texto) ?? '',
        maxLines: maxlineas,
        overflow: overflow,
        textAlign: textAlign,
        style: theme.textTheme.bodySmall!.copyWith(
            decoration: decoration,
            color: colorTextoDark, //isDarkMode ? colorTextoLight : colorTextoDark,
            fontWeight: tipoFuente),
      ),
    );
  }
}

class _TextMediumWidget extends TextWidget {
  _TextMediumWidget(
      {required String texto,
      Color? colorTextoLight,
      Color? colorTextoDark,
      FontWeight? tipoFuente,
      int? maxlineas,
      TextAlign? textAling,
      TextOverflow? overflow = TextOverflow.ellipsis,
      bool? ocultarTexto = false,
      TextDecoration? decoration})
      : assert(condicion(colorTextoLight, colorTextoDark), 'Debe ingresar ambos colores'),
        super(
          child: _TextMedium(
              texto: texto,
              maxlineas: maxlineas,
              ocultarTexto: ocultarTexto,
              overflow: overflow,
              textAlign: textAling,
              colorTextoLight: colorTextoLight,
              colorTextoDark: colorTextoDark,
              decoration: decoration,
              tipoFuente: tipoFuente),
        );
}

class _TextMedium extends StatelessWidget {
  const _TextMedium({
    required this.ocultarTexto,
    required this.texto,
    required this.overflow,
    required this.textAlign,
    required this.maxlineas,
    required this.tipoFuente,
    this.colorTextoLight,
    this.colorTextoDark,
    this.decoration,
  });
  final bool? ocultarTexto;
  final String? texto;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int? maxlineas;
  final Color? colorTextoLight;
  final Color? colorTextoDark;
  final FontWeight? tipoFuente;
  final TextDecoration? decoration;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    //bool isDarkMode = context.read<MenuBloc>().state.theme == ThemeMode.dark;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        ((ocultarTexto ?? false) ? '***************' : texto) ?? '',
        maxLines: maxlineas,
        overflow: overflow,
        textAlign: textAlign,
        style: theme.textTheme.bodyMedium!.copyWith(
            decoration: decoration,
            color: colorTextoDark, //isDarkMode ? colorTextoLight : colorTextoDark,
            fontWeight: tipoFuente),
      ),
    );
  }
}

class _TextLargeWidget extends TextWidget {
  _TextLargeWidget(
      {required String texto,
      Color? colorTextoLight,
      Color? colorTextoDark,
      FontWeight? tipoFuente,
      int? maxlineas,
      TextAlign? textAling,
      TextOverflow? overflow = TextOverflow.ellipsis,
      bool? ocultarTexto = false,
      TextDecoration? decoration})
      : assert(condicion(colorTextoLight, colorTextoDark), 'Debe ingresar ambos colores'),
        super(
          child: _TextLarge(
              texto: texto,
              maxlineas: maxlineas,
              ocultarTexto: ocultarTexto,
              overflow: overflow,
              textAlign: textAling,
              colorTextoLight: colorTextoLight,
              colorTextoDark: colorTextoDark,
              decoration: decoration,
              tipoFuente: tipoFuente),
        );
}

class _TextLarge extends StatelessWidget {
  const _TextLarge({
    required this.ocultarTexto,
    required this.texto,
    required this.overflow,
    required this.textAlign,
    required this.maxlineas,
    required this.tipoFuente,
    this.colorTextoLight,
    this.colorTextoDark,
    this.decoration,
  });
  final bool? ocultarTexto;
  final String? texto;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int? maxlineas;
  final Color? colorTextoLight;
  final Color? colorTextoDark;
  final FontWeight? tipoFuente;
  final TextDecoration? decoration;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    //bool isDarkMode = context.read<MenuBloc>().state.theme == ThemeMode.dark;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        ((ocultarTexto ?? false) ? '***************' : texto) ?? '',
        maxLines: maxlineas,
        overflow: overflow,
        textAlign: textAlign,
        style: theme.textTheme.bodyLarge!.copyWith(
          decoration: decoration,
          color: colorTextoDark, //isDarkMode ? colorTextoLight : colorTextoDark,
          fontWeight: tipoFuente,
        ),
      ),
    );
  }
}

class _TitleSmallWidget extends TextWidget {
  _TitleSmallWidget(
      {required String texto,
      Color? colorTextoLight,
      Color? colorTextoDark,
      FontWeight? tipoFuente,
      int? maxlineas,
      TextAlign? textAling,
      TextOverflow? overflow = TextOverflow.ellipsis,
      bool? ocultarTexto = false,
      TextDecoration? decoration})
      : assert(condicion(colorTextoLight, colorTextoDark), 'Debe ingresar ambos colores'),
        super(
          child: _TitleSmall(
              texto: texto,
              maxlineas: maxlineas,
              ocultarTexto: ocultarTexto,
              overflow: overflow,
              textAlign: textAling,
              colorTextoLight: colorTextoLight,
              colorTextoDark: colorTextoDark,
              decoration: decoration,
              tipoFuente: tipoFuente),
        );
}

class _TitleSmall extends StatelessWidget {
  const _TitleSmall({
    required this.ocultarTexto,
    required this.texto,
    required this.overflow,
    required this.textAlign,
    required this.maxlineas,
    required this.tipoFuente,
    this.colorTextoLight,
    this.colorTextoDark,
    this.decoration,
  });
  final bool? ocultarTexto;
  final String? texto;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int? maxlineas;
  final Color? colorTextoLight;
  final Color? colorTextoDark;
  final FontWeight? tipoFuente;
  final TextDecoration? decoration;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    //bool isDarkMode = context.read<MenuBloc>().state.theme == ThemeMode.dark;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        ((ocultarTexto ?? false) ? '***************' : texto) ?? '',
        maxLines: maxlineas,
        overflow: overflow,
        textAlign: textAlign,
        style: theme.textTheme.titleSmall!.copyWith(
            decoration: decoration,
            color: colorTextoDark, //isDarkMode ? colorTextoLight : colorTextoDark,
            fontWeight: tipoFuente),
      ),
    );
  }
}

class _TitleMediumWidget extends TextWidget {
  _TitleMediumWidget(
      {required String texto,
      Color? colorTextoLight,
      Color? colorTextoDark,
      FontWeight? tipoFuente,
      int? maxlineas,
      TextAlign? textAling,
      TextOverflow? overflow = TextOverflow.ellipsis,
      bool? ocultarTexto = false,
      TextDecoration? decoration})
      : assert(condicion(colorTextoLight, colorTextoDark), 'Debe ingresar ambos colores'),
        super(
          child: _TitleMedium(
              texto: texto,
              maxlineas: maxlineas,
              ocultarTexto: ocultarTexto,
              overflow: overflow,
              textAlign: textAling,
              colorTextoLight: colorTextoLight,
              colorTextoDark: colorTextoDark,
              decoration: decoration,
              tipoFuente: tipoFuente),
        );
}

class _TitleMedium extends StatelessWidget {
  const _TitleMedium({
    required this.ocultarTexto,
    required this.texto,
    required this.overflow,
    required this.textAlign,
    required this.maxlineas,
    required this.tipoFuente,
    this.colorTextoLight,
    this.colorTextoDark,
    this.decoration,
  });
  final bool? ocultarTexto;
  final String? texto;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int? maxlineas;
  final Color? colorTextoLight;
  final Color? colorTextoDark;
  final FontWeight? tipoFuente;
  final TextDecoration? decoration;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    //bool isDarkMode = context.read<MenuBloc>().state.theme == ThemeMode.dark;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        ((ocultarTexto ?? false) ? '***************' : texto) ?? '',
        maxLines: maxlineas,
        overflow: overflow,
        textAlign: textAlign,
        style: theme.textTheme.titleMedium!.copyWith(
            decoration: decoration,
            color: colorTextoDark, //isDarkMode ? colorTextoLight : colorTextoDark,
            fontWeight: tipoFuente),
      ),
    );
  }
}

class _TitleLargeWidget extends TextWidget {
  _TitleLargeWidget(
      {required String texto,
      Color? colorTextoLight,
      Color? colorTextoDark,
      FontWeight? tipoFuente,
      int? maxlineas = 2,
      TextAlign? textAling,
      TextOverflow? overflow = TextOverflow.ellipsis,
      bool? ocultarTexto = false,
      TextDecoration? decoration})
      : assert(condicion(colorTextoLight, colorTextoDark), 'Debe ingresar ambos colores'),
        super(
          child: _TitleLarge(
              texto: texto,
              maxlineas: maxlineas,
              ocultarTexto: ocultarTexto,
              overflow: overflow,
              textAlign: textAling,
              colorTextoLight: colorTextoLight,
              colorTextoDark: colorTextoDark,
              decoration: decoration,
              tipoFuente: tipoFuente),
        );
}

class _TitleLarge extends StatelessWidget {
  const _TitleLarge({
    required this.ocultarTexto,
    required this.texto,
    required this.overflow,
    required this.textAlign,
    required this.maxlineas,
    required this.tipoFuente,
    this.colorTextoLight,
    this.colorTextoDark,
    this.decoration,
  });
  final bool? ocultarTexto;
  final String? texto;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int? maxlineas;
  final Color? colorTextoLight;
  final Color? colorTextoDark;
  final FontWeight? tipoFuente;
  final TextDecoration? decoration;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    //bool isDarkMode = context.read<MenuBloc>().state.theme == ThemeMode.dark;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        ((ocultarTexto ?? false) ? '***************' : texto) ?? '',
        maxLines: maxlineas,
        overflow: overflow,
        textAlign: textAlign,
        style: theme.textTheme.titleLarge!.copyWith(
            decoration: decoration,
            color: colorTextoDark, //isDarkMode ? colorTextoLight : colorTextoDark,
            fontWeight: tipoFuente),
      ),
    );
  }
}

class _HeadLineSmallWidget extends TextWidget {
  _HeadLineSmallWidget(
      {required String texto,
      Color? colorTextoLight,
      Color? colorTextoDark,
      FontWeight? tipoFuente,
      int? maxlineas,
      TextAlign? textAling,
      TextOverflow? overflow = TextOverflow.ellipsis,
      bool? ocultarTexto = false,
      TextDecoration? decoration})
      : assert(condicion(colorTextoLight, colorTextoDark), 'Debe ingresar ambos colores'),
        super(
          child: _HeadLineSmall(
              texto: texto,
              maxlineas: maxlineas,
              ocultarTexto: ocultarTexto,
              overflow: overflow,
              textAlign: textAling,
              colorTextoLight: colorTextoLight,
              colorTextoDark: colorTextoDark,
              decoration: decoration,
              tipoFuente: tipoFuente),
        );
}

class _HeadLineSmall extends StatelessWidget {
  const _HeadLineSmall({
    required this.ocultarTexto,
    required this.texto,
    required this.overflow,
    required this.textAlign,
    required this.maxlineas,
    required this.tipoFuente,
    this.colorTextoLight,
    this.colorTextoDark,
    this.decoration,
  });
  final bool? ocultarTexto;
  final String? texto;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int? maxlineas;
  final Color? colorTextoLight;
  final Color? colorTextoDark;
  final FontWeight? tipoFuente;
  final TextDecoration? decoration;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    //bool isDarkMode = context.read<MenuBloc>().state.theme == ThemeMode.dark;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        ((ocultarTexto ?? false) ? '***************' : texto) ?? '',
        maxLines: maxlineas,
        overflow: overflow,
        textAlign: textAlign,
        style: theme.textTheme.headlineSmall!.copyWith(
            decoration: decoration,
            color: colorTextoDark, //isDarkMode ? colorTextoLight : colorTextoDark,
            fontWeight: tipoFuente),
      ),
    );
  }
}

class _HeadLineMediumWidget extends TextWidget {
  _HeadLineMediumWidget(
      {required String texto,
      Color? colorTextoLight,
      Color? colorTextoDark,
      FontWeight? tipoFuente,
      int? maxlineas,
      TextAlign? textAling,
      TextOverflow? overflow = TextOverflow.ellipsis,
      bool? ocultarTexto = false,
      TextDecoration? decoration})
      : assert(condicion(colorTextoLight, colorTextoDark), 'Debe ingresar ambos colores'),
        super(
          child: _HeadLineMedium(
              texto: texto,
              maxlineas: maxlineas,
              ocultarTexto: ocultarTexto,
              overflow: overflow,
              textAlign: textAling,
              colorTextoLight: colorTextoLight,
              colorTextoDark: colorTextoDark,
              decoration: decoration,
              tipoFuente: tipoFuente),
        );
}

class _HeadLineMedium extends StatelessWidget {
  const _HeadLineMedium({
    required this.ocultarTexto,
    required this.texto,
    required this.overflow,
    required this.textAlign,
    required this.maxlineas,
    required this.tipoFuente,
    this.colorTextoLight,
    this.colorTextoDark,
    this.decoration,
  });
  final bool? ocultarTexto;
  final String? texto;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int? maxlineas;
  final Color? colorTextoLight;
  final Color? colorTextoDark;
  final FontWeight? tipoFuente;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    //bool isDarkMode = context.read<MenuBloc>().state.theme == ThemeMode.dark;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        ((ocultarTexto ?? false) ? '***************' : texto) ?? '',
        maxLines: maxlineas,
        overflow: overflow,
        textAlign: textAlign,
        style: theme.textTheme.headlineMedium!.copyWith(
            decoration: decoration,
            color: colorTextoDark, //isDarkMode ? colorTextoLight : colorTextoDark,
            fontWeight: tipoFuente),
      ),
    );
  }
}

class _HeadLineLargeWidget extends TextWidget {
  _HeadLineLargeWidget(
      {required String texto,
      Color? colorTextoLight,
      Color? colorTextoDark,
      FontWeight? tipoFuente,
      int? maxlineas,
      TextAlign? textAling,
      TextOverflow? overflow = TextOverflow.ellipsis,
      bool? ocultarTexto = false,
      TextDecoration? decoration})
      : assert(condicion(colorTextoLight, colorTextoDark), 'Debe ingresar ambos colores'),
        super(
          child: _HeadLineLarge(
              texto: texto,
              maxlineas: maxlineas,
              ocultarTexto: ocultarTexto,
              overflow: overflow,
              textAlign: textAling,
              colorTextoLight: colorTextoLight,
              colorTextoDark: colorTextoDark,
              decoration: decoration,
              tipoFuente: tipoFuente),
        );
}

class _HeadLineLarge extends StatelessWidget {
  const _HeadLineLarge({
    required this.ocultarTexto,
    required this.texto,
    required this.overflow,
    required this.textAlign,
    required this.maxlineas,
    required this.tipoFuente,
    this.colorTextoLight,
    this.colorTextoDark,
    this.decoration,
  });
  final bool? ocultarTexto;
  final String? texto;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int? maxlineas;
  final Color? colorTextoLight;
  final Color? colorTextoDark;
  final FontWeight? tipoFuente;
  final TextDecoration? decoration;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    //bool isDarkMode = context.read<MenuBloc>().state.theme == ThemeMode.dark;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        ((ocultarTexto ?? false) ? '***************' : texto) ?? '',
        maxLines: maxlineas,
        overflow: overflow,
        textAlign: textAlign,
        style: theme.textTheme.headlineLarge!.copyWith(
            decoration: decoration,
            color: colorTextoDark, //isDarkMode ? colorTextoLight : colorTextoDark,
            fontWeight: tipoFuente),
      ),
    );
  }
}

class _FromValueWidget extends TextWidget {
  _FromValueWidget(
      {required String texto,
      required TipoTexto tipoTexto,
      Color? colorTextoLight,
      Color? colorTextoDark,
      FontWeight? tipoFuente,
      int? maxlineas,
      TextAlign? textAling,
      TextOverflow? overflow = TextOverflow.ellipsis,
      bool? ocultarTexto = false,
      TextDecoration? decoration})
      : assert(condicion(colorTextoLight, colorTextoDark), 'Debe ingresar ambos colores'),
        super(
          child: _FromValue(
              tipoTexto: tipoTexto,
              texto: texto,
              maxlineas: maxlineas,
              ocultarTexto: ocultarTexto,
              overflow: overflow,
              textAlign: textAling,
              colorTextoLight: colorTextoLight,
              colorTextoDark: colorTextoDark,
              decoration: decoration,
              tipoFuente: tipoFuente),
        );
}

class _FromValue extends StatelessWidget {
  const _FromValue({
    required this.ocultarTexto,
    required this.texto,
    required this.overflow,
    required this.textAlign,
    required this.maxlineas,
    required this.tipoFuente,
    this.colorTextoLight,
    this.colorTextoDark,
    this.decoration,
    required this.tipoTexto,
  });
  final bool? ocultarTexto;
  final TipoTexto tipoTexto;
  final String texto;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int? maxlineas;
  final Color? colorTextoLight;
  final Color? colorTextoDark;
  final FontWeight? tipoFuente;
  final TextDecoration? decoration;
  @override
  Widget build(BuildContext context) {
    return switch (tipoTexto) {
      TipoTexto.textSmall => TextWidget.textSmall(
          texto: texto,
          colorTextoLight: colorTextoLight,
          colorTextoDark: colorTextoDark,
          tipoFuente: tipoFuente,
          maxlineas: maxlineas,
          textAling: textAlign,
          overflow: overflow,
          ocultarTexto: ocultarTexto,
          decoration: decoration),
      TipoTexto.textMedium => TextWidget.textMedium(
          texto: texto,
          colorTextoLight: colorTextoLight,
          colorTextoDark: colorTextoDark,
          tipoFuente: tipoFuente,
          maxlineas: maxlineas,
          textAling: textAlign,
          overflow: overflow,
          ocultarTexto: ocultarTexto,
          decoration: decoration),
      TipoTexto.textLarge => TextWidget.textLarge(
          texto: texto,
          colorTextoLight: colorTextoLight,
          colorTextoDark: colorTextoDark,
          tipoFuente: tipoFuente,
          maxlineas: maxlineas,
          textAling: textAlign,
          overflow: overflow,
          ocultarTexto: ocultarTexto,
          decoration: decoration),
      TipoTexto.titleSmall => TextWidget.titleSmall(
          texto: texto,
          colorTextoLight: colorTextoLight,
          colorTextoDark: colorTextoDark,
          tipoFuente: tipoFuente,
          maxlineas: maxlineas,
          textAling: textAlign,
          overflow: overflow,
          ocultarTexto: ocultarTexto,
          decoration: decoration),
      TipoTexto.titleMedium => TextWidget.titleMedium(
          texto: texto,
          colorTextoLight: colorTextoLight,
          colorTextoDark: colorTextoDark,
          tipoFuente: tipoFuente,
          maxlineas: maxlineas,
          textAling: textAlign,
          overflow: overflow,
          ocultarTexto: ocultarTexto,
          decoration: decoration),
      TipoTexto.titleLarge => TextWidget.titleLarge(
          texto: texto,
          colorTextoLight: colorTextoLight,
          colorTextoDark: colorTextoDark,
          tipoFuente: tipoFuente,
          maxlineas: maxlineas,
          textAling: textAlign,
          overflow: overflow,
          ocultarTexto: ocultarTexto,
          decoration: decoration),
      TipoTexto.headLineSmall => TextWidget.headLineSmall(
          texto: texto,
          colorTextoLight: colorTextoLight,
          colorTextoDark: colorTextoDark,
          tipoFuente: tipoFuente,
          maxlineas: maxlineas,
          textAling: textAlign,
          overflow: overflow,
          ocultarTexto: ocultarTexto,
          decoration: decoration),
      TipoTexto.headLineMedium => TextWidget.headLineMedium(
          texto: texto,
          colorTextoLight: colorTextoLight,
          colorTextoDark: colorTextoDark,
          tipoFuente: tipoFuente,
          maxlineas: maxlineas,
          textAling: textAlign,
          overflow: overflow,
          ocultarTexto: ocultarTexto,
          decoration: decoration),
      TipoTexto.headLineLarge => TextWidget.headLineLarge(
          texto: texto,
          colorTextoLight: colorTextoLight,
          colorTextoDark: colorTextoDark,
          tipoFuente: tipoFuente,
          maxlineas: maxlineas,
          textAling: textAlign,
          overflow: overflow,
          ocultarTexto: ocultarTexto,
          decoration: decoration)
    };
  }
}
