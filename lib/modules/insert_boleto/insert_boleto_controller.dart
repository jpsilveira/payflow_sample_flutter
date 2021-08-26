import 'package:flutter/cupertino.dart';

class InsertBoletoController {
  final formKey = GlobalKey<FormState>();

  String? validateName(String? value) =>
      value?.isEmpty ?? true ? 'O nome do boleto não pode ser vazio.' : null;
  String? validateMoney(double value) =>
      value <= 0 ? 'Insira um valor maior que R\$ 0,00.' : null;
  String? validateBarcode(String? value) =>
      value?.isEmpty ?? true ? 'O código não pode ser vazio.' : null;
  // String? validateDueDate(String? value) => value?.isEmpty ?? true
  //     ? 'A data de vencimento não pode ser vazia.'
  //     : null;
  String? validateDueDate(String? value) {
    if (value?.isEmpty == true) {
      return 'A data de vencimento não pode ser vazia.';
    }

    print(value?.substring(6, 4));
    print(value?.substring(0, 2));
    print(value?.substring(3, 2));
    try {
      String myValue = value ?? '01/01/1900';

      DateTime testdate = new DateTime(myValue.substring(6, 4) as int,
          myValue.substring(0, 2) as int, myValue.substring(3, 2) as int);
    } catch (e) {
      return 'Data de vencimento inválida.';
    }

    return null;
  }

  void createBoleto() {
    final form = formKey.currentState;
    if (form!.validate()) {
      return null;
    }
  }
}
