import 'package:flutter/material.dart';
import 'package:payflow_flutter/shared/themes/app_colors.dart';
import 'package:payflow_flutter/shared/themes/app_image.dart';
import 'package:payflow_flutter/shared/themes/app_text.dart';

class BillInfoWidget extends StatelessWidget {
  final int size;
  const BillInfoWidget({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              AppImages.logomini,
              color: AppColors.background,
              width: 56,
              height: 34,
            ),
            Container(
              width: 1,
              height: 32,
              color: AppColors.background,
            ),
            Text.rich(
              TextSpan(
                  text: "Você tem ",
                  style: AppText.captionBackground,
                  children: [
                    TextSpan(
                      text: "$size bills\n",
                      style: AppText.captionBoldBackground,
                    ),
                    TextSpan(
                      text: "cadastrados para pagar.",
                      style: AppText.captionBackground,
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
    //stopped here 14406
  }
}
