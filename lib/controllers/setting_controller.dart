import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/services/api_services.dart';
import '/consts/consts.dart';
import '/utils/helpers.dart';
import '/views/screens/parent_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '/models/setting.dart';
import 'package:http/http.dart' as http;

class SettingController extends GetxController {
  var client = http.Client();
  RxBool isLoading = true.obs;
  Rx<SettingData> settings = SettingData().obs;
  RxInt adCount = 0.obs;
  RxString adsType = 'google'.obs;
  RxBool adsStatus = true.obs;
  RxString appopenPlacementId = ''.obs;
  RxString bannerPlacementId = ''.obs;
  RxString interstitialPlacementId = ''.obs;
  RxString nativePlacementId = ''.obs;
  RxInt sliderIndex = 0.obs;
  Rxn<PackageInfo> appInfo = Rxn<PackageInfo>().obs();
  RxInt selectedIndex = 0.obs;
  RxInt currentIndex = 0.obs;
  RxBool isDarkMode = false.obs;
  RxBool isNotificationEnable = false.obs;
  RxBool isVibrationEnable = false.obs;
  RxBool isSubscribed = false.obs;
  RxBool enableDownload = true.obs;

  RxList<String> titles = ['Home', 'Menu', 'Top', 'News', 'Settings'].obs;

  onItemTapped(int index) async {
    selectedIndex.value = index;
  }

  loadData() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        String url = AppConsts.settings;
        Map<String, String> headers = {
          'X-API-KEY': AppConsts.apiKey,
        };
        var response = await ApiService.get(
          url,
          headers: headers,
        );

        var jsonString = response.body;
        var responseModel = Setting.fromJson(jsonDecode(jsonString));

        if (responseModel.status == true) {
          store(responseModel);
          await Future.delayed(3.seconds);
          Get.offAll(() => const ParentScreen(page: 0));
        } else {
          showSnackBar('Server Error! Please Try again.');
        }
      } catch (e) {
        showSnackBar(e.toString());
      }
    } else {
      showSnackBar('No internet connection please try again!');
    }
  }

  void store(Setting setting) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    var quickSetting = setting.data!;

    settings.value = setting.data!;

    adsStatus.value = quickSetting.enableAds != '0';
    appopenPlacementId.value = quickSetting.appopenAdCode ?? "";
    bannerPlacementId.value = quickSetting.bannerAdCode ?? "";
    interstitialPlacementId.value = quickSetting.interstitialAdCode ?? "";
    adsStatus.value = quickSetting.enableAds != '0';
    nativePlacementId.value = quickSetting.nativeAdCode ?? "";
    enableDownload.value = quickSetting.enableDownload != '0';
    appInfo.value = packageInfo;

    dd(adsStatus.value);
    dd(appopenPlacementId.value);
    dd(bannerPlacementId.value);
    dd(interstitialPlacementId.value);
    dd(nativePlacementId.value);
    dd(enableDownload.value);
    dd(appInfo);
  }

  bool showAd() {
    var setting = settings.value;

    if (setting.enableAds != '0') {
      adCount.value = adCount.value + 1;
      if (adCount.value == int.parse(setting.interstitialAdClick ?? '5')) {
        adCount.value = 0;
        return true;
      } else {}
    }
    return false;
  }

  // void checkVersion() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();

  //   var versionCode = packageInfo.buildNumber;
  //   var settings = _settingController.settings.value;

  //   var apiVersionCode;
  //   var forceUpdate;
  //   var versionName;
  //   var message;
  //   var buttomText;
  //   var actionUrl;

  //   if (Platform.isAndroid) {
  //     apiVersionCode = int.parse(settings.androidVersionCode ?? '1');
  //     forceUpdate = settings.androidForceUpdate ?? 'no';
  //     versionName = settings.androidVersionName ?? '';
  //     message = settings.androidDescription ?? '';
  //     buttomText = settings.androidButtonText ?? '';
  //     actionUrl = settings.androidAppUrl ?? '';
  //   } else {
  //     apiVersionCode = int.parse(settings.iosVersionCode ?? '1');
  //     forceUpdate = settings.iosForceUpdate ?? 'no';
  //     versionName = settings.iosVersionName ?? '';
  //     message = settings.iosDescription ?? '';
  //     buttomText = settings.iosButtonText ?? '';
  //     actionUrl = settings.iosAppUrl ?? '';
  //   }

  //   if (apiVersionCode > int.parse(versionCode)) {
  //     updateDailog(
  //       context,
  //       forceUpdate: forceUpdate,
  //       versionName: versionName,
  //       message: message,
  //       buttomText: buttomText,
  //       actionUrl: actionUrl,
  //     );
  //   } else {
  //     // Get.offAll(
  //     //   () => PreParentScreen(page: 0),
  //     // );
  //   }
  // }

  changeTheme() {
    var box = GetStorage();
    box.write('isDarkMode', !isDarkMode.value);
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  changeNotificationStatus() async {
    var box = GetStorage();
    box.write('isNotificationEnable', !isNotificationEnable.value);
    isNotificationEnable.value = !isNotificationEnable.value;
    notificationStatus(isNotificationEnable.value);
  }

  notificationStatus(bool status) async {
    if (status) {
      await FirebaseMessaging.instance
          .subscribeToTopic('high_importance_channel');
    } else {
      await FirebaseMessaging.instance
          .unsubscribeFromTopic('high_importance_channel');
    }
  }

  changeVibrationStatus() async {
    var box = GetStorage();
    box.write('isVibrationEnable', !isVibrationEnable.value);
    vibration();
    isVibrationEnable.value = !isVibrationEnable.value;
  }

  vibration() {
    if (isNotificationEnable.value) HapticFeedback.vibrate();
  }

  @override
  void onInit() {
    isDarkMode.value = readStorage('isDarkMode') ?? false;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);

    isNotificationEnable.value = readStorage('isNotificationEnable') ?? false;
    //notificationStatus(isNotificationEnable.value);

    super.onInit();
    loadData();
  }
}
