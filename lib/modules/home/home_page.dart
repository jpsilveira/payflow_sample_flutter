import 'package:flutter/material.dart';
import 'package:payflow_flutter/models/user_model.dart';
import 'package:payflow_flutter/modules/extract/extract_page.dart';
import 'package:payflow_flutter/modules/my_bills/my_bills_page.dart';
import 'package:payflow_flutter/shared/themes/app_colors.dart';
import 'package:payflow_flutter/shared/themes/app_text.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = HomeController();
  // final pages = [
  //   MyBillsPage(
  //     key: UniqueKey(),
  //   ),
  //   ExtractPage(
  //     key: UniqueKey(),
  //   ),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152),
        child: Container(
          height: 152,
          color: AppColors.primary,
          child: Center(
            child: ListTile(
              title: Text.rich(
                TextSpan(
                  text: "Olá, ",
                  style: AppText.titleRegular,
                  children: [
                    TextSpan(
                      text: "${widget.user.name}",
                      style: AppText.titleBoldBackground,
                    )
                  ],
                ),
              ),
              subtitle: Text(
                "Mantenha suas contas em dia",
                style: AppText.captionShape,
              ),
              trailing: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(widget.user.photoURL!),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: [
        MyBillsPage(
          key: UniqueKey(),
        ),
        ExtractPage(
          key: UniqueKey(),
        ),
      ][homeController.currentPage],
      bottomNavigationBar: Container(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                homeController.setPage(0);
                setState(() {});
              },
              icon: Icon(Icons.home),
              color: homeController.currentPage == 0
                  ? AppColors.primary
                  : AppColors.body,
            ),
            GestureDetector(
              onTap: () async {
                await Navigator.pushNamed(context, "/barcode_scanner");
                setState(() {});
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/barcode_scanner");
                  },
                  icon: Icon(Icons.add_box_outlined),
                  color: AppColors.background,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                homeController.setPage(1);
              },
              icon: Icon(Icons.description_outlined),
              color: homeController.currentPage == 1
                  ? AppColors.primary
                  : AppColors.body,
            ),
          ],
        ),
      ),
    );
  }
}
