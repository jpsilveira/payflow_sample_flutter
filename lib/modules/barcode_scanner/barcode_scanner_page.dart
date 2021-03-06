import 'package:flutter/material.dart';
import 'package:payflow_flutter/modules/barcode_scanner/barcode_scanner_controller.dart';
import 'package:payflow_flutter/modules/barcode_scanner/barcode_scanner_status.dart';
import 'package:payflow_flutter/shared/bottom_sheet_widget/bottom_sheet_widget.dart';
import 'package:payflow_flutter/shared/themes/app_colors.dart';
import 'package:payflow_flutter/shared/themes/app_text.dart';
import 'package:payflow_flutter/shared/widgets/set_label_buttons/set_label_buttons.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final barcodeScannerController = BarcodeScannerController();

  @override
  void initState() {
    barcodeScannerController.getAvailableCameras();
    barcodeScannerController.statusNotifier.addListener(() {
      if (barcodeScannerController.status.hasBarcode) {
        Navigator.pushReplacementNamed(context, "/insert_bill",
            arguments: barcodeScannerController.status.barcode);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    barcodeScannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: barcodeScannerController.statusNotifier,
            builder: (_, status, __) {
              if (status.showCamera) {
                return Container(
                  child:
                      barcodeScannerController.cameraController!.buildPreview(),
                );
              } else {
                return Container();
              }
            },
          ),
          RotatedBox(
            quarterTurns: 1,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  "Escaneie o c??digo de barras do boleto",
                  style: AppText.buttonBackground,
                ),
                centerTitle: true,
                leading: BackButton(
                  color: AppColors.background,
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.black.withOpacity(0.6),
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
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: SetLabelButtons(
                primaryLabel: "Inserir c??digo do boleto",
                primaryOnPressed: () {
                  Navigator.pushReplacementNamed(context, "/insert_bill");
                },
                secondaryLabel: "Adicionar da galeria",
                secondaryOnPressed: () {},
              ),
            ),
          ),
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: barcodeScannerController.statusNotifier,
            builder: (_, status, __) {
              if (status.hasError) {
                return BottomSheetWidget(
                  title: "N??o foi poss??vel identificar um c??digo de barras.",
                  subtitle:
                      "Tente escanear novamente ou digite o c??digo do seu boleto.",
                  primaryLabel: "Escanear novamente",
                  primaryOnPressed: () {
                    barcodeScannerController.scanWithCamera();
                  },
                  secondaryLabel: "Digitar c??digo",
                  secondaryOnPressed: () {
                    Navigator.pushReplacementNamed(context, "/insert_bill");
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
