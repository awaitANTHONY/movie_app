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
  RxList<Sliders> sliders = <Sliders>[].obs;
  RxInt currentIndex = 0.obs;

  loadHome() async {
    isLoading.value = true;

    try {
      String url = '${AppConsts.baseUrl}${AppConsts.home}';
      Map<String, String> headers = {
        'X-API-KEY': AppConsts.apiKey,
      };

      Map<String, dynamic> body = {};
      var response = await ApiService.post(
        url,
        headers: headers,
        body: body,
      );

      dd(response.body);

      var jsonString = response.body;
      var responseModel = Home.fromJson(jsonDecode(jsonString));
      if (response.statusCode == 200) {
        banners.value = responseModel.banner ?? [];
        sliders.value = responseModel.sliders ?? [];
      } else {
        showToast('Unknown error.');
      }
    } catch (e) {
      //
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();

    loadHome();
  }
}
