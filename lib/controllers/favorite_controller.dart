import 'dart:convert';
import 'package:movie_app/models/movie.dart';
import '/utils/helpers.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoading2 = false.obs;
  RxInt currentId = 0.obs;

  RxList<Movie> favorites = <Movie>[].obs;

  favorite(Movie movie) {
    if (isSelected(movie)) {
      favorites.removeWhere((e) => e.id == movie.id);
    } else {
      favorites.add(movie);
    }

    writeStorage('favorites', favorites.isEmpty ? null : jsonEncode(favorites));
  }

  bool isSelected(Movie item) {
    return favorites.where((e) => e.id == item.id).isNotEmpty;
  }

  Movie isSelectedItem(Movie item) {
    return favorites.firstWhere((e) => e.id == item.id);
  }

  @override
  void onInit() {
    super.onInit();

    Future.delayed(1.seconds, () {
      var boxFavorites = readStorage('favorites');
      if (boxFavorites != null) {
        jsonDecode(boxFavorites).forEach((element) {
          favorites.add(Movie.fromJson(element));
        });
      }
    });
  }
}
