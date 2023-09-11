import 'dart:convert';

import 'package:get/get.dart';
import 'package:movie_app/consts/consts.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/utils/helpers.dart';

class MovieController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isLoading2 = true.obs;
  RxList<Movie> topMovies = <Movie>[].obs;
  RxList<Movie> topSeries = <Movie>[].obs;
  RxList<Movie> topNollywood = <Movie>[].obs;
  RxList<Movie> sliders = <Movie>[].obs;
  RxList<Movie> latest = <Movie>[].obs;
  RxList<Movie> all = <Movie>[].obs;

  loadTopMovies() async {
    try {
      String url = "${AppConsts.topMovies}?page=1&per_page=30&_embed";
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
        topMovies.clear();
        responseModel.forEach((element) {
          topMovies.add(Movie.fromJson(element));
        });
      } else {
        showToast('Unknown error.');
      }
    } catch (e) {
      dd(e);
    } finally {
      isLoading.value = false;
    }
  }

  loadTopSeries() async {
    try {
      String url = "${AppConsts.topSeries}?page=1&per_page=30&_embed";
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
        topSeries.clear();
        responseModel.forEach((element) {
          topSeries.add(Movie.fromJson(element));
        });

        sliders.value = [...topMovies, ...topSeries];
        sliders.shuffle();
        sliders.value = sliders.take(10).toList();
        latest.value = [...topMovies, ...topSeries];
        latest.shuffle();
      } else {
        showToast('Unknown error.');
      }
    } catch (e) {
      //
    } finally {
      isLoading.value = false;
    }
  }

  loadNollywood() async {
    try {
      String url = "${AppConsts.topNollywood}?page=1&per_page=30&_embed";
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
        topNollywood.clear();
        responseModel.forEach((element) {
          topNollywood.add(Movie.fromJson(element));
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

  loadContent(String u) async {
    isLoading2.value = true;
    try {
      String url = "${u}posts?page=1&per_page=100&_embed";
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
        all.clear();
        responseModel.forEach((element) {
          all.add(Movie.fromJson(element));
        });
      } else {
        showToast('Unknown error.');
      }
    } catch (e) {
      //
    } finally {
      isLoading2.value = false;
    }
  }

  @override
  void onInit() {
    loadTopMovies();
    loadTopSeries();
    loadNollywood();

    super.onInit();
  }
}
