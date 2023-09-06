import 'package:movie_app/controllers/home_controller.dart';

import '/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'webview_screen.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: homeController.menus.length,
      padding: const EdgeInsets.only(top: 5),
      itemBuilder: (context, index) {
        var menu = homeController.menus[index];

        if ((menu.tabs?.length ?? 0) > 0 &&
            menu.tabs![0].provider == 'custom') {
          return SizedBox();
        }
        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 7),
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              colorScheme: ColorScheme.fromSwatch().copyWith(
                secondary: Colors.black,
              ),
            ),
            child: ListTileTheme(
              dense: true,
              minVerticalPadding: 0,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: ExpansionTile(
                  initiallyExpanded: true,
                  iconColor: AppColors.primary,
                  collapsedIconColor: AppColors.primary,
                  backgroundColor: AppColors.background2,
                  collapsedBackgroundColor: AppColors.background2,
                  collapsedTextColor: AppColors.text,
                  textColor: AppColors.text,
                  childrenPadding: const EdgeInsets.only(
                    bottom: 8.0,
                    left: 5.0,
                    right: 5.0,
                  ),
                  title: Text(
                    menu.title!.toUpperCase(),
                    style: AppStyles.heading.copyWith(
                      fontSize: AppSizes.size16,
                      color: AppColors.text,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  subtitle: Text(menu.submenu!),
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 0.5,
                      color: AppColors.border,
                    ),
                    Column(
                      children: menu.tabs!
                          .map(
                            (e) => CustomListTIle(
                              title: (e.title != '' ? e.title! : menu.title!)
                                  .toUpperCase(),
                              url: 'https://www.transunion.com',
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => 10.0.spaceY,
    );
  }
}

class CustomListTIle extends StatelessWidget {
  const CustomListTIle({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Map arguments = {
          'title': title,
          'url': url,
        };
        //Get.to(() => WebviewScreen(arguments));
      },
      title: Text(
        title,
        style: AppStyles.heading.copyWith(
          fontSize: AppSizes.size14,
          color: AppColors.text.withOpacity(0.7),
        ),
        textAlign: TextAlign.left,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: AppSizes.size18,
        color: AppColors.primary,
      ),
    );
  }
}
