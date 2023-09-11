import 'dart:io';

import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:get/get.dart';
import '/views/dialogs/no_restore_products.dart';
import '/controllers/setting_controller.dart';
import '/services/inapp_purchase_service.dart';
import '/utils/helpers.dart';
import '/views/screens/parent_screen.dart';

class SubscriptionController extends GetxController {
  SettingController settingController = Get.find();
  RxList<IAPItem> products = <IAPItem>[].obs;
  RxList<PurchasedItem> restoreProducts = <PurchasedItem>[].obs;
  final List<String> _productLists = Platform.isAndroid
      ? [
          'monthly_subscription',
        ]
      : ['monthly_subscription'];
  RxBool isloading = false.obs;
  RxBool isloading2 = false.obs;

  requestPurchase(IAPItem item) {
    isloading.value = true;
    InAppPurchaseService.requestPurchase(item);
  }

  onPurchase() {
    settingController.isSubscribed.value = true;
    Get.offAll(() => const ParentScreen());
    isloading.value = false;
    writeStorage('isRestore', false);
    writeStorage('isCheckRequired', true);
    showToast('Purchase Successfull.');
  }

  requestRestore() async {
    isloading2.value = true;
    restoreProducts.value = await InAppPurchaseService.requestRestore();
    isloading2.value = false;
    if (restoreProducts.isEmpty) {
      noRestoreProductsDialog();
    } else {
      writeStorage('isRestore', true);
      writeStorage('isCheckRequired', true);
      Get.offAll(() => const ParentScreen());
      showToast('Restore Purchase Successfull.');
    }
  }

  @override
  void onInit() {
    super.onInit();

    InAppPurchaseService.init(_productLists);
  }
}
