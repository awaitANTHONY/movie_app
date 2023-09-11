import 'dart:async';
import 'dart:io';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '/controllers/subscription_controller.dart';
import '/controllers/setting_controller.dart';
import '/utils/helpers.dart';

class InAppPurchaseService {
  InAppPurchaseService._();

  static int _numLoadAttempts = 3;
  static SettingController settingController = Get.find();
  static SubscriptionController subscriptionController = Get.find();

  static late StreamSubscription purchaseUpdatedSubscription;
  static late StreamSubscription purchaseErrorSubscription;
  static late StreamSubscription conectionSubscription;

  static Future<void> init(List<String> productLists) async {
    // prepare
    var result = await FlutterInappPurchase.instance.initialize();
    dd('result: $result');

    // refresh items for android
    try {
      String msg = await FlutterInappPurchase.instance.consumeAll();
      dd('consumeAllItems: $msg');
    } catch (err) {
      dd('consumeAllItems error: $err');
    }

    conectionSubscription =
        FlutterInappPurchase.connectionUpdated.listen((connected) {
      dd('connected: $connected');
    });

    purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen((productItem) {
      dd('purchase-updated: $productItem');

      var box = GetStorage();
      box.write('inapp', productItem!.transactionReceipt);

      _handlePurchaseUpdate(productItem);

      subscriptionController.onPurchase();
    });

    purchaseErrorSubscription =
        FlutterInappPurchase.purchaseError.listen((purchaseError) {
      dd('purchase-error: $purchaseError');

      showToast(purchaseError?.message ?? '');

      subscriptionController.isloading.value = false;
    });

    await Future.delayed(2.seconds);
    getProduct(productLists);
  }

  static Future getProduct(List<String> productLists) async {
    List<IAPItem> items =
        await FlutterInappPurchase.instance.getSubscriptions(productLists);
    List<bool> status = [];
    for (var item in items) {
      subscriptionController.products.add(item);
      try {
        if (readStorage('isCheckRequired') ?? false) {
          status.add(
            await FlutterInappPurchase.instance.checkSubscribed(
              sku: item.productId.toString(),
            ),
          );
        }
      } catch (e) {
        showToast('Please signin apple id for Purchase history');
      }
    }

    if (status.contains(true)) {
      settingController.isSubscribed.value = true;
    } else {
      settingController.isSubscribed.value = false;
    }

    dd(items.length);
    dd(productLists);

    var box = GetStorage();
    bool isRestore = box.read('isRestore') ?? false;

    if (isRestore) {
      List<PurchasedItem> items2 =
          await FlutterInappPurchase.instance.getAvailablePurchases() ?? [];
      if (items2.isNotEmpty) {
        settingController.isSubscribed.value = true;
      }
    }

    if (items.isEmpty && _numLoadAttempts > 0) {
      getProduct(productLists);
      _numLoadAttempts--;
    }
  }

  static requestPurchase(IAPItem item) {
    FlutterInappPurchase.instance.requestPurchase(item.productId!);
  }

  static Future<List<PurchasedItem>> requestRestore() async {
    try {
      List<PurchasedItem> items =
          await FlutterInappPurchase.instance.getAvailablePurchases() ?? [];

      if (items.isNotEmpty) {
        settingController.isSubscribed.value = true;
      } else {
        settingController.isSubscribed.value = false;
      }

      return items;
    } catch (e) {
      subscriptionController.isloading2.value = false;
      //showToast(e.toString());
      return [];
    }
  }

  static void _handlePurchaseUpdate(PurchasedItem productItem) async {
    dd('purchase-updated: $productItem');
    if (Platform.isAndroid) {
      await _handlePurchaseUpdateAndroid(productItem);
    } else {
      await _handlePurchaseUpdateIOS(productItem);
    }
  }

  static Future<void> _handlePurchaseUpdateIOS(
      PurchasedItem purchasedItem) async {
    switch (purchasedItem.transactionStateIOS) {
      case TransactionState.deferred:
        break;
      case TransactionState.failed:
        showToast("Transaction Failed");
        FlutterInappPurchase.instance.finishTransaction(purchasedItem);
        break;
      case TransactionState.purchased:
        await _verifyAndFinishTransaction(purchasedItem);
        break;
      case TransactionState.purchasing:
        break;
      case TransactionState.restored:
        FlutterInappPurchase.instance.finishTransaction(purchasedItem);
        break;
      default:
    }
  }

  static Future<void> _handlePurchaseUpdateAndroid(
      PurchasedItem purchasedItem) async {
    switch (purchasedItem.purchaseStateAndroid) {
      case PurchaseState.purchased:
        if (!purchasedItem.isAcknowledgedAndroid!) {
          await _verifyAndFinishTransaction(purchasedItem);
        }
        break;
      case PurchaseState.pending:
        if (!purchasedItem.isAcknowledgedAndroid!) {
          await _verifyAndFinishTransaction(purchasedItem);
        }
        break;
      default:
        showToast("Transaction Failed");
    }
  }

  static _verifyAndFinishTransaction(PurchasedItem purchasedItem) async {
    bool isValid = false;
    try {
      isValid = await _verifyPurchase(purchasedItem);
    } on Exception {
      showToast("Something went wrong");
      return;
    }

    if (isValid) {
      FlutterInappPurchase.instance.finishTransaction(purchasedItem);
    } else {
      showToast("Varification failed");
    }
  }

  static Future<bool> _verifyPurchase(purchasedItem) {
    return Future.value(true);
  }
}
