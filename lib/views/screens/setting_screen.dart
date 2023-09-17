import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '/consts/consts.dart';
import '/controllers/setting_controller.dart';
import '/models/setting.dart';
import '/utils/helpers.dart';
//import 'subscription_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  //AuthController authController = Get.find();
  SettingController settingController = Get.find();
  @override
  Widget build(BuildContext context) {
    SettingData setting() {
      return settingController.settings.value;
    }

    return Container(
      color: AppColors.background,
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            // GroupWidget(
            //   title: 'App',
            //   children: [
            //     GroupItemWidget(
            //       icon: FontAwesomeIcons.boxesStacked,
            //       title: 'Subscriptions',
            //       onTab: () {
            //         //Get.to(() => SubscriptionScreen());
            //       },
            //       isBorderShow: false,
            //     ),
            //   ],
            // ),
            GroupWidget(
              title: 'Setting',
              children: [
                GroupItemWidget(
                  icon: FontAwesomeIcons.bell,
                  title: 'Notification',
                  onTab: () {
                    settingController.changeNotificationStatus();
                  },
                  tile: ObxValue(
                    (data) => SizedBox(
                      height: AppSizes.newSize(2),
                      child: Switch(
                        activeColor: Colors.red,
                        value: settingController.isNotificationEnable.value,
                        onChanged: (val) {
                          settingController.changeNotificationStatus();
                        },
                      ),
                    ),
                    false.obs,
                  ),
                ),
                GroupItemWidget(
                  icon: Icons.vibration,
                  title: 'Vibration',
                  onTab: () {
                    settingController.changeVibrationStatus();
                  },
                  tile: ObxValue(
                    (data) => SizedBox(
                      height: AppSizes.newSize(2),
                      child: Switch(
                        activeColor: Colors.red,
                        value: settingController.isVibrationEnable.value,
                        onChanged: (val) {
                          settingController.changeVibrationStatus();
                        },
                      ),
                    ),
                    false.obs,
                  ),
                ),
                Builder(builder: (context) {
                  return GroupItemWidget(
                    icon: Icons.share,
                    title: 'Share',
                    onTab: () async {
                      final box = context.findRenderObject() as RenderBox?;

                      await Share.share(
                        'https://apps.apple.com/us/app/netnaijapro-movies-show/id6466206817',
                        subject: 'netnaijapro',
                        sharePositionOrigin:
                            box!.localToGlobal(Offset.zero) & box.size,
                      );
                    },
                    isBorderShow: false,
                  );
                }),
              ],
            ),
            GroupWidget(
              title: 'Social',
              children: [
                GroupItemWidget(
                  icon: FontAwesomeIcons.facebook,
                  title: 'Facebook',
                  onTab: () {
                    launchURL(
                        'https://www.facebook.com/profile.php?id=100087329741774&mibextid=LQQJ4d');
                  },
                ),
                GroupItemWidget(
                  icon: FontAwesomeIcons.instagram,
                  title: 'Instagram',
                  onTab: () {
                    launchURL('https://instagram.com/ratvnetwork');
                  },
                ),
                GroupItemWidget(
                  icon: FontAwesomeIcons.twitter,
                  title: 'Twitter',
                  onTab: () {
                    launchURL('https://twitter.com/ratvnetwork');
                  },
                ),
                GroupItemWidget(
                  icon: FontAwesomeIcons.youtube,
                  title: 'Youtube',
                  onTab: () {
                    launchURL('https://youtube.com/@Ratvnetwork');
                  },
                  isBorderShow: false,
                ),
              ],
            ),
            GroupWidget(
              title: 'More',
              children: [
                GroupItemWidget(
                  icon: FontAwesomeIcons.shield,
                  title: 'Privacy Policy',
                  onTab: () {
                    launchURL(AppConsts.privacyPolice);
                  },
                ),
                GroupItemWidget(
                  icon: FontAwesomeIcons.newspaper,
                  title: 'Terms and Conditions',
                  onTab: () {
                    launchURL(AppConsts.termsConditions);
                  },
                  isBorderShow: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GroupWidget extends StatelessWidget {
  const GroupWidget({
    super.key,
    required this.title,
    required this.children,
  });
  final String title;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background2,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ).copyWith(bottom: 5),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: AppSizes.size12,
              color: AppColors.text,
              overflow: TextOverflow.ellipsis,
            ),
            textAlign: TextAlign.justify,
            maxLines: 2,
          ),
          5.0.spaceY,
          ...children,
        ],
      ),
    );
  }
}

class GroupItemWidget extends StatelessWidget {
  const GroupItemWidget({
    super.key,
    required this.icon,
    required this.title,
    this.tile,
    required this.onTab,
    this.isBorderShow = true,
  });

  final IconData icon;
  final String title;
  final Widget? tile;
  final Function() onTab;
  final bool isBorderShow;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Container(
        decoration: BoxDecoration(
          border: isBorderShow
              ? Border(
                  bottom: BorderSide(
                    color: AppColors.border,
                    width: 0.5,
                  ),
                )
              : null,
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            FaIcon(
              icon,
              color: AppColors.text.withOpacity(0.7),
              size: AppSizes.size20,
            ),
            15.0.spaceX,
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: AppSizes.size14,
                  color: AppColors.text.withOpacity(0.7),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            if (tile == null)
              FaIcon(
                Icons.arrow_forward_ios_outlined,
                color: AppColors.text.withOpacity(0.6),
                size: AppSizes.size18,
              )
            else
              tile!,
          ],
        ),
      ),
    );
  }
}
