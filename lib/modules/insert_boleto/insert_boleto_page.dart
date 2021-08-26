import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow_flutter/modules/insert_boleto/insert_boleto_controller.dart';
import 'package:payflow_flutter/shared/themes/app_colors.dart';
import 'package:payflow_flutter/shared/themes/app_text.dart';
import 'package:payflow_flutter/shared/widgets/input_text/input_text_widget.dart';
import 'package:payflow_flutter/shared/widgets/set_label_buttons/set_label_buttons.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;
  const InsertBoletoPage({Key? key, this.barcode}) : super(key: key);

  @override
  State<InsertBoletoPage> createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final insertBoletoController = InsertBoletoController();

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
      body: Padding(
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
              key: insertBoletoController.formKey,
              child: Column(
                children: [
                  InputTextWidget(
                    label: 'Nome do boleto',
                    icon: Icons.description_outlined,
                    onChanged: (value) {},
                    validator: insertBoletoController.validateName,
                  ),
                  InputTextWidget(
                    textEditingController: dueDateInputTextController,
                    label: 'Vencimento',
                    icon: FontAwesomeIcons.timesCircle,
                    onChanged: (value) {},
                    validator: insertBoletoController.validateDueDate,
                  ),
                  InputTextWidget(
                    textEditingController: moneyInputTextController,
                    label: 'Valor',
                    icon: FontAwesomeIcons.wallet,
                    onChanged: (value) {},
                    validator: (_) => insertBoletoController
                        .validateMoney(moneyInputTextController.numberValue),
                  ),
                  InputTextWidget(
                    textEditingController: barcodeInputTextController,
                    label: 'Código',
                    icon: FontAwesomeIcons.barcode,
                    onChanged: (value) {},
                    validator: insertBoletoController.validateBarcode,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SetLabelButtons(
        enableSecondaryColor: true,
        primaryLabel: 'Cancelar',
        primaryOnPressed: () {
          Navigator.pop(context);
        },
        secondaryLabel: 'Cadastrar',
        secondaryOnPressed: () {
          insertBoletoController.createBoleto();
        },
      ),
    );
  }
}
