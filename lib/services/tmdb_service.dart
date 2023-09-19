import 'package:tmdb_dart/tmdb_dart.dart';

class TMDBService {
  static TmdbService service = TmdbService('559a3c9af66b0efb2f20d1b5ebaf99f8');

  static init() async {
    service.initConfiguration();
  }

  static Future<List<MovieBase>> search(String q) async {
    var pagedResult = await service.movie.search(q);

    return pagedResult.results;
  }
}
