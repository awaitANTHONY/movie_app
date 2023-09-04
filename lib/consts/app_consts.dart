class AppConsts {
  static const String baseUrl =
      "https://wordpress.iqonic.design/product/wp/streamit";
  static const String apiKey = "";

  static const String settings = "/api/v1/settings";

  static const String signup = "/api/v1/signup";
  static const String signin = "/api/v1/signin";
  static const String user = "/api/v1/user";
  static const String userUpdate = "/api/v1/userUpdate";

  static const String home =
      "/wp-json/streamit-api/api/v1/streamit/get-dashboard?type=movie";
  static const String genres =
      "/wp-json/streamit-api/api/v1/streamit/get-genre-by-type?type=movie&paged=1&posts_per_page=10";
  static const String genreMovies =
      "/wp-json/streamit-api/api/v1/streamit/get-list-by-genre?type=movie&genre=action&paged=1&posts_per_page=10";
  static const String movies = "/wp-json/streamit-api/api/v1/movie/get_list";
  static const String movieDetails =
      "/wp-json/streamit-api/api/v1/movie/get-detail?movie_id=7230";
  static const String search =
      "/wp-json/streamit-api/api/v1/streamit/search-list?search=Sea&paged=1&posts_per_page=10";
}
