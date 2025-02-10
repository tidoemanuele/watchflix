class AppConfig {
  AppConfig({
    required this.watchmodeBaseUrl,
    required this.watchmodeApiKey,
  });

  final Uri watchmodeBaseUrl;
  final String watchmodeApiKey;

  void validate() {
    if (watchmodeApiKey == 'YOUR_API_KEY_HERE') {
      throw Exception('Please set a valid Watchmode API key');
    }
  }
}
