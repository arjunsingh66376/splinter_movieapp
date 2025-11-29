class Allapilink {
  static const _apikey = '23607aa969d37982460b1c8a186290af';
  static popularurl() =>
      'https://api.themoviedb.org/3/movie/popular?language=en-US&page=1&api_key=$_apikey';
  static toprated() =>
      'https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1&api_key=$_apikey';
  static upcoming() =>
      'https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1&api_key=$_apikey';
  static nowplaying() =>
      'https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=3&api_key=$_apikey';
  static airingtoday() =>
      'https://api.themoviedb.org/3/tv/airing_today?language=en-US&page=1&api_key=$_apikey';

  static tvrecommendation() =>
      'https://api.themoviedb.org/3/trending/tv/week?language=en-US&page=5&api_key=$_apikey';
}
