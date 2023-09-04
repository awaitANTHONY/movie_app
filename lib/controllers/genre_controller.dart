import 'dart:convert';

import 'package:get/get.dart';
import 'package:movie_app/consts/consts.dart';
import 'package:movie_app/models/genre.dart';
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/utils/helpers.dart';

class GenreController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<Genre> genres = <Genre>[].obs;

  loadGenres() async {
    isLoading.value = true;

    try {
      String url = '${AppConsts.baseUrl}${AppConsts.genres}';
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
      var responseModel = jsonDecode(jsonString);
      if (response.statusCode == 200) {
        genres.clear();
        responseModel.forEach((element) {
          genres.add(Genre.fromJson(element));
        });
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

    loadGenres();
  }
}
