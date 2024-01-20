import 'package:flutter/material.dart';
import 'package:horse_power/utils/utils.dart';

class DynamicDropDown extends StatefulWidget {
  const DynamicDropDown({
    Key? key,
    required this.label,
    required this.lstItems,
    required this.onChanged,
    this.valorSeleccionado,
  }) : super(key: key);

  final String label;
  final Future<List<dynamic>> lstItems;
  final Function(String) onChanged;
  final String? valorSeleccionado;

  @override
  State<DynamicDropDown> createState() => _DynamicDropDownState();
}

class _DynamicDropDownState extends State<DynamicDropDown> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: widget.lstItems,
      builder: (context, snapshot) {
        List<DropdownMenuItem<String>> dropdownItems = (snapshot.data ?? <DropdownMenuItem<String>>[])
            .map<DropdownMenuItem<String>>(
              (dynamic option) => DropdownMenuItem<String>(
                value: option['uid'],
                child: SizedBox(
                  width: 300,
                  child: Text(
                    option[widget.label].toString(),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            )
            .toList();

        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                capitalizar(widget.label),
                style: const TextStyle(color: Colors.blue, fontSize: 17), // Customize the style as needed
              ),
              DropdownButton<String>(
                hint: Text(widget.valorSeleccionado ?? 'Seleccione una opcion'),
                value: selectedItem,
                items: dropdownItems,
                onChanged: (String? selectedValue) {
                  selectedItem = selectedValue;
                  widget.onChanged.call(selectedItem.toString());
                  setState(() {});
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
