import 'package:flutter/material.dart';
import 'package:payflow_flutter/shared/themes/app_colors.dart';
import 'package:payflow_flutter/shared/themes/app_text.dart';
import 'package:payflow_flutter/shared/widgets/bill_info/bill_info_widget.dart';
import 'package:payflow_flutter/shared/widgets/bill_list/bill_list_widget.dart';

class MyBillsPage extends StatefulWidget {
  const MyBillsPage({Key? key}) : super(key: key);

  @override
  State<MyBillsPage> createState() => _MyBillsPageState();
}

class _MyBillsPageState extends State<MyBillsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          BillInfoWidget(size: 14),
          Padding(
            padding: const EdgeInsets.only(top: 24),
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
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Divider(
              color: AppColors.stroke,
              thickness: 1,
              height: 1,
            ),
          ),
          BillListWidget(),
        ],
      ),
    );
  }
}
