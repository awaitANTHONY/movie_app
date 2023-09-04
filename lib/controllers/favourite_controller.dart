// import 'dart:collection';
// import 'dart:convert';
// import 'package:collection/collection.dart';
// import 'package:get/get.dart';
// import '/consts/consts.dart';
// import '/models/fixture.dart';
// import '/models/league.dart';
// import '/models/team.dart';
// import '/services/api_services.dart';
// import '/utils/helpers.dart';

// class FavouriteController extends GetxController {
//   RxBool isLoading = false.obs;
//   RxList<int> fixturesIds = <int>[].obs;
//   Map<int?, List<FixtureResponse>> fixtureByLeague =
//       <int?, List<FixtureResponse>>{}.obs;
//   RxList<LeagueResponse> leagues = <LeagueResponse>[].obs;
//   RxList<TeamResponse> teams = <TeamResponse>[].obs;
//   RxInt currentId = 0.obs;

//   favoriteFixture(int id) {
//     if (isSelected(id, 'fixtures')) {
//       fixturesIds.removeWhere((e) => e == id);
//     } else {
//       fixturesIds.add(id);
//     }

//     Future.delayed(1.seconds, () {
//       writeStorage(
//           'fixtures', fixturesIds.isEmpty ? null : jsonEncode(fixturesIds));
//       loadFixtures();
//     });
//   }

//   loadFixtures() async {
//     isLoading.value = true;

//     try {
//       String ids = fixturesIds.join('-');
//       String url = '${AppConsts.baseUrl}${AppConsts.fixtures}?ids=$ids';
//       Map<String, String> headers = {
//         'X-RapidAPI-Key': AppConsts.apiKey,
//         'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com',
//       };

//       var response = await ApiService.get(
//         url,
//         headers: headers,
//       );

//       var jsonString = response.body;
//       var responseModel = Fixture.fromJson(jsonDecode(jsonString));
//       dd('${responseModel.response!.length} object');
//       if (response.statusCode == 200) {
//         fixtureByLeague = groupBy(responseModel.response ?? <FixtureResponse>[],
//             (FixtureResponse response) => response.league!.id!);

//         fixtureByLeague = SplayTreeMap<int, List<FixtureResponse>>.from(
//           fixtureByLeague,
//           (a, b) => a.compareTo(b),
//         );
//       } else {
//         showToast('Unknown error.');
//       }
//     } catch (e) {
//       //
//       //dd('url' + 'object');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   favoriteLeague(LeagueResponse league) {
//     if (isSelected(league.league!.id!, 'leagues')) {
//       leagues.removeWhere((e) => e.league!.id == league.league!.id!);
//     } else {
//       leagues.add(league);
//     }

//     writeStorage('leagues', leagues.isEmpty ? null : jsonEncode(leagues));
//   }

//   favoriteTeam(TeamResponse team) {
//     if (isSelected(team.team!.id!, 'teams')) {
//       teams.removeWhere((e) => e.team!.id == team.team!.id!);
//     } else {
//       teams.add(team);
//     }

//     writeStorage('teams', teams.isEmpty ? null : jsonEncode(teams));
//   }

//   isSelected<bool>(int id, String type) {
//     if (type == 'fixtures') {
//       return fixturesIds.where((element) => element == id).isNotEmpty;
//     } else if (type == 'leagues') {
//       return leagues.where((element) => element.league!.id == id).isNotEmpty;
//     } else if (type == 'teams') {
//       return teams.where((element) => element.team!.id == id).isNotEmpty;
//     }
//     return false;
//   }

//   onInitApp() {
//     var boxFixtures = readStorage('fixtures');
//     if (boxFixtures != null) {
//       jsonDecode(boxFixtures).forEach((element) {
//         fixturesIds.add(int.parse(element.toString()));
//       });
//       Future.delayed(1.seconds, () {
//         loadFixtures();
//       });
//     }

//     var boxLeagues = readStorage('leagues');
//     if (boxLeagues != null) {
//       jsonDecode(boxLeagues).forEach((element) {
//         leagues.add(LeagueResponse.fromJson(element));
//       });
//     }

//     var boxTeams = readStorage('teams');
//     if (boxTeams != null) {
//       jsonDecode(boxTeams).forEach((element) {
//         teams.add(TeamResponse.fromJson(element));
//       });
//     }
//   }

//   @override
//   void onInit() {
//     super.onInit();

//     onInitApp();
//   }
// }
