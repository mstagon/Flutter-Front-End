enum Environment {
  mock,
  production,
}

class AppConfig {
  static Environment environment = Environment.mock;
  static const String baseUrl = 'YOUR_BASE_URL';
} 