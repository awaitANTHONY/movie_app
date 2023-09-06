import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '/services/api_services.dart';
import '/consts/consts.dart';
import '/models/news.dart';
import '/models/news_details.dart';
import '/services/vpn_service.dart';
import '/utils/helpers.dart';

class NewsController extends GetxController {
  RxList<News>? news = <News>[].obs;
  Rx<NewsDtls> newsDetails = NewsDtls().obs;

  RxBool isLoading = true.obs;
  RxBool isLoading2 = true.obs;

  static var client = http.Client();
  loadFootballNews() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        var response = await client.post(
          Uri.parse(AppConsts.backendBaseUrl + AppConsts.latestNews),
          headers: <String, String>{
            'X-API-KEY': AppConsts.backendApiKey,
          },
        );

        news!.clear();
        news!.addAll(
          FootballNews.fromJson(jsonDecode(response.body)).news!.toList(),
        );

        news!.removeWhere(
          (element) =>
              (element.title!.toLowerCase().contains('fifa') ||
                  element.description!.toLowerCase().contains('fifa')) ||
              (element.title!.toLowerCase().contains('fa cup') ||
                  element.description!.toLowerCase().contains('fa cup')),
        );
      } catch (e, s) {
        dd(e);
        dd(s);
      } finally {
        isLoading.value = false;
      }
    } else {
      showSnackBar(
        'No internet connection please try again!',
        () => loadFootballNews(),
        2,
      );
    }
  }

  loadNewsDetails(link, type) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var vpnResult = await CheckVpnConnection.isVpnActive();
    if (connectivityResult != ConnectivityResult.none && !vpnResult) {
      try {
        String url = '${AppConsts.backendBaseUrl}${AppConsts.newsDetails}';
        Map<String, String> headers = {
          'X-API-KEY': AppConsts.backendApiKey,
        };

        Map<String, dynamic> body = {
          'url': link,
        };
        var response = await ApiService.post(
          url,
          headers: headers,
          body: body,
        );

        newsDetails.value =
            FootballNewsDetails.fromJson(jsonDecode(response.body)).newsDtls!;
      } catch (e, s) {
        dd(e);
        dd(s);
      } finally {
        isLoading2.value = false;
      }
    } else {
      showSnackBar(
        'No internet connection please try again!',
        () => loadNewsDetails(link, type),
        2,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadFootballNews();
  }
}
