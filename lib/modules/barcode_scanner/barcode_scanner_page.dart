import 'package:flutter/material.dart';
import 'package:payflow_flutter/shared/themes/app_colors.dart';
import 'package:payflow_flutter/shared/themes/app_text.dart';
import 'package:payflow_flutter/shared/widgets/label_button/label_button.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Escaneie o código de barras do boleto",
          style: AppText.buttonBackground,
        ),
        leading: BackButton(
          color: AppColors.background,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.black,
            ),
          ),
        ],
      ),
      bottomNavigationBar: LabelButton(
        label: "Inserir código do boleto",
        onPressed: () {},
      ),
    );
  }
}
