class HttpHelper {
  final String urlKey = 'api_key=YOUR API KEY HERE';
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlUpcoming = '/upcoming?';
  final String urlLanguage = '&language=en-US';

  Future<String> getUpcoming() async {
    return null;
  }
}