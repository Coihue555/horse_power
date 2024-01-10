import 'package:equatable/equatable.dart';

class ItemModel extends Equatable {
  const ItemModel({
    this.idItem = '',
    this.descripcionItem = '',
  });

  final String idItem;
  final String descripcionItem;

  @override
  List<Object?> get props => [
        idItem,
      ];
}
