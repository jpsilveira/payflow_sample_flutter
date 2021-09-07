import 'package:flutter/cupertino.dart';
import 'package:payflow_flutter/shared/widgets/bill_list/bill_list_controller.dart';
import 'package:payflow_flutter/shared/widgets/bill_tile/bill_tile_widget.dart';

class BillListWidget extends StatefulWidget {
  const BillListWidget({Key? key}) : super(key: key);

  @override
  _BillListWidgetState createState() => _BillListWidgetState();
}

class _BillListWidgetState extends State<BillListWidget> {
  final billListController = BillListController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          billListController.bills.map((e) => BillTileWidget(data: e)).toList(),
    );
  }
}
