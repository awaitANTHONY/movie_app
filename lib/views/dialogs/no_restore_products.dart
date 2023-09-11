import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/consts/consts.dart';

noRestoreProductsDialog() {
  Future.delayed(Duration.zero, () {
    BuildContext context = Get.context!;
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return NewWidget(context: context);
        });
  });
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.size.width - 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Material(
            color: AppColors.background2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                          width: 0.3,
                        ),
                      ),
                    ),
                    child: Text(
                      'Purchase Status'.tr,
                      style: AppStyles.heading.copyWith(
                        fontSize: AppSizes.size18,
                        color: AppColors.text,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text(
                      'There are no restorable purchases. Only previously bought non-consumable products and auto-renewable subscriptions Can be restored.'
                          .tr,
                      style: AppStyles.heading.copyWith(
                        fontSize: AppSizes.size15,
                        color: AppColors.text,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      border: Border(
                        top: BorderSide(
                          color: AppColors.text,
                          width: 0.3,
                        ),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        'OK, Got It'.tr,
                        style: AppStyles.heading.copyWith(
                          fontSize: AppSizes.size18,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
