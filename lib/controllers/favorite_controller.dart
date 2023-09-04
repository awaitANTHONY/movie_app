// import 'dart:convert';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import '/models/channel.dart';
// import '/views/dialogs/user_dialog.dart';
// import '/consts/consts.dart';
// import '/controllers/auth_controller.dart';
// import '/utils/helpers.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'channel_controller.dart';

// class FavouriteController extends GetxController {
//   var client = http.Client();
//   AuthController authController = Get.find();
//   ChannelController channelController = Get.find();
//   RxBool isLoading = false.obs;
//   RxBool isLoading2 = false.obs;
//   RxInt currentId = 0.obs;

//   RxList<ChannelData> channels = <ChannelData>[].obs;

//   loadChannels() async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     isLoading.value = true;

//     if (connectivityResult != ConnectivityResult.none) {
//       try {
//         Uri uri = Uri.parse(
//           '${AppConsts.baseUrl}${AppConsts.favorites}',
//         );

//         var response = await client.post(
//           uri,
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//             'X-API-KEY': AppConsts.apiKey,
//             'Authorization': 'Bearer ${authController.accessToken.value}',
//           },
//         );

//         var jsonString = response.body;
//         var responseModel = Channels.fromJson(jsonDecode(jsonString));
//         channels.value = responseModel.data!;
//       } catch (e) {
//         dd('loadChannels $e');
//       } finally {
//         isLoading.value = false;
//       }
//     } else {
//       showSnackBar(
//         'No internet connection please try again!',
//         () {
//           loadChannels();
//         },
//       );
//     }
//   }

//   favorite(int id) async {
//     if (!authController.isSignIn.value) {
//       showGuestUserInfo();
//       return;
//     }
//     if (isLoading2.value) return;

//     var connectivityResult = await (Connectivity().checkConnectivity());
//     isLoading2.value = true;
//     currentId.value = id;

//     if (connectivityResult != ConnectivityResult.none) {
//       try {
//         Uri uri = Uri.parse('${AppConsts.baseUrl}${AppConsts.favorite}');

//         String body = jsonEncode(<String, dynamic>{
//           'channel_id': id,
//         });
//         var response = await client.post(
//           uri,
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//             'X-API-KEY': AppConsts.apiKey,
//             'Authorization': 'Bearer ${authController.accessToken.value}',
//           },
//           body: body,
//         );

//         dd(response.body);

//         var jsonString = response.body;
//         var responseModel = Channels.fromJson(jsonDecode(jsonString));
//         channels.value = responseModel.data ?? [];

//         dd(responseModel.data?.length);
//       } catch (e) {
//         dd('favorite $e');
//       } finally {
//         isLoading2.value = false;
//       }
//     } else {
//       showSnackBar(
//         'No internet connection please try again!',
//         () {
//           favorite(id);
//         },
//       );
//     }
//   }

//   bool isSelected(ChannelData item) {
//     return channels.where((e) => e.id == item.id).isNotEmpty;
//   }

//   ChannelData isSelectedItem(ChannelData item) {
//     return channels.firstWhere((e) => e.id == item.id);
//   }

//   @override
//   void onInit() {
//     super.onInit();

//     Future.delayed(5.seconds, () {
//       if (authController.isSignIn.value) {
//         loadChannels();
//       }
//     });
//   }
// }
