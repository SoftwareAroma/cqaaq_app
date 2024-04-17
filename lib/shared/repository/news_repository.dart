import 'package:cqaaq_app/index.dart';

class NewsRepo {
  static final NewsRepo _instance = NewsRepo();
  static NewsRepo get instance => _instance;

  // fetch news
  Future<List<NewsModel>> fetchNews() async {
    try {
      List<NewsModel> news = [];
      final response = await RequestHelper.getRequest(newsApiEndpoint());
      // logger.i("News response: $response");
      response['articles'].forEach((newsItem) {
        var newModel = NewsModel.fromJson(newsItem);
        // logger.i("News: $newsItem");
        news.add(newModel);
      });
      return news;
    } catch (e) {
      logger.e("Error fetching news: $e");
      return [];
    }
  }
}
