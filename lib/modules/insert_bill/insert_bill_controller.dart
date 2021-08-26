import 'package:flutter/cupertino.dart';

class InsertBillController {
  final formKey = GlobalKey<FormState>();

  String? validateName(String? value) =>
      value?.isEmpty ?? true ? 'O nome do boleto não pode ser vazio.' : null;
  //
  String? validateMoney(double value) =>
      value <= 0 ? 'Insira um valor maior que R\$ 0,00.' : null;
  //
  String? validateBarcode(String? value) {
    if (value?.isEmpty == true) {
      return 'O código não pode ser vazio.';
    }
    int valueSize = value?.length ?? 0;
    if (valueSize < 44 || valueSize > 48) {
      return 'O código deve possuir entre 44 e 48 dígitos.';
    }
  }

  //
  String? validateDueDate(String? value) {
    if (value?.isEmpty == true) {
      return 'A data de vencimento não pode ser vazia.';
    }

    value = value ?? '01/01/1900';
    DateTime testDate = DateTime.parse(
        value.substring(6, 10) + value.substring(3, 5) + value.substring(0, 2));

    String myDate = testDate.day.toString() +
        '/' +
        testDate.month.toString() +
        '/' +
        testDate.year.toString();

    if (value != myDate) {
      return 'Data de vencimento inválida.';
    }
    return null;
  }

  void onChange() {
    //Stopped here 010557
  }

  void createBill() {
    final form = formKey.currentState;
    if (form!.validate()) {
      return null;
    }
  }
}
