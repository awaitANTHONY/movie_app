import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:movie_app/utils/helpers.dart';
import 'package:movie_app/views/screens/home_screen.dart';
import 'package:movie_app/views/screens/news_screen.dart';
import 'package:movie_app/views/widgets/drawer_widget.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '/consts/consts.dart';
import 'menu_screen.dart';
import 'movie_screen.dart';
import 'setting_screen.dart';

class ParentScreen extends StatefulWidget {
  const ParentScreen({
    Key? key,
    this.page = 0,
  }) : super(key: key);
  final int page;

  @override
  ParentScreenState createState() => ParentScreenState();
}

class ParentScreenState extends State<ParentScreen> {
  //AuthController authController = Get.find();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      settingController.selectedIndex.value = widget.page;
    });

    initNotification(
      onOpen: (message) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        title: Obx(() {
          return Text(
            settingController.titles[settingController.selectedIndex.value],
            style: const TextStyle(
              color: AppColors.text2,
            ),
          );
        }),
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.background,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      backgroundColor: AppColors.background,
      drawer: const DrawerWidget(),
      body: Obx(() {
        return IndexedStack(
          index: settingController.selectedIndex.value,
          children: const [
            HomeScreen(),
            MenuScreen(),
            MovieScreen(),
            NewsScreen(),
            SettingScreen(),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        return SalomonBottomBar(
          selectedItemColor: AppColors.primary,
          currentIndex: settingController.selectedIndex.value,
          onTap: settingController.onItemTapped,
          items: [
            SalomonBottomBarItem(
              icon: ImageIcon(
                const AssetImage('assets/images/icons/home1.png'),
                size: AppSizes.size16,
              ),
              title: Text(
                "Home",
                style: TextStyle(
                  fontSize: AppSizes.size12,
                ),
              ),
            ),
            SalomonBottomBarItem(
              icon: ImageIcon(
                const AssetImage('assets/images/icons/menu.png'),
                size: AppSizes.size16,
              ),
              title: Text(
                "Menus",
                style: TextStyle(
                  fontSize: AppSizes.size12,
                ),
              ),
            ),
            SalomonBottomBarItem(
              icon: ImageIcon(
                const AssetImage('assets/images/icons/mozy.png'),
                size: AppSizes.size16,
              ),
              title: Text(
                "Top",
                style: TextStyle(
                  fontSize: AppSizes.size12,
                ),
              ),
            ),
            SalomonBottomBarItem(
              icon: ImageIcon(
                const AssetImage('assets/images/icons/news.png'),
                size: AppSizes.size16,
              ),
              title: Text(
                "News",
                style: TextStyle(
                  fontSize: AppSizes.size12,
                ),
              ),
            ),
            SalomonBottomBarItem(
              icon: ImageIcon(
                const AssetImage('assets/images/icons/user.png'),
                size: AppSizes.size16,
              ),
              title: Text(
                "Profile",
                style: TextStyle(
                  fontSize: AppSizes.size12,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
