import 'package:flutter/material.dart';
import 'package:payflow_flutter/models/bill_model.dart';
import 'package:payflow_flutter/shared/themes/app_colors.dart';
import 'package:payflow_flutter/shared/themes/app_text.dart';
import 'package:payflow_flutter/shared/widgets/bill_info/bill_info_widget.dart';
import 'package:payflow_flutter/shared/widgets/bill_list/bill_list_controller.dart';
import 'package:payflow_flutter/shared/widgets/bill_list/bill_list_widget.dart';

class MyBillsPage extends StatefulWidget {
  const MyBillsPage({Key? key}) : super(key: key);

  @override
  State<MyBillsPage> createState() => _MyBillsPageState();
}

class _MyBillsPageState extends State<MyBillsPage> {
  final billListController = BillListController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                color: AppColors.primary,
                height: 40,
                width: double.maxFinite,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ValueListenableBuilder<List<BillModel>>(
                  valueListenable: billListController.billsNotifier,
                  builder: (_, bills, __) => BillInfoWidget(
                    size: bills.length,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 24,
              left: 24,
              right: 24,
            ),
            child: Row(
              children: [
                Text(
                  "Meus Boletos",
                  style: AppText.titleBoldHeading,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 24,
            ),
            child: Divider(
              color: AppColors.stroke,
              thickness: 1,
              height: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BillListWidget(
              billListController: billListController,
            ),
          ),
        ],
      ),
    );
  }
}
