import 'package:payflow_flutter/models/bill_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BillListController {
  List<BillModel> bills = <BillModel>[];

  Future<void> getBills() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final response = instance.getStringList("bills") ?? <String>[];
      bills = response.map((e) => BillModel.fromJson(e)).toList();
    } catch (e) {
      bills = <BillModel>[];
    }
  }
}
