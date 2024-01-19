import 'package:flutter/material.dart';
import 'package:horse_power/utils/utils.dart';

class DynamicDropDown extends StatefulWidget {
  const DynamicDropDown({
    Key? key,
    required this.label,
    required this.lstItems,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final Future<List<dynamic>> lstItems;
  final Function(String) onChanged;

  @override
  State<DynamicDropDown> createState() => _DynamicDropDownState();
}

class _DynamicDropDownState extends State<DynamicDropDown> {
  Object? selectedItem;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: widget.lstItems,
      builder: (context, snapshot) {
        List<DropdownMenuItem<Object>> dropdownItems = (snapshot.data ?? <DropdownMenuItem<Object>>[])
            .map<DropdownMenuItem<Object>>(
              (dynamic option) => DropdownMenuItem<Object>(
                value: option['uid'],
                child: SizedBox(
                  width: 300,
                  child: Text(option[widget.label].toString()),
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
              DropdownButton<Object>(
                hint: const Text('Seleccione una opcion'),
                value: selectedItem,
                items: dropdownItems,
                onChanged: (Object? selectedValue) {
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
