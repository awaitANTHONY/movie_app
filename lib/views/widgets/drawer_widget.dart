import '/utils/helpers.dart';
//import '/views/screens/about_screen.dart';

import '/controllers/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '/consts/consts.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  SettingController settingController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: AppColors.background2,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: Container(
                          height: 80,
                          width: 80,
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.background2,
                            // gradient: LinearGradient(
                            //   begin: Alignment.topCenter,
                            //   end: Alignment.bottomCenter,
                            //   colors: <Color>[
                            //     AppColors.selected,
                            //     Color.fromRGBO(0, 158, 122, 1),
                            //   ],
                            // ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 1,
                                offset: const Offset(0, 1),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.asset(
                            'assets/images/splash.png',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        AppTexts.appName,
                        style: TextStyle(
                          color: AppColors.text,
                          fontSize: AppSizes.size14,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                ListTile(
                  leading: const FaIcon(
                    FontAwesomeIcons.bell,
                    color: AppColors.text,
                  ),
                  title: const Text(
                    'Notification',
                    style: TextStyle(
                      color: AppColors.text,
                    ),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Obx(() {
                        return Switch(
                          activeColor: AppColors.primary,
                          value: settingController.isNotificationEnable.value,
                          onChanged: (v) {
                            settingController.isNotificationEnable.value = v;
                            writeStorage('notification', v);
                          },
                        );
                      }),
                    ),
                  ),
                ),
                ListTile(
                  leading: const FaIcon(
                    FontAwesomeIcons.house,
                    color: AppColors.text,
                  ),
                  title: const Text(
                    'Home',
                    style: TextStyle(
                      color: AppColors.text,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    settingController.selectedIndex.value = 4;
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.text.withOpacity(0.5),
                    size: AppSizes.size20,
                  ),
                ),
                ListTile(
                  leading: const FaIcon(
                    FontAwesomeIcons.circleInfo,
                    color: AppColors.text,
                  ),
                  title: const Text(
                    'Menu',
                    style: TextStyle(
                      color: AppColors.text,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    settingController.selectedIndex.value = 0;
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.text.withOpacity(0.5),
                    size: AppSizes.size20,
                  ),
                ),
                ListTile(
                  leading: const FaIcon(
                    FontAwesomeIcons.box,
                    color: AppColors.text,
                  ),
                  title: const Text(
                    'Top Movies & Series',
                    style: TextStyle(
                      color: AppColors.text,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    settingController.selectedIndex.value = 1;
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.text.withOpacity(0.5),
                    size: AppSizes.size20,
                  ),
                ),
                ListTile(
                  leading: const FaIcon(
                    FontAwesomeIcons.newspaper,
                    color: AppColors.text,
                  ),
                  title: const Text(
                    'News',
                    style: TextStyle(
                      color: AppColors.text,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    settingController.selectedIndex.value = 2;
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.text.withOpacity(0.5),
                    size: AppSizes.size20,
                  ),
                ),
                ListTile(
                  leading: const FaIcon(
                    FontAwesomeIcons.toolbox,
                    color: AppColors.text,
                  ),
                  title: const Text(
                    'Setting',
                    style: TextStyle(
                      color: AppColors.text,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    settingController.selectedIndex.value = 3;
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.text.withOpacity(0.5),
                    size: AppSizes.size20,
                  ),
                ),
                ListTile(
                  leading: const FaIcon(
                    FontAwesomeIcons.info,
                    color: AppColors.text,
                  ),
                  title: const Text(
                    'About Us',
                    style: TextStyle(
                      color: AppColors.text,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    //Get.to(() => const AboutScreen());
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.text.withOpacity(0.5),
                    size: AppSizes.size20,
                  ),
                ),
                ListTile(
                  leading: const FaIcon(
                    FontAwesomeIcons.userShield,
                    color: AppColors.text,
                  ),
                  title: const Text(
                    'Privacy Police',
                    style: TextStyle(
                      color: AppColors.text,
                    ),
                  ),
                  onTap: () {
                    launchURL('https://ratvnetwork.net/');
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.text.withOpacity(0.5),
                    size: AppSizes.size20,
                  ),
                ),
                ListTile(
                  leading: const FaIcon(
                    FontAwesomeIcons.newspaper,
                    color: AppColors.text,
                  ),
                  title: const Text(
                    'Terms Conditions',
                    style: TextStyle(
                      color: AppColors.text,
                    ),
                  ),
                  onTap: () {
                    launchURL('https://ratvnetwork.net/');
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.text.withOpacity(0.5),
                    size: AppSizes.size20,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Builder(builder: (context) {
              return Text(
                'Version: ${settingController.appInfo.value?.version ?? '1.0'}',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: AppSizes.size15,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
