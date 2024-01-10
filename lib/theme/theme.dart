import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeModel {
  static final ThemeModel _instancia = ThemeModel._internal();
  factory ThemeModel() {
    return _instancia;
  }
  ThemeModel._internal();

  late double bordeRadius = 10;
  final Color cdmBlanco = const Color.fromARGB(255, 237, 232, 228);
  final Color cdmAzul = const Color.fromARGB(255, 98, 138, 217);
  late Color colorPrimario = Colors.blue;

  ///Para campos de textos dropdow y demas widget que tengan estilo similar
  late double altoCampos = 40;
  late EdgeInsets paddingInput = const EdgeInsets.symmetric(horizontal: 5);

  ///Estas propiedades son para los campos de texto
  late double sizeTituloTextfield = 17;
  late double sizeDescripcionTextfield = 14;
  late Color colorTitulosCajasDeTexto = colorPrimario;

  FlexScheme scheme = FlexScheme.bahamaBlue;

  ThemeMode themeMode = ThemeMode.system;

  late ThemeData lightTheme;
  late ThemeData darkTheme;

  initTheme(
      {ThemeData? lightTheme,
      ThemeData? darkTheme,
      double? altoCampos,
      EdgeInsets? paddingInput,
      double? bordeRadius,
      double? sizeTituloTextfield,
      double? sizeDescripcionTextfield,
      Color? colorTitulosCajasDeTexto,
      Color? cdmBlanco,
      Color? cdmAzul,
      Color? cdmRojo,
      Color colorPrimario = const Color.fromARGB(255, 255, 60, 50)}) {
    this.bordeRadius = bordeRadius ?? 10;
    this.altoCampos = altoCampos ?? 40;
    this.sizeDescripcionTextfield = sizeDescripcionTextfield ?? 14;
    this.colorTitulosCajasDeTexto = colorTitulosCajasDeTexto ?? colorPrimario;
    this.sizeTituloTextfield = sizeTituloTextfield ?? 17;
    this.paddingInput = paddingInput ?? const EdgeInsets.symmetric(horizontal: 5);

    this.colorPrimario = colorPrimario;
    this.lightTheme = lightTheme ??
        FlexThemeData.light(
          scheme: scheme,
          surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
          blendLevel: 9,
          tooltipsMatchBackground: true,
          appBarStyle: FlexAppBarStyle.scaffoldBackground,

          subThemesData: FlexSubThemesData(
            elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
            elevatedButtonSecondarySchemeColor: SchemeColor.secondaryContainer,
            defaultRadius: bordeRadius,
            elevatedButtonRadius: bordeRadius,
            inputDecoratorSchemeColor: SchemeColor.secondary,
            switchSchemeColor: SchemeColor.primary,
            inputDecoratorIsFilled: false,
            tooltipRadius: bordeRadius,
            textButtonTextStyle: MaterialStatePropertyAll(GoogleFonts.workSans().copyWith(color: cdmAzul)),
            inputDecoratorRadius: bordeRadius,
            inputDecoratorBorderType: !kIsWeb ? FlexInputBorderType.underline : FlexInputBorderType.outline,
            outlinedButtonBorderWidth: 0.2,
            appBarBackgroundSchemeColor: SchemeColor.primary,
          ),

          ///Color para las tarjetas de los dialogos
          surfaceTint: Colors.white,
          textTheme: TextTheme(
            ///Utilizar para campos de textos formularios
            bodySmall: GoogleFonts.workSans().copyWith(fontSize: 12),
            bodyMedium: GoogleFonts.workSans().copyWith(fontSize: 15),
            bodyLarge: GoogleFonts.workSans().copyWith(fontSize: 18),

            ///fuente para titulos
            titleSmall: GoogleFonts.workSans().copyWith(fontSize: 21),
            titleMedium: GoogleFonts.workSans().copyWith(fontSize: 24),
            titleLarge: GoogleFonts.workSans().copyWith(fontSize: 27),

            ///Contenido con un tamaño mayor que el titulo
            headlineSmall: GoogleFonts.workSans().copyWith(fontSize: 30),
            headlineMedium: GoogleFonts.workSans().copyWith(fontSize: 33),
            headlineLarge: GoogleFonts.workSans().copyWith(fontSize: 36),
          ),
          keyColors: const FlexKeyColors(
            keepPrimary: true,
          ),
          tones: FlexTones.vivid(Brightness.light),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          fontFamily: GoogleFonts.workSans().fontFamily,
          swapLegacyOnMaterial3: true,
        );
    this.darkTheme = darkTheme ??
        FlexThemeData.dark(
          scheme: scheme,
          surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
          blendLevel: 15,
          tooltipsMatchBackground: true,
          appBarStyle: FlexAppBarStyle.scaffoldBackground,
          subThemesData: FlexSubThemesData(
            inputDecoratorBorderType: kIsWeb ? FlexInputBorderType.underline : FlexInputBorderType.outline,
            elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
            elevatedButtonSecondarySchemeColor: SchemeColor.secondaryContainer,
            dialogBackgroundSchemeColor: SchemeColor.onPrimary,
            defaultRadius: bordeRadius,
            textButtonTextStyle: MaterialStatePropertyAll(GoogleFonts.workSans().copyWith(color: cdmAzul)),
            elevatedButtonRadius: bordeRadius,
            switchSchemeColor: SchemeColor.primary,
            inputDecoratorIsFilled: false,
            tooltipRadius: bordeRadius,
            inputDecoratorRadius: bordeRadius,
            appBarBackgroundSchemeColor: SchemeColor.primary,
          ),
          textTheme: TextTheme(
            ///Utilizar para campos de textos formularios
            bodySmall: GoogleFonts.workSans().copyWith(fontSize: 12),
            bodyMedium: GoogleFonts.workSans().copyWith(fontSize: 15),
            bodyLarge: GoogleFonts.workSans().copyWith(fontSize: 18),

            ///fuente para titulos
            titleSmall: GoogleFonts.workSans().copyWith(fontSize: 21),
            titleMedium: GoogleFonts.workSans().copyWith(fontSize: 24),
            titleLarge: GoogleFonts.workSans().copyWith(fontSize: 27),

            ///Contenido con un tamaño mayor que el titulo
            headlineSmall: GoogleFonts.workSans().copyWith(fontSize: 30),
            headlineMedium: GoogleFonts.workSans().copyWith(fontSize: 33),
            headlineLarge: GoogleFonts.workSans().copyWith(fontSize: 36),
          ),
          keyColors: const FlexKeyColors(),
          tones: FlexTones.vivid(Brightness.dark),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          fontFamily: GoogleFonts.notoSans().fontFamily,
          swapLegacyOnMaterial3: true,

          ///Color para las tarjetas de los dialogos
          surfaceTint: const Color(0xff9ccaff),
        );
    // ThemeModel().initTheme(
    //     altoCampos: 40,
    //     paddingInput: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
    //     colorPrimario: colorPrimario,
    //     cdmAzul: colorPrimario,
    //     lightTheme: lightTheme,
    //     darkTheme: darkTheme);
  }
}
