const String baseUrl = 'https://dummyjson.com';

class Api {
  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/auth/register';
  static const String checkToken = '$baseUrl/auth/me';
}