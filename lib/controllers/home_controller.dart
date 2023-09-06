import 'dart:convert';

import 'package:get/get.dart';
import 'package:movie_app/consts/consts.dart';
import 'package:movie_app/models/home.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/utils/helpers.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<Movie> banners = <Movie>[].obs;
  RxList sliders = [].obs;
  RxInt currentIndex = 0.obs;
  RxList<Menu> menus = <Menu>[].obs;

  loadHome() async {
    isLoading.value = true;

    //try {
    String url = AppConsts.home;
    Map<String, String> headers = {
      'X-API-KEY': AppConsts.apiKey,
    };

    var response = await ApiService.get(
      url,
      headers: headers,
    );

    var jsonString = response.body;
    var responseModel = jsonDecode(jsonString);
    if (response.statusCode == 200) {
      menus.clear();
      responseModel.forEach((element) {
        menus.add(Menu.fromJson(element));
      });
    } else {
      showToast('Unknown error.');
    }
    // } catch (e) {
    //   //
    // } finally {
    //   isLoading.value = false;
    // }
  }

  @override
  void onInit() {
    super.onInit();

    loadHome();
  }
}
