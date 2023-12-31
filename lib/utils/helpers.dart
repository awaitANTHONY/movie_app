import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get_storage/get_storage.dart';
import '/consts/consts.dart';
import 'dart:math' as math;

getHeight(context, percentage) {
  double height = MediaQuery.of(context).size.height;
  return height * percentage / 100;
}

getWidth(context, percentage) {
  double width = MediaQuery.of(context).size.width;
  return width * percentage / 100;
}

launchURL(url) async {
  Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    dd('Could not launch $uri');
  }
}

showToast(String message, [ToastGravity gravity = ToastGravity.BOTTOM]) {
  if (message != '') {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.grey.shade800,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}

Color drawerImageBGColorGetter(String image) {
  Map<String, Color> imageBGColor = {
    AppAssets.notification: HexColor('E3DDD6'),
    AppAssets.refresh: HexColor('DDEAF1'),
    AppAssets.vibration: HexColor('DDEEEF'),
    AppAssets.help: HexColor('F1E2E3'),
    AppAssets.privacy: HexColor('E5E6F7'),
    AppAssets.review: HexColor('E5EAE0'),
    AppAssets.terms: HexColor('E3EAF4'),
    AppAssets.shareDrawer: HexColor('F0DEF1'),
  };

  return imageBGColor[image] ?? AppColors.background;
}

showSnackBar(String message, [callback, int duration = 5]) {
  if (!kDebugMode && message == 'Server error! Please try again.') {
    return;
  }
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: Colors.grey[800],
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: duration),
    action: callback != null
        ? SnackBarAction(
            label: 'Refresh',
            textColor: Colors.white,
            onPressed: () {
              ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
              callback();
            },
          )
        : null,
  );

  ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
}

datePicker(
    {required DateTime initialDate,
    required Null Function(DateTime date) onChange}) async {
  final DateTime? date = await showDatePicker(
    context: Get.context!,
    initialDate: initialDate,
    firstDate: DateTime.now().add(const Duration(days: -30)),
    lastDate: DateTime.now().add(const Duration(days: 30)),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: AppColors.primary,
          colorScheme: ColorScheme.light(
            primary: Theme.of(context).primaryColor,
          ),
          buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        child: child!,
      );
    },
  );

  if (date != null) {
    onChange(date);
  }
}

double turnDegress(double degree) {
  return degree * math.pi / 180;
}

Widget cachedNetworkImage(
  String imageUrl, {
  double? height = double.infinity,
  double? width = double.infinity,
  BoxFit fit = BoxFit.fill,
  Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder,
  Widget Function(BuildContext, String, DownloadProgress)?
      progressIndicatorBuilder,
  Widget Function(BuildContext, String, dynamic)? errorWidget,
  Widget Function(BuildContext, String)? placeholder,
  bool hide = true,
}) {
  // return Image.asset(
  //   'assets/images/default-team.png',
  //   height: height,
  //   width: width,
  //   fit: fit,
  // );

  return CachedNetworkImage(
    imageUrl: imageUrl,
    height: height,
    width: width,
    fit: fit,
    imageBuilder: imageBuilder,
    errorWidget: errorWidget ??
        (context, url, error) {
          dd(url);
          return Center(
            child: Image.asset(
              'assets/images/default.png',
              height: height,
              width: width,
              fit: fit,
            ),
          );
        },
    // progressIndicatorBuilder: progressIndicatorBuilder ?? null,
    placeholder: placeholder ??
        (context, url) {
          return SizedBox(
            height: height,
            width: width,
            child: Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ),
            ),
          );
        },
  );
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  var text = htmlText
      .replaceAll(exp, '')
      .replaceAll('\n', '')
      .replaceAll('&#8217;', '')
      .replaceAll('&#8220;', '')
      .replaceAll('&#8211;', '');

  if (!settingController.enableDownload.value) {
    return text.replaceAll('Download', '').replaceAll('DOWNLOAD LINKS', '');
  }

  return text;
}

double random(double min, double max) {
  return min + Random().nextDouble() * (max - min);
}

initNotification({required Null Function(RemoteMessage message) onOpen}) async {
  dd('initNotification');

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    dd('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    dd('User granted provisional permission');
  } else {
    dd('User declined or has not accepted permission');
  }

  //dd(await FirebaseMessaging.instance.getToken());
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    onOpen(message);
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    dd(message.notification?.title);
  });
}

Future<String> getToken() {
  return Future.value('');
}

readStorage(key) {
  var box = GetStorage();
  return box.read(key);
}

writeStorage(key, value) {
  var box = GetStorage();
  box.write(key, value);
}

dd(object) {
  if (kDebugMode) {
    print(object);
  }
}
