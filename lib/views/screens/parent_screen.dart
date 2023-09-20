import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:movie_app/utils/helpers.dart';
import 'package:movie_app/views/screens/favorite_screen.dart';
import 'package:movie_app/views/screens/home_screen.dart';
import 'package:movie_app/views/screens/news_screen.dart';
import 'package:movie_app/views/widgets/drawer_widget.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:share_plus/share_plus.dart';
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
        iconTheme: IconThemeData(
          color: AppColors.primary,
        ),
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.background,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              onPressed: () async {
                final box = context.findRenderObject() as RenderBox?;

                await Share.share(
                  'Watch for NetNaija Movies',
                  subject: AppTexts.appName,
                  sharePositionOrigin:
                      box!.localToGlobal(Offset.zero) & box.size,
                );
              },
              icon: Icon(
                Icons.share,
                color: AppColors.primary,
              ),
            );
          })
        ],
      ),
      backgroundColor: AppColors.background,
      drawer: const AppDrawer(),
      body: Obx(() {
        return IndexedStack(
          index: settingController.selectedIndex.value,
          children: const [
            HomeScreen(),
            MenuScreen(),
            MovieScreen(),
            FavoriteScreen(),
            NewsScreen(),
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
                const AssetImage('assets/images/icons/heart.png'),
                size: AppSizes.size16,
              ),
              title: Text(
                "Favorites",
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
          ],
        );
      }),
    );
  }
}
