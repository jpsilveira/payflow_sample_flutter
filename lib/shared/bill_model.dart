import 'dart:convert';

class BillModel {
  final String? name;
  final String? dueDate;
  final double? value;
  final String? barcode;

  String toJson() => json.encode(toMap());

  // factory BillModel.fromJson(String source) => BillModel.fromMap(Map<String, dynamic>);

//<editor-fold desc="Data Methods">

  const BillModel({
    this.name,
    this.dueDate,
    this.value,
    this.barcode,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          dueDate == other.dueDate &&
          value == other.value &&
          barcode == other.barcode);

  @override
  int get hashCode =>
      name.hashCode ^ dueDate.hashCode ^ value.hashCode ^ barcode.hashCode;

  @override
  String toString() {
    return 'BillModel{' +
        ' name: $name,' +
        ' dueDate: $dueDate,' +
        ' value: $value,' +
        ' barcode: $barcode,' +
        '}';
  }

  BillModel copyWith({
    String? name,
    String? dueDate,
    double? value,
    String? barcode,
  }) {
    return BillModel(
      name: name ?? this.name,
      dueDate: dueDate ?? this.dueDate,
      value: value ?? this.value,
      barcode: barcode ?? this.barcode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'dueDate': this.dueDate,
      'value': this.value,
      'barcode': this.barcode,
    };
  }

  factory BillModel.fromMap(Map<String, dynamic> map) {
    return BillModel(
      name: map['name'] as String,
      dueDate: map['dueDate'] as String,
      value: map['value'] as double,
      barcode: map['barcode'] as String,
    );
  }

//</editor-fold>
}
