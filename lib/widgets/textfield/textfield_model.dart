part of 'textfield_widget.dart';

class _TextfieldContrasenaWidget extends TextfieldWidget {
  _TextfieldContrasenaWidget({
    TextEditingController? controller,
    String? labelTitulo,
    required bool obscureText,
    required Function() ontap,
    super.hintText,
    Function(String)? onChanged,
    Function(String)? onSubmitted,
    TextInputAction? textInputAction = TextInputAction.next,
    super.maxWidth,
    FocusNode? focusNode,
    List<String>? autofillHints,
    Widget? leftWidget,
    Widget? rightWidget,
    bool? tituloNegrita,
    Widget? labelInterno,
  }) : super(
            tituloNegrita: tituloNegrita,
            altoCampo: ThemeModel().altoCampos,
            child: _TextfieldContrasena(
                controller: controller,
                onChanged: onChanged,
                onSubmitted: onSubmitted,
                focusNode: focusNode,
                obscureText: obscureText,
                textInputAction: textInputAction,
                autofillHints: autofillHints,
                labelInterno: labelInterno,
                ontap: ontap),
            leftWidget: leftWidget,
            rightWidget: rightWidget,
            labelTitulo: labelTitulo);
}

enum TipoBusqueda {
  contain,
  inicia,
}

class _TextfieldContrasena extends StatelessWidget {
  const _TextfieldContrasena({
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction,
    required this.obscureText,
    required this.ontap,
    this.autofillHints,
    this.labelInterno,
  });

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Function() ontap;
  final List<String>? autofillHints;
  final Widget? labelInterno;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextFormField(
            autofillHints: autofillHints,
            textInputAction: textInputAction,
            autofocus: false,
            controller: controller,
            obscureText: obscureText,
            focusNode: focusNode,
            style: theme.textTheme.bodyMedium!.copyWith(),
            textCapitalization: TextCapitalization.sentences,
            onChanged: onChanged,
            onFieldSubmitted: onSubmitted,
            decoration: const InputDecoration().copyWith(contentPadding: ThemeModel().paddingInput, label: labelInterno)),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
              onTap: ontap,
              child: Icon(
                (obscureText) ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                size: 14,
              )),
        )
      ],
    );
  }
}

class _TextfieldTextWidget extends TextfieldWidget {
  _TextfieldTextWidget(
      {TextEditingController? controller,
      String? labelTitulo,
      super.hintText,
      Function(String)? onChanged,
      Function(String)? onSubmitted,
      TextInputAction? textInputAction = TextInputAction.next,
      super.maxWidth,
      FocusNode? focusNode,
      List<String>? autofillHints,
      Widget? leftWidget,
      Widget? rightWidget,
      bool? disabled,
      Widget? labelInterno,
      bool? tituloNegrita,
      Widget? suffixIcon})
      : super(
            tituloNegrita: tituloNegrita,
            disabled: disabled,
            altoCampo: ThemeModel().altoCampos,
            child: _TextfieldText(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              focusNode: focusNode,
              textInputAction: textInputAction,
              autofillHints: autofillHints,
              labelInterno: labelInterno,
              suffixIcon: suffixIcon,
            ),
            leftWidget: leftWidget,
            rightWidget: rightWidget,
            labelTitulo: labelTitulo);
}

class _TextfieldText extends StatelessWidget {
  const _TextfieldText({
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction,
    this.autofillHints,
    this.labelInterno,
    this.suffixIcon,
  });

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final List<String>? autofillHints;
  final Widget? labelInterno;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return TextFormField(
        autofillHints: autofillHints,
        textInputAction: textInputAction,
        autofocus: false,
        autocorrect: false,
        controller: controller,
        focusNode: focusNode,
        enableSuggestions: false,
        enableInteractiveSelection: true,
        contextMenuBuilder: null,
        keyboardType: TextInputType.text,
        style: theme.textTheme.bodyMedium!.copyWith(),
        textCapitalization: TextCapitalization.sentences,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        decoration: const InputDecoration().copyWith(contentPadding: ThemeModel().paddingInput, label: labelInterno, suffixIcon: suffixIcon));
  }
}

//////////////////////Tipo Correo
class _TextfieldEmailWidget extends TextfieldWidget {
  _TextfieldEmailWidget({
    TextEditingController? controller,
    String? labelTitulo,
    super.hintText,
    Function(String)? onChanged,
    Function(String)? onSubmitted,
    TextInputAction? textInputAction = TextInputAction.next,
    super.maxWidth,
    FocusNode? focusNode,
    List<String>? autofillHints,
    Widget? leftWidget,
    Widget? rightWidget,
    bool? tituloNegrita,
    Widget? labelInterno,
  }) : super(
            tituloNegrita: tituloNegrita,
            altoCampo: ThemeModel().altoCampos,
            child: _TextfieldEmail(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              focusNode: focusNode,
              textInputAction: textInputAction,
              autofillHints: autofillHints,
              labelInterno: labelInterno,
            ),
            leftWidget: leftWidget,
            rightWidget: rightWidget,
            labelTitulo: labelTitulo);
}

class _TextfieldEmail extends StatelessWidget {
  const _TextfieldEmail({
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction,
    this.autofillHints,
    this.labelInterno,
  });

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final List<String>? autofillHints;
  final Widget? labelInterno;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return TextFormField(
        autofillHints: autofillHints,
        keyboardType: TextInputType.emailAddress,
        textInputAction: textInputAction,
        autofocus: false,
        controller: controller,
        focusNode: focusNode,
        style: theme.textTheme.bodyMedium!.copyWith(),
        textCapitalization: TextCapitalization.sentences,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        decoration: const InputDecoration().copyWith(contentPadding: ThemeModel().paddingInput, label: labelInterno));
  }
}

//////////////////////Tipo Numero
class _TextfieldNumeroWidget extends TextfieldWidget {
  _TextfieldNumeroWidget(
      {TextEditingController? controller,
      String? labelTitulo,
      super.hintText,
      Function(String)? onChanged,
      Function(String)? onSubmitted,
      TextInputAction? textInputAction = TextInputAction.next,
      super.maxWidth,
      FocusNode? focusNode,
      List<String>? autofillHints,
      Widget? leftWidget,
      Widget? rightWidget,
      Widget? labelInterno,
      bool? tituloNegrita,
      Widget? suffixIcon})
      : super(
            tituloNegrita: tituloNegrita,
            altoCampo: ThemeModel().altoCampos,
            child: _TextfieldNumero(
              labelInterno: labelInterno,
              suffixIcon: suffixIcon,
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              focusNode: focusNode,
              textInputAction: textInputAction,
              autofillHints: autofillHints,
            ),
            leftWidget: leftWidget,
            rightWidget: rightWidget,
            labelTitulo: labelTitulo);
}

class _TextfieldNumero extends StatelessWidget {
  const _TextfieldNumero({
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction,
    this.autofillHints,
    this.labelInterno,
    this.suffixIcon,
  });

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final List<String>? autofillHints;
  final Widget? labelInterno;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return TextFormField(
        autofillHints: autofillHints,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        textInputAction: textInputAction,
        autofocus: false,
        controller: controller,
        focusNode: focusNode,
        style: theme.textTheme.bodyMedium!.copyWith(),
        textCapitalization: TextCapitalization.sentences,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        decoration: const InputDecoration().copyWith(contentPadding: ThemeModel().paddingInput, label: labelInterno, suffixIcon: suffixIcon));
  }
}

class _TextfieldFechaWidget extends TextfieldWidget {
  _TextfieldFechaWidget(
      {TextEditingController? controller,
      String? labelTitulo,
      super.hintText,
      Function(String)? onChanged,
      required Function(String) onSubmitted,
      TextInputAction? textInputAction = TextInputAction.next,
      FocusNode? focusNode,
      List<String>? autofillHints,
      Widget? leftWidget,
      Widget? rightWidget,
      Widget? labelInterno,
      List<TextInputFormatter>? inputFormatters,
      bool? tituloNegrita,
      bool? selectorInterno})
      : super(
            tituloNegrita: tituloNegrita,
            altoCampo: ThemeModel().altoCampos,
            child: _TextfieldFecha(
                controller: controller,
                onChanged: onChanged,
                onSubmitted: onSubmitted,
                focusNode: focusNode,
                textInputAction: textInputAction,
                inputFormatters: inputFormatters,
                autofillHints: autofillHints,
                labelInterno: labelInterno,
                selectorInterno: selectorInterno ?? false),
            leftWidget: leftWidget,
            rightWidget: rightWidget,
            labelTitulo: labelTitulo);
}

class _TextfieldFecha extends StatelessWidget {
  const _TextfieldFecha({
    this.controller,
    this.onChanged,
    required this.onSubmitted,
    this.focusNode,
    this.textInputAction,
    this.autofillHints,
    this.labelInterno,
    this.selectorInterno = false,
    this.inputFormatters,
  });

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String) onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final List<String>? autofillHints;
  final Widget? labelInterno;
  final bool? selectorInterno;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return LayoutBuilder(builder: (context, constrains) {
      return Row(
        children: [
          Flexible(
            child: TextFormField(
                autofillHints: autofillHints,
                textInputAction: textInputAction,
                autofocus: false,
                controller: controller,
                focusNode: focusNode,
                style: theme.textTheme.bodyMedium!.copyWith(),
                textCapitalization: TextCapitalization.sentences,
                inputFormatters: inputFormatters,
                onChanged: onChanged,
                onFieldSubmitted: onSubmitted,
                decoration: const InputDecoration().copyWith(
                  hintText: 'dd/mm/aaaa',
                  contentPadding: ThemeModel().paddingInput,
                  label: labelInterno,
                  suffixIcon: (selectorInterno == true) ? DatepickerWidget(onFechaSeleccionada: onSubmitted, fechaInicial: controller?.text) : null,
                )),
          ),
          if (selectorInterno == false)
            Row(
              children: [const SizedBox(width: 5), DatepickerWidget(onFechaSeleccionada: onSubmitted, fechaInicial: controller?.text)],
            )
        ],
      );
    });
  }
}

class _TextfieldHoraWidget extends TextfieldWidget {
  _TextfieldHoraWidget({
    TextEditingController? controller,
    String? labelTitulo,
    super.hintText,
    Function(String)? onChanged,
    required Function(String) onSubmitted,
    TextInputAction? textInputAction = TextInputAction.next,
    FocusNode? focusNode,
    List<String>? autofillHints,
    List<TextInputFormatter>? inputFormatters,
    Widget? leftWidget,
    Widget? rightWidget,
    bool? tituloNegrita,
  }) : super(
            tituloNegrita: tituloNegrita,
            altoCampo: ThemeModel().altoCampos,
            child: _TextfieldHora(
                controller: controller,
                onChanged: onChanged,
                onSubmitted: onSubmitted,
                focusNode: focusNode,
                textInputAction: textInputAction,
                inputFormatters: inputFormatters,
                autofillHints: autofillHints),
            leftWidget: leftWidget,
            rightWidget: rightWidget,
            labelTitulo: labelTitulo);
}

class _TextfieldHora extends StatelessWidget {
  const _TextfieldHora({
    this.controller,
    this.onChanged,
    required this.onSubmitted,
    this.focusNode,
    this.textInputAction,
    this.autofillHints,
    this.inputFormatters,
  });

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String) onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final List<String>? autofillHints;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return LayoutBuilder(builder: (context, constrains) {
      return Row(
        children: [
          Flexible(
            child: TextFormField(
                autofillHints: autofillHints,
                textInputAction: textInputAction,
                autofocus: false,
                controller: controller,
                focusNode: focusNode,
                style: theme.textTheme.bodyMedium!.copyWith(),
                textCapitalization: TextCapitalization.sentences,
                inputFormatters: inputFormatters,
                onChanged: onChanged,
                onFieldSubmitted: onSubmitted,
                decoration: const InputDecoration().copyWith(hintText: 'hh:mm', contentPadding: ThemeModel().paddingInput)),
          ),
          const SizedBox(width: 5),
          TimepickerWidget(
            initialTime: controller?.text,
            onHoraSeleccionada: onSubmitted,
          )
        ],
      );
    });
  }
}

// class _TextfieldBusquedaWidget extends TextfieldWidget {
//   _TextfieldBusquedaWidget(
//       {required String labelTitulo,
//       super.hintText,
//       required List<ItemModel> lstOpciones,
//       ItemModel? valorDefecto,
//       Widget? leftWidget,
//       Widget? rightWidget,
//       Function()? onNuevo,
//       String? tituloNuevo = '+ Agregar Item',
//       TipoBusqueda? tipoBusqueda = TipoBusqueda.contain,
//       bool? showTooltip = false,
//       Function(ItemModel)? onChanged,
//       Function(String)? onSubmitted,
//       Widget? labelInterno,
//       bool? tituloNegrita,
//       Widget? suffixIcon})
//       : super(
//           tituloNegrita: tituloNegrita,
//           altoCampo: ThemeModel().altoCampos,
//           labelTitulo: labelTitulo,
//           leftWidget: leftWidget,
//           rightWidget: rightWidget,
//           child: _TextfieldBusqueda(
//             onSubmitted: onSubmitted,
//             onChanged: onChanged,
//             onNuevo: onNuevo,
//             tituloNuevo: tituloNuevo,
//             tipoBusqueda: tipoBusqueda,
//             showTooltip: showTooltip,
//             valorDefecto: valorDefecto,
//             lstOpciones: lstOpciones,
//             labelInterno: labelInterno,
//             suffixIcon: suffixIcon,
//           ),
//         );
// }

// class _TextfieldBusqueda extends StatefulWidget {
//   const _TextfieldBusqueda({
//     this.valorDefecto,
//     required this.lstOpciones,
//     this.onChanged,
//     this.labelInterno,
//     this.suffixIcon,
//     this.onNuevo,
//     this.tituloNuevo,
//     this.onSubmitted,
//     this.tipoBusqueda,
//     this.showTooltip,
//   });
//   final ItemModel? valorDefecto;
//   final List<ItemModel> lstOpciones;
//   final Function(ItemModel)? onChanged;
//   final Function()? onNuevo;
//   final String? tituloNuevo;
//   final TipoBusqueda? tipoBusqueda;
//   final bool? showTooltip;
//   final Widget? labelInterno;
//   final Widget? suffixIcon;
//   final Function(String)? onSubmitted;
//   @override
//   State<_TextfieldBusqueda> createState() => _TextfieldBusquedaState();
// }

// class _TextfieldBusquedaState extends State<_TextfieldBusqueda> with TickerProviderStateMixin {
//   final FocusNode _focusNode = FocusNode();
//   final focus = FocusNode();
//   List<OverlayEntry?> lstOverlays = [];
//   // GlobalKey globalKey = GlobalKey();
//   final LayerLink _layerLink = LayerLink();
//   bool isOpen = false;
//   final controller = TextEditingController(text: '');
//   String busqueda = '';
//   int indiceFoco = -1;
//   List<ItemModel> lstOpciones = [];
//   List<GlobalKey> lstKeys = [];
//   @override
//   void initState() {
//     super.initState();
//     OverlayState? overlayState = Overlay.of(context);
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   globalKey;
//     // });

//     _focusNode.addListener(() {
//       log(isOpen.toString());
//       if (_focusNode.hasFocus && ((widget.valorDefecto == null || widget.valorDefecto!.idItem.isEmpty)) && !isOpen) {
//         _mostrarPopUp(overlayState);
//       } else {
//         // FocusScope.of(context).unfocus();
//       }

//       ///Si el widget gano el foco
//       if (_focusNode.hasFocus) {
//         ///y isOpen es false (ya se selecciono un elemento)
//         if (!isOpen) {
//           ///HAce un nextfocus para que se vaya al siguiente campo y esto hace que tome el foco `_focusNode`
//           FocusScope.of(context).nextFocus();

//           ///Se vuelve a realizar una segunda vez para que de esta forma pierda el foco y gane el foco el nuevo componente
//           ///Esto solo se genera cuando el foco que se quiere tomar es otro componente de textfieldBusqueda
//           FocusScope.of(context).nextFocus();
//         }
//       }
//     });
//   }

//   cerrarOverlay() {
//     for (var item in lstOverlays) {
//       try {
//         item?.remove();
//         item = null;
//       } catch (e) {
//         item = null;
//         log('$e');
//       }
//     }
//     isOpen = false;
//     lstOverlays.clear();
//     lstKeys.clear();
//   }

//   _mostrarPopUp(OverlayState? overlayState) {
//     indiceFoco = -1;
//     context.read<MenuBloc>().add(OnEventoUiMenuEvent(accionUi: '${EnvironmentView.onKeyTextfieldBusqueda}$indiceFoco'));
//     setState(() {
//       isOpen = true;
//     });
//     OverlayEntry overlayEntry = _createOverlay(onNuevo: widget.onNuevo, tituloNuevo: widget.tituloNuevo ?? '');
//     overlayState!.insert(overlayEntry);
//     lstOverlays.add(overlayEntry);
//   }

//   OverlayEntry _createOverlay({Function()? onNuevo, String tituloNuevo = '+ Agregar Item'}) {
//     RenderBox renderBox = context.findRenderObject() as RenderBox;
//     var size = renderBox.size;
//     lstOpciones.clear();
//     if (onNuevo != null) {
//       lstOpciones.add(ItemModel(idItem: '0', descripcionItem: tituloNuevo));
//     }
//     lstOpciones.addAll(widget.lstOpciones.where((item) {
//       return (widget.tipoBusqueda == TipoBusqueda.contain)
//           ? item.descripcionItem.toLowerCase().contains(busqueda.trim().toLowerCase()) || busqueda.isEmpty
//           : item.descripcionItem.toLowerCase().startsWith(busqueda.trim().toLowerCase()) || busqueda.isEmpty;
//     }));
//     lstKeys = [...List.generate(lstOpciones.length, (index) => GlobalKey())];
//     return OverlayEntry(
//       builder: (context) => Stack(
//         children: [
//           GestureDetector(
//               onTap: () => cerrarOverlay(),
//               child: Container(
//                 color: Colors.transparent,
//               )),
//           Positioned(
//             width: size.width,
//             child: CompositedTransformFollower(
//               link: _layerLink,
//               showWhenUnlinked: false,
//               offset: Offset(0.0, size.height),
//               child: Material(
//                 elevation: 5.0,
//                 child: Container(
//                   constraints: (widget.lstOpciones.length < 2) ? const BoxConstraints(maxHeight: 100) : const BoxConstraints(maxHeight: 200),
//                   child: BlocListener<MenuBloc, MenuState>(
//                     listenWhen: (previous, current) => !current.isWorking,
//                     listener: (context, state) {},
//                     child: BlocBuilder<MenuBloc, MenuState>(
//                       buildWhen: (previous, current) => !current.isWorking,
//                       builder: (context, state) {
//                         if (state.accion == EnvironmentView.onEventoUiMenuEvent) {
//                           List<String> lst = state.parametroUi.split(EnvironmentView.onKeyTextfieldBusqueda);

//                           if (lst.length > 1) {
//                             indiceFoco = int.parse(lst[1]);
//                           }
//                         }
//                         return ListView(shrinkWrap: true, physics: const BouncingScrollPhysics(), children: [
//                           ...List.generate(
//                               lstOpciones.length,
//                               (index) => GestureDetector(
//                                     key: lstKeys[index],
//                                     child: Tooltip(
//                                       waitDuration: const Duration(seconds: 1),
//                                       message: widget.showTooltip! ? lstOpciones[index].descripcionItem : '',
//                                       child: Container(
//                                         color: indiceFoco == index ? Colors.grey : Colors.transparent,
//                                         padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//                                         child: TextWidget.textMedium(
//                                           texto: lstOpciones[index].descripcionItem,
//                                         ),
//                                       ),
//                                     ),
//                                     onTap: () {
//                                       if (widget.onNuevo != null && index == 0) {
//                                         widget.onNuevo!.call();
//                                         controller.text = '';
//                                         cerrarOverlay();
//                                       } else {
//                                         if (isOpen && index >= 0) {
//                                           setState(() {
//                                             //   isOpen = false;
//                                           });
//                                           controller.text = '';
//                                           widget.onChanged?.call(lstOpciones[index]);
//                                           // FocusScope.of(context).nextFocus();
//                                           cerrarOverlay();
//                                         }
//                                       }
//                                     },
//                                   ))
//                         ]);
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CompositedTransformTarget(
//         link: _layerLink,
//         child: SizedBox(
//           // width: widget.maxWidth,
//           child: Stack(
//             alignment: Alignment.centerLeft,
//             children: [
//               AbsorbPointer(
//                 absorbing: (widget.valorDefecto ?? const ItemModel()).idItem.isNotEmpty,
//                 child: RawKeyboardListener(
//                   focusNode: focus
//                     ..addListener(() {
//                       if (focus.hasFocus && _focusNode.canRequestFocus) {
//                         _focusNode.requestFocus();
//                       }
//                     }),
//                   onKey: (RawKeyEvent event) {
//                     if (event.runtimeType == RawKeyDownEvent) {
//                       ///Evento del tap
//                       if (event.logicalKey == LogicalKeyboardKey.tab) {
//                         cerrarOverlay();
//                       }

//                       ///si la tecla es flecha arriba
//                       if (event.logicalKey == LogicalKeyboardKey.arrowUp && isOpen && indiceFoco > 0) {
//                         indiceFoco--;
//                         //context.read<MenuBloc>().add(OnEventoUiMenuEvent(accionUi: '${EnvironmentView.onKeyTextfieldBusqueda}$indiceFoco'));
//                         Scrollable.ensureVisible(lstKeys[indiceFoco].currentContext!);
//                       }

//                       ///si la tecla es flecha abajo
//                       if (event.logicalKey == LogicalKeyboardKey.arrowDown && indiceFoco < lstOpciones.length - 1) {
//                         indiceFoco++;
//                         //context.read<MenuBloc>().add(OnEventoUiMenuEvent(accionUi: '${EnvironmentView.onKeyTextfieldBusqueda}$indiceFoco'));
//                         Scrollable.ensureVisible(lstKeys[indiceFoco].currentContext!);
//                       }

//                       ///si la tecla es alguno de los dos enter
//                       if ((event.logicalKey == LogicalKeyboardKey.enter || event.logicalKey == LogicalKeyboardKey.numpadEnter)) {
//                         if (widget.onNuevo != null && indiceFoco == 0) {
//                           widget.onNuevo!.call();
//                           cerrarOverlay();
//                         } else {
//                           if (isOpen && indiceFoco >= 0) {
//                             setState(() {
//                               isOpen = false;
//                             });
//                             controller.text = '';
//                             widget.onChanged?.call(lstOpciones[indiceFoco]);
//                             FocusScope.of(context).nextFocus();
//                             cerrarOverlay();
//                           }
//                         }
//                       }
//                     }
//                   },
//                   child: TextfieldWidget.texto(
//                     textInputAction: TextInputAction.none,
//                     labelInterno: widget.labelInterno,
//                     suffixIcon: widget.suffixIcon,
//                     onSubmitted: widget.onSubmitted,
//                     onChanged: (value) {
//                       setState(() {
//                         busqueda = value;
//                         cerrarOverlay();
//                         _mostrarPopUp(Overlay.of(context));
//                       });
//                     },
//                     controller: controller,
//                     // focusNode: _focusNode
//                     focusNode: _focusNode,
//                   ),
//                 ),
//               ),
//               if (widget.valorDefecto?.idItem.isNotEmpty ?? false)
//                 Container(
//                   // height: ThemeModel().altoCampos,
//                   constraints: const BoxConstraints(maxWidth: 400),
//                   padding: const EdgeInsets.only(top: 3, bottom: 3, right: 5, left: 10),
//                   margin: const EdgeInsets.only(left: 5),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(ThemeModel().bordeRadius),
//                       border: Border.all(color: Theme.of(context).colorScheme.tertiaryContainer, width: 0.5)),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Flexible(
//                         child: TextWidget.textMedium(
//                           texto: widget.valorDefecto?.descripcionItem ?? '',
//                           maxlineas: 1,
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() => busqueda = '');
//                           widget.onChanged?.call(const ItemModel());
//                         },
//                         child: Icon(Icons.close, color: Theme.of(context).colorScheme.tertiaryContainer, size: 17),
//                       )
//                     ],
//                   ),
//                 )
//             ],
//           ),
//         ));
//   }
// }

class _TextfieldValidaClaveWidget extends TextfieldWidget {
  _TextfieldValidaClaveWidget({
    required TextEditingController controller,
    required bool obscureText,
    required Function() ontap,
    super.hintText,
    Function(String)? onChanged,
    Function(String)? onSubmitted,
    TextInputAction? textInputAction = TextInputAction.next,
    FocusNode? focusNode,
    Widget? leftWidget,
    Widget? rightWidget,
    bool? tituloNegrita,
  }) : super(
            tituloNegrita: tituloNegrita,
            leftWidget: leftWidget,
            rightWidget: rightWidget,
            child: _TextfieldValidaClave(
                controller: controller,
                onChanged: onChanged,
                onSubmitted: onSubmitted,
                focusNode: focusNode,
                obscureText: obscureText,
                textInputAction: textInputAction,
                ontap: ontap));
}

class _TextfieldValidaClave extends StatefulWidget {
  const _TextfieldValidaClave({
    required this.controller,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction,
    required this.obscureText,
    required this.ontap,
  });

  final TextEditingController controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Function() ontap;

  @override
  State<_TextfieldValidaClave> createState() => _TextfieldValidaClaveState();
}

class _TextfieldValidaClaveState extends State<_TextfieldValidaClave> {
  final controlller2 = TextEditingController();

  // @override
  // void didUpdateWidget(covariant _TextfieldValidaClave oldWidget) {
  //   controlller2.text = widget.controller.text;
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextfieldWidget.contrasena(
              focusNode: widget.focusNode,
              controller: widget.controller,
              labelTitulo: 'Contraseña',
              obscureText: widget.obscureText,
              onChanged: (p0) {
                setState(() {
                  widget.onChanged?.call(p0);
                  _determinaMensaje();
                });
              },
              ontap: widget.ontap),
          const SizedBox(
            height: 10,
          ),
          TextfieldWidget.contrasena(
            controller: controlller2,
            labelTitulo: 'Repetir contraseña',
            obscureText: widget.obscureText,
            onChanged: (p0) {
              setState(() {
                widget.onChanged?.call(p0);
                _determinaMensaje();
              });
            },
            ontap: widget.ontap,
            onSubmitted: widget.onSubmitted,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _NivelSeguridadRecuadro(
                    enBlanco: widget.controller.text.length < 4,
                    maxWidth: constrains.maxWidth,
                    border: const Border(
                      top: BorderSide(width: 0.3, color: Colors.black54),
                      bottom: BorderSide(width: 0.3, color: Colors.black54),
                      left: BorderSide(width: 0.3, color: Colors.black54),
                    ),
                    // maxWidth: widget.maxWidth,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
                    color: determinarColor(widget.controller.text),
                    cumpleCondicion: widget.controller.text.isNotEmpty),
                _NivelSeguridadRecuadro(
                    enBlanco: widget.controller.text.length < 4,
                    maxWidth: constrains.maxWidth,
                    border: const Border(top: BorderSide(width: 0.3, color: Colors.black54), bottom: BorderSide(width: 0.3, color: Colors.black54)),
                    // maxWidth: widget.maxWidth,
                    color: determinarColor(widget.controller.text),
                    cumpleCondicion: RegExpUtilsView.validaPassword(NivelSeguridadPassword.medio, widget.controller.text)),
                _NivelSeguridadRecuadro(
                    maxWidth: constrains.maxWidth,
                    enBlanco: widget.controller.text.length < 4,
                    border: const Border(
                      top: BorderSide(width: 0.3, color: Colors.black54),
                      bottom: BorderSide(width: 0.3, color: Colors.black54),
                      right: BorderSide(width: 0.3, color: Colors.black54),
                    ),
                    // maxWidth: widget.maxWidth,
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                    color: determinarColor(widget.controller.text),
                    cumpleCondicion: RegExpUtilsView.validaPassword(NivelSeguridadPassword.alto, widget.controller.text)),
              ],
            ),
          ),
          if (_determinaMensaje().isNotEmpty) ...[
            const SizedBox(height: 10),
            TextWidget.textSmall(
              colorTextoDark: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.7),
              colorTextoLight: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.7),
              texto: _determinaMensaje(),
              maxlineas: 4,
            )
          ]
        ],
      );
    });
  }

  String _determinaMensaje() {
    String error = '';
    String? contrasena = widget.controller.text;
    String? repContrasena = controlller2.text;

    ///Nivel de seguridad Bajo
    if (contrasena.length < 8) {
      error = 'La contraseña debe poseer al menos 8 dígitos';
    }
    if (error.isEmpty) {
      if (!RegExpUtilsView.validarSiContieneNumero(contrasena)) {
        error = 'La contraseña debe poseer al menos 1 número';
      }
    }
    if (error.isEmpty) {
      if (!RegExpUtilsView.validarSiContieneLetras(contrasena)) {
        error = 'La contraseña debe poseer al menos 1 letra';
      }
    }
    if (error.isEmpty) {
      if (!RegExpUtilsView.validaPassword(NivelSeguridadPassword.alto, contrasena)) {
        error = 'La contraseña debe contener carácter especial, números, letras minúsculas y mayúsculas';
      }
    }
    if (error.isEmpty) {
      if (repContrasena != contrasena) {
        error = 'Las contraseña no son iguales';
      }
    }
    return error;
  }
}

Color determinarColor(String texto) {
  Color color = Colors.grey[350]!;
  if (texto.isEmpty) {
    return color;
  }
  if (texto.length >= 4) {
    color = Colors.red;
  }
  if (RegExpUtilsView.validaPassword(NivelSeguridadPassword.medio, texto)) {
    color = Colors.yellow;
  }
  if (RegExpUtilsView.validaPassword(NivelSeguridadPassword.alto, texto)) {
    color = Colors.green;
  }

  return color;
}

class _NivelSeguridadRecuadro extends StatelessWidget {
  const _NivelSeguridadRecuadro(
      {Key? key, required this.color, required this.cumpleCondicion, this.borderRadius, required this.maxWidth, required this.border, required this.enBlanco})
      : super(key: key);
  final Color color;
  final bool enBlanco;
  final bool cumpleCondicion;
  final BorderRadius? borderRadius;
  final BoxBorder border;
  final double maxWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: border, color: cumpleCondicion ? color : Colors.white),
      child: Container(
        alignment: Alignment.centerRight,
        height: 2.5,
        width: maxWidth * 0.33,
        decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: enBlanco
                ? Colors.grey[350]!
                : cumpleCondicion
                    ? color
                    : Colors.white),
      ),
    );
  }
}

class _TextfieldMultilineaWidget extends TextfieldWidget {
  _TextfieldMultilineaWidget({
    TextEditingController? controller,
    String? labelTitulo,
    int? minLines,
    int? maxLines,
    super.hintText,
    Function(String)? onChanged,
    Function(String)? onSubmitted,
    TextInputAction? textInputAction = TextInputAction.next,
    super.maxWidth,
    FocusNode? focusNode,
    List<String>? autofillHints,
    Widget? leftWidget,
    Widget? rightWidget,
    bool? disabled,
    bool? tituloNegrita,
  }) : super(
            tituloNegrita: tituloNegrita,
            disabled: disabled,
            // altoCampo: ThemeModel().altoCampos,
            child: _TextfieldMultilinea(
              minLines: minLines,
              maxLines: maxLines,
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              focusNode: focusNode,
              textInputAction: textInputAction,
              autofillHints: autofillHints,
            ),
            leftWidget: leftWidget,
            rightWidget: rightWidget,
            labelTitulo: labelTitulo);
}

class _TextfieldMultilinea extends StatelessWidget {
  const _TextfieldMultilinea({
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction,
    this.autofillHints,
    this.minLines = 1,
    this.maxLines = 10,
  });

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final List<String>? autofillHints;
  final int? minLines;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return TextField(
        keyboardType: TextInputType.multiline,
        minLines: minLines,
        maxLines: maxLines,
        autofillHints: autofillHints,
        textInputAction: textInputAction,
        autofocus: false,
        controller: controller,
        focusNode: focusNode,
        style: theme.textTheme.bodyMedium!.copyWith(),
        onChanged: onChanged,
        decoration: const InputDecoration().copyWith(contentPadding: ThemeModel().paddingInput));
  }
}

class _TextfieldNumeroRealWidget extends TextfieldWidget {
  _TextfieldNumeroRealWidget(
      {TextEditingController? controller,
      String? labelTitulo,
      super.hintText,
      Function(String)? onChanged,
      Function(String)? onSubmitted,
      TextInputAction? textInputAction = TextInputAction.next,
      super.maxWidth,
      FocusNode? focusNode,
      List<String>? autofillHints,
      Widget? leftWidget,
      Widget? rightWidget,
      bool? disabled,
      Widget? labelInterno,
      bool? tituloNegrita,
      Widget? suffixIcon})
      : super(
            tituloNegrita: tituloNegrita,
            disabled: disabled,
            altoCampo: ThemeModel().altoCampos,
            child: _TextfieldNumeroReal(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              focusNode: focusNode,
              textInputAction: textInputAction,
              autofillHints: autofillHints,
              labelInterno: labelInterno,
              suffixIcon: suffixIcon,
            ),
            leftWidget: leftWidget,
            rightWidget: rightWidget,
            labelTitulo: labelTitulo);
}

class _TextfieldNumeroReal extends StatelessWidget {
  const _TextfieldNumeroReal({
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction,
    this.autofillHints,
    this.labelInterno,
    this.suffixIcon,
  });

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final List<String>? autofillHints;
  final Widget? labelInterno;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return TextFormField(
        autofillHints: autofillHints,
        textInputAction: textInputAction,
        autofocus: false,
        autocorrect: false,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^-?[0-9]\d*(\.\d+)?$')),
        ],
        keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
        controller: controller,
        focusNode: focusNode,
        enableSuggestions: false,
        enableInteractiveSelection: false,
        contextMenuBuilder: null,
        style: theme.textTheme.bodyMedium!.copyWith(),
        textCapitalization: TextCapitalization.sentences,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        decoration: const InputDecoration().copyWith(contentPadding: ThemeModel().paddingInput, label: labelInterno, suffixIcon: suffixIcon));
  }
}

class _TextfielFromValueWidget extends TextfieldWidget {
  _TextfielFromValueWidget(
      {required TipoTextField tipoTextField,
      TextEditingController? controller,
      String? labelTitulo,
      int? minLines,
      int? maxLines,
      String? hintText,
      Function(String)? onChanged,
      Function(String)? onSubmitted,
      TextInputAction? textInputAction = TextInputAction.next,
      super.maxWidth,
      FocusNode? focusNode,
      List<String>? autofillHints,
      Widget? leftWidget,
      Widget? rightWidget,
      bool? disabled,
      bool? tituloNegrita,
      bool? obscureText,
      double? altoCampo,
      Function()? ontap})
      : super(
          altoCampo: altoCampo,
          child: _TextfieldFromValue(
            labelTitulo: labelTitulo ?? '',
            tipoTextField: tipoTextField,
            minLines: minLines,
            maxLines: maxLines,
            controller: controller,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            focusNode: focusNode,
            textInputAction: textInputAction,
            autofillHints: autofillHints,
            obscureText: obscureText ?? false,
            hintText: hintText,
            ontap: ontap ?? () {},
            leftWidget: leftWidget,
            rightWidget: rightWidget,
            tituloNegrita: tituloNegrita,
            disabled: disabled,
          ),
        );
}

class _TextfieldFromValue extends StatelessWidget {
  const _TextfieldFromValue({
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction,
    this.autofillHints,
    this.minLines = 1,
    this.maxLines = 10,
    required this.tipoTextField,
    required this.labelTitulo,
    this.hintText,
    required this.obscureText,
    required this.ontap,
    this.leftWidget,
    this.rightWidget,
    this.disabled,
    this.tituloNegrita,
  });
  final TipoTextField tipoTextField;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final List<String>? autofillHints;
  final int? minLines;
  final int? maxLines;
  final String labelTitulo;
  final String? hintText;
  final bool obscureText;
  final Function() ontap;
  final Widget? leftWidget;
  final Widget? rightWidget;
  final bool? disabled;
  final bool? tituloNegrita;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (tipoTextField == TipoTextField.texto)
          TextfieldWidget.texto(
            autofillHints: autofillHints,
            textInputAction: textInputAction,
            controller: controller,
            focusNode: focusNode,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            labelTitulo: labelTitulo,
            hintText: hintText,
            disabled: disabled,
            leftWidget: leftWidget,
            rightWidget: rightWidget,
            tituloNegrita: tituloNegrita,
          )
        else if (tipoTextField == TipoTextField.numero)
          TextfieldWidget.numero(
            autofillHints: autofillHints,
            textInputAction: textInputAction,
            controller: controller,
            focusNode: focusNode,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            labelTitulo: labelTitulo,
            hintText: hintText,
            leftWidget: leftWidget,
            rightWidget: rightWidget,
            tituloNegrita: tituloNegrita,
          )
        else if (tipoTextField == TipoTextField.numeroReal)
          TextfieldWidget.numeroReal(
            autofillHints: autofillHints,
            textInputAction: textInputAction,
            controller: controller,
            focusNode: focusNode,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            labelTitulo: labelTitulo,
            hintText: hintText,
            disabled: disabled,
            leftWidget: leftWidget,
            rightWidget: rightWidget,
            tituloNegrita: tituloNegrita,
          )
        else if (tipoTextField == TipoTextField.multilinea)
          TextfieldWidget.multilinea(
            minLines: minLines,
            maxLines: maxLines,
            autofillHints: autofillHints,
            textInputAction: textInputAction,
            controller: controller,
            focusNode: focusNode,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            labelTitulo: labelTitulo,
            hintText: hintText,
            disabled: disabled,
            leftWidget: leftWidget,
            rightWidget: rightWidget,
            tituloNegrita: tituloNegrita,
          )
        else if (tipoTextField == TipoTextField.fecha)
          TextfieldWidget.fecha(
            autofillHints: autofillHints,
            textInputAction: textInputAction,
            controller: controller,
            focusNode: focusNode,
            onChanged: onChanged,
            onSubmitted: onSubmitted ?? (value) {},
            labelTitulo: labelTitulo,
            hintText: hintText,
            leftWidget: leftWidget,
            rightWidget: rightWidget,
            tituloNegrita: tituloNegrita,
          )
        else if (tipoTextField == TipoTextField.hora)
          TextfieldWidget.hora(
            autofillHints: autofillHints,
            textInputAction: textInputAction,
            controller: controller,
            focusNode: focusNode,
            onChanged: onChanged,
            onSubmitted: onSubmitted ?? (value) {},
            labelTitulo: labelTitulo,
            hintText: hintText,
            leftWidget: leftWidget,
            rightWidget: rightWidget,
            tituloNegrita: tituloNegrita,
          )
        else if (tipoTextField == TipoTextField.email)
          TextfieldWidget.email(
            autofillHints: autofillHints,
            textInputAction: textInputAction,
            controller: controller,
            focusNode: focusNode,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            labelTitulo: labelTitulo,
            hintText: hintText,
            leftWidget: leftWidget,
            rightWidget: rightWidget,
            tituloNegrita: tituloNegrita,
          )
        else if (tipoTextField == TipoTextField.contrasena)
          TextfieldWidget.contrasena(
            autofillHints: autofillHints,
            textInputAction: textInputAction,
            controller: controller,
            focusNode: focusNode,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            labelTitulo: labelTitulo,
            hintText: hintText,
            ontap: ontap,
            obscureText: obscureText,
            leftWidget: leftWidget,
            rightWidget: rightWidget,
            tituloNegrita: tituloNegrita,
          )
      ],
    );
  }
}
