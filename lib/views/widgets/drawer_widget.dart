// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:share_plus/share_plus.dart';

// import '../../consts/consts.dart';
// import '../../utils/helpers.dart';
// import '../widgets/custom_switch.dart';

// class AppDrawer extends StatefulWidget {
//   const AppDrawer({super.key});

//   @override
//   State<AppDrawer> createState() => _AppDrawerState();
// }

// class _AppDrawerState extends State<AppDrawer> with TickerProviderStateMixin {
//   privacy() => launchURL(settingController.settings.value.privacyPolicy);
//   terms() => launchURL(settingController.settings.value.termsConditions);
//   help() => launchURL('');
//   rate() async {
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();
//     if (GetPlatform.isAndroid) {
//       launchURL(
//           'https://play.google.com/store/apps/details?id=${packageInfo.packageName}');
//     } else {
//       launchURL(
//           'https://play.google.com/store/apps/details?id=${packageInfo.packageName}');
//     }
//   }

//   share() async {
//     Share.share(
//         'Please install this app and watch matches online , AppLink : ${settingController.settings.value.privacyPolicy}',
//         subject: 'Turbo Football');
//   }

//   static const Duration _initialDelayTime = Duration(milliseconds: 50);
//   static const Duration _itemSlideTime = Duration(milliseconds: 250);
//   static const Duration _staggerTime = Duration(milliseconds: 50);
//   static const Duration _buttonDelayTime = Duration(milliseconds: 150);
//   static const Duration _buttonTime = Duration(milliseconds: 500);
//   final Duration _animationDuration =
//       _initialDelayTime + (_staggerTime * 12) + _buttonDelayTime + _buttonTime;

//   late AnimationController? _staggeredController;
//   final List<Interval> _itemSlideIntervals = [];
//   late Interval buttonInterval;

//   List<Widget> drawerWidgets = [];
//   @override
//   void initState() {
//     super.initState();

//     drawerWidgets = [
//       Image.asset(
//         'assets/images/logo.png',
//         height: AppSizes.newSize(4),
//       ),
//       SizedBox(height: AppSizes.newSize(4)),
//       Text(
//         "Settings",
//         style: TextStyle(
//           fontSize: AppSizes.size14,
//           fontWeight: FontWeight.w700,
//           color: Colors.black,
//         ),
//       ),
//       const DrawerWidget("Push Notification", AppAssets.notification),
//       const DrawerWidget("Auto Refresh", AppAssets.refresh),
//       const DrawerWidget("Vibration", AppAssets.vibration),
//       SizedBox(height: AppSizes.newSize(2)),
//       Text(
//         "Info",
//         style: TextStyle(
//           fontSize: AppSizes.size14,
//           fontWeight: FontWeight.w700,
//           color: Colors.black,
//         ),
//       ),
//       DrawerWidget("Privacy Policy", AppAssets.privacy, ontap: privacy),
//       DrawerWidget("Rate", AppAssets.review, ontap: rate),
//       DrawerWidget("Terms of Use", AppAssets.terms, ontap: terms),
//       DrawerWidget("Share App", AppAssets.shareDrawer, ontap: share),
//     ];

//     _createAnimationIntervals();
//     _staggeredController =
//         AnimationController(vsync: this, duration: _animationDuration)
//           ..forward();
//   }

//   @override
//   void dispose() {
//     _staggeredController?.dispose();
//     super.dispose();
//   }

//   void _createAnimationIntervals() {
//     for (var i = 0; i < drawerWidgets.length; ++i) {
//       final startTime = _initialDelayTime + (_staggerTime * i);
//       final endTime = startTime + _itemSlideTime;
//       _itemSlideIntervals.add(
//         Interval(
//           startTime.inMilliseconds / _animationDuration.inMilliseconds,
//           endTime.inMilliseconds / _animationDuration.inMilliseconds,
//         ),
//       );
//     }

//     final buttonStartTime =
//         Duration(milliseconds: (drawerWidgets.length * 50)) + _buttonDelayTime;
//     final buttonEndTime = buttonStartTime + _buttonTime;
//     buttonInterval = Interval(
//       buttonStartTime.inMilliseconds / _animationDuration.inMilliseconds,
//       buttonEndTime.inMilliseconds / _animationDuration.inMilliseconds,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ClipPath(
//       clipper: _DrawerClipper(),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(
//           sigmaX: 8,
//           sigmaY: 3,
//           tileMode: TileMode.clamp,
//         ),
//         child: Drawer(
//           backgroundColor: Colors.white.withOpacity(.8),
//           width: AppSizes.newSize(40),
//           child: Padding(
//             padding: EdgeInsets.only(left: 20.0, right: AppSizes.newSize(5)),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: AppSizes.newSize(10)),
//                 ...animatedDrawer(),
//                 const Spacer(),
//                 Row(
//                   children: [
//                     Text(
//                       "All rights reserved by",
//                       style: TextStyle(
//                         fontSize: AppSizes.size13,
//                         fontWeight: FontWeight.normal,
//                         color: Colors.black,
//                       ),
//                     ),
//                     Text(
//                       " ${AppTexts.appName}",
//                       style: TextStyle(
//                         fontSize: AppSizes.size15,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: AppSizes.newSize(4)),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   List<Widget> animatedDrawer() {
//     final widgets = <Widget>[];
//     for (var item in drawerWidgets) {
//       widgets.add(
//         AnimatedBuilder(
//           animation: _staggeredController!,
//           builder: (context, child) {
//             final animationPercent = Curves.easeOut.transform(
//               _itemSlideIntervals[drawerWidgets.indexOf(item)]
//                   .transform(_staggeredController!.value),
//             );
//             final opacity = animationPercent;
//             final slideDistance = (1.0 - animationPercent) * 150;

//             return Opacity(
//               opacity: opacity,
//               child: Transform.translate(
//                 offset: Offset(slideDistance, 0),
//                 child: child,
//               ),
//             );
//           },
//           child: item,
//         ),
//       );
//     }

//     return widgets;
//   }
// }

// class DrawerWidget extends StatelessWidget {
//   const DrawerWidget(this.text, this.image, {this.ontap, super.key});
//   final String text;
//   final String image;
//   final VoidCallback? ontap;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5.0),
//       child: InkWell(
//         onTap: ontap,
//         child: Container(
//           margin: const EdgeInsets.symmetric(vertical: 4),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: drawerImageBGColorGetter(image),
//                   shape: BoxShape.circle,
//                 ),
//                 padding: const EdgeInsets.all(4).copyWith(left: 8),
//                 child: Center(
//                   child: Image.asset(
//                     image,
//                     alignment: Alignment.center,
//                     height: AppSizes.newSize(4),
//                     width: AppSizes.newSize(4),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 flex: 4,
//                 child: Row(
//                   children: [
//                     Text(
//                       text.tr,
//                       style: TextStyle(
//                         fontSize: AppSizes.size14,
//                         color: Colors.black.withOpacity(.8),
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Builder(
//                   builder: (context) {
//                     if (ontap != null) {
//                       return const Icon(
//                         Icons.arrow_forward_ios_outlined,
//                         color: Colors.black,
//                       );
//                     }
//                     if (text == "Push Notification") {
//                       return ObxValue(
//                         (data) => SizedBox(
//                           height: AppSizes.newSize(1),
//                           child: FittedBox(
//                             fit: BoxFit.fitWidth,
//                             child: CustomSwitch(
//                               activeColor: AppColors.primary,
//                               value:
//                                   settingController.isNotificationEnable.value,
//                               onChanged: (val) {
//                                 settingController.changeNotificationStatus();
//                               },
//                             ),
//                           ),
//                         ),
//                         false.obs,
//                       );
//                     }

//                     if (text == "Vibration") {
//                       return ObxValue(
//                         (data) => SizedBox(
//                           height: AppSizes.newSize(1),
//                           child: FittedBox(
//                             fit: BoxFit.fitWidth,
//                             child: CustomSwitch(
//                               activeColor: AppColors.primary,
//                               value: settingController.isVibrationEnable.value,
//                               onChanged: (val) {
//                                 settingController.changeVibrationStatus();
//                               },
//                             ),
//                           ),
//                         ),
//                         false.obs,
//                       );
//                     }
//                     return const SizedBox();
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _DrawerClipper extends CustomClipper<Path> {
//   var radius = 10.0;
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.moveTo(0, size.height);
//     path.lineTo(size.width, size.height);
//     path.lineTo(size.width * .9, 0);
//     path.lineTo(0, 0);
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import '../../consts/consts.dart';
import '../../utils/helpers.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> with TickerProviderStateMixin {
  List<Widget> drawerWidgets = [];
  @override
  void initState() {
    super.initState();
    drawerWidgets = [
      SizedBox(height: AppSizes.newSize(1)),
      Text(
        "Settings",
        style: TextStyle(
          fontSize: AppSizes.size14,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      const DrawerWidget("Push Notification", AppAssets.notification),
      const DrawerWidget("Vibration", AppAssets.vibration),
      SizedBox(height: AppSizes.newSize(2)),
      Text(
        "Others",
        style: TextStyle(
          fontSize: AppSizes.size14,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      DrawerWidget(
        "Privacy Policy",
        AppAssets.privacy,
        onTap: () {
          launchURL(settingController.settings.value.privacyPolicy);
        },
      ),
      DrawerWidget(
        "Rate",
        AppAssets.review,
        onTap: () async {
          if (GetPlatform.isAndroid) {
            PackageInfo packageInfo = await PackageInfo.fromPlatform();
            launchURL(
                'https://play.google.com/store/apps/details?id=${packageInfo.packageName}');
          } else {
            launchURL(settingController.settings.value.privacyPolicy);
          }
        },
      ),
      DrawerWidget(
        "Terms of Use",
        AppAssets.terms,
        onTap: () {
          launchURL(settingController.settings.value.termsConditions);
        },
      ),
      Builder(builder: (context) {
        return DrawerWidget(
          "Share App",
          AppAssets.shareDrawer,
          onTap: () async {
            final box = context.findRenderObject() as RenderBox?;

            await Share.share(
              'Watch for NetNaija Movies',
              subject: AppTexts.appName,
              sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
            );
          },
        );
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
          tileMode: TileMode.clamp,
        ),
        child: Drawer(
          backgroundColor: AppColors.background.withOpacity(0.4),
          width: AppSizes.newSize(38),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSizes.newSize(2),
                      horizontal: AppSizes.newSize(2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: AppSizes.newSize(8),
                              width: AppSizes.newSize(8),
                            ),
                          ),
                        ),
                        ...drawerWidgets.animate().fade().scale().move(
                              delay: 300.ms,
                              duration: 600.ms,
                            ),
                      ],
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "All rights reserved by",
                      style: TextStyle(
                        fontSize: AppSizes.size13,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      " © ${AppTexts.appName}",
                      style: TextStyle(
                        fontSize: AppSizes.size15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.newSize(4)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget(this.text, this.image, {this.onTap, super.key});
  final String text;
  final String image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.newSize(0.8)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: AppSizes.newSize(0.6)),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(4).copyWith(left: 10),
                child: Center(
                  child: Image.asset(
                    image,
                    alignment: Alignment.center,
                    height: AppSizes.newSize(3),
                    width: AppSizes.newSize(3),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Text(
                      text.tr,
                      style: TextStyle(
                        fontSize: AppSizes.size14,
                        color: Colors.white.withOpacity(.8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.newSize(1)),
                  child: Builder(
                    builder: (context) {
                      if (onTap != null) {
                        return Padding(
                          padding: EdgeInsets.only(left: AppSizes.newSize(4)),
                          child: Icon(
                            Icons.double_arrow_rounded,
                            size: 14,
                            color: Colors.white.withOpacity(.8),
                          ),
                        );
                      }
                      if (text == "Push Notification") {
                        return ObxValue(
                          (data) => SizedBox(
                            height: AppSizes.newSize(1),
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: FlutterSwitch(
                                width: AppSizes.newSize(5.4),
                                height: AppSizes.newSize(2.2),
                                valueFontSize: AppSizes.size12,
                                toggleSize: 10.0,
                                value: settingController
                                    .isNotificationEnable.value,
                                borderRadius: 30.0,
                                padding: 2,
                                toggleBorder: Border.all(
                                  color: Colors.white,
                                  width: 1.0,
                                ),
                                showOnOff: true,
                                activeTextColor: AppColors.background2,
                                inactiveToggleColor: Colors.white,
                                inactiveTextColor: Colors.white,
                                activeColor: AppColors.primary,
                                inactiveColor: AppColors.background2,
                                onToggle: (val) {
                                  settingController.changeNotificationStatus();
                                },
                              ),
                            ),
                          ),
                          false.obs,
                        );
                      }
                      if (text == "Vibration") {
                        return ObxValue(
                          (data) => SizedBox(
                            height: AppSizes.newSize(1),
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: FlutterSwitch(
                                width: AppSizes.newSize(5.4),
                                height: AppSizes.newSize(2.2),
                                valueFontSize: AppSizes.size12,
                                toggleSize: 10.0,
                                value:
                                    settingController.isVibrationEnable.value,
                                borderRadius: 30.0,
                                padding: 2,
                                toggleBorder: Border.all(
                                  color: Colors.white,
                                  width: 1.0,
                                ),
                                showOnOff: true,
                                activeTextColor: AppColors.background2,
                                inactiveToggleColor: Colors.white,
                                inactiveTextColor: Colors.white,
                                activeColor: AppColors.primary,
                                inactiveColor: AppColors.background2,
                                onToggle: (val) {
                                  settingController.changeVibrationStatus();
                                },
                              ),
                            ),
                          ),
                          false.obs,
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
