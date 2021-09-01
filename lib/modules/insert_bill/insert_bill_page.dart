import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow_flutter/shared/themes/app_colors.dart';
import 'package:payflow_flutter/shared/themes/app_text.dart';
import 'package:payflow_flutter/shared/widgets/input_text/input_text_widget.dart';
import 'package:payflow_flutter/shared/widgets/set_label_buttons/set_label_buttons.dart';

import 'insert_bill_controller.dart';

class InsertBillPage extends StatefulWidget {
  final String? barcode;
  const InsertBillPage({Key? key, this.barcode}) : super(key: key);

  @override
  State<InsertBillPage> createState() => _InsertBillPageState();
}

class _InsertBillPageState extends State<InsertBillPage> {
  final insertBillController = InsertBillController();

  final moneyInputTextController = MoneyMaskedTextController(
    leftSymbol: 'R\$',
    decimalSeparator: ',',
  );
  final dueDateInputTextController = MaskedTextController(
    mask: '00/00/0000',
  );
  final barcodeInputTextController = TextEditingController();

  @override
  void initState() {
    if (widget.barcode != null) {
      barcodeInputTextController.text = widget.barcode!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(
          color: AppColors.input,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 93,
                  // vertical: 24,
                ),
                child: Text(
                  "Preencha os dados do Boleto.",
                  style: AppText.titleBoldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Form(
                key: insertBillController.formKey,
                child: Column(
                  children: [
                    InputTextWidget(
                      label: 'Nome do boleto',
                      icon: Icons.description_outlined,
                      validator: insertBillController.validateName,
                      onChanged: (value) {
                        insertBillController.onChange(name: value);
                      },
                    ),
                    InputTextWidget(
                      textEditingController: dueDateInputTextController,
                      label: 'Vencimento',
                      icon: FontAwesomeIcons.timesCircle,
                      onChanged: (value) {
                        insertBillController.onChange(dueDate: value);
                      },
                      validator: insertBillController.validateDueDate,
                    ),
                    InputTextWidget(
                      textEditingController: moneyInputTextController,
                      label: 'Valor',
                      icon: FontAwesomeIcons.wallet,
                      onChanged: (value) {
                        insertBillController.onChange(
                          value: moneyInputTextController.numberValue,
                        );
                      },
                      validator: (_) => insertBillController
                          .validateMoney(moneyInputTextController.numberValue),
                    ),
                    InputTextWidget(
                      textEditingController: barcodeInputTextController,
                      label: 'Código',
                      icon: FontAwesomeIcons.barcode,
                      onChanged: (value) {
                        insertBillController.onChange(
                          barcode: value,
                        );
                      },
                      validator: insertBillController.validateBarcode,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SetLabelButtons(
        enableSecondaryColor: true,
        primaryLabel: 'Cancelar',
        primaryOnPressed: () {
          Navigator.pop(context);
        },
        secondaryLabel: 'Cadastrar',
        secondaryOnPressed: () async {
          await insertBillController.createBill();
          Navigator.pop(context);
        },
      ),
    );
  }
}
