import 'package:flutter/cupertino.dart';
import 'package:payflow_flutter/models/bill_model.dart';
import 'package:payflow_flutter/shared/widgets/bill_list/bill_list_controller.dart';
import 'package:payflow_flutter/shared/widgets/bill_tile/bill_tile_widget.dart';

class BillListWidget extends StatefulWidget {
  final BillListController billListController;
  BillListWidget({Key? key, required this.billListController})
      : super(key: key);

  @override
  _BillListWidgetState createState() => _BillListWidgetState();
}

class _BillListWidgetState extends State<BillListWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<BillModel>>(
      valueListenable: widget.billListController.billsNotifier,
      builder: (_, bills, __) => Column(
        children: bills.map((e) => BillTileWidget(data: e)).toList(),
      ),
    );
  }
}
