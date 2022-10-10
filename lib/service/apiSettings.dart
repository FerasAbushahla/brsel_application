class ApiSettings {
  static const _baseUrl = 'http://barsal.omarhd.co/';
  // static const _baseUrl = 'https://barsal.omarhd.co/';
  static const _apiUrl = _baseUrl + 'api/';

  static const register = _apiUrl + 'auth/register';
  static const infoRegister = _apiUrl + 'auth/infoRegister';
  static const login = _apiUrl + 'auth/login';
  static const home = _apiUrl + 'home';
  static const meals = _apiUrl + 'meals';
  static const search = _apiUrl + 'meals/search';
}
