import 'package:flutter/material.dart';
import 'package:payflow_flutter/models/bill_model.dart';
import 'package:payflow_flutter/shared/themes/app_text.dart';

class BillTileWidget extends StatelessWidget {
  final BillModel data;
  const BillTileWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 0,
        bottom: 0,
      ),
      title: Text(
        data.name!,
        style: AppText.titleListTile,
      ),
      subtitle: Text(
        "Vence em ${data.dueDate}",
        style: AppText.captionBody,
      ),
      trailing: Text.rich(
        TextSpan(
          text: "R\$ ",
          style: AppText.trailingRegular,
          children: [
            TextSpan(
              text: "${data.value!.toStringAsFixed(2)}",
              style: AppText.trailingBold,
            ),
          ],
        ),
      ),
    );
    // stopped here 012158
  }
}
