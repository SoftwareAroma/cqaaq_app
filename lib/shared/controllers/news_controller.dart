import 'package:get/get.dart';
import 'package:cqaaq_app/index.dart';

class NewsController extends GetxController {
  static final NewsController _instance = Get.find();
  static NewsController get instance => _instance;

  final _news = <NewsModel>[].obs;

  /// Side Effects
  ///
  /// Fetch news from the API

  Future<void> fetchNews() async {
    try {
      final List<NewsModel> response = await NewsRepo.instance.fetchNews();
      // clear the list before adding new items
      if (response.isNotEmpty) {
        _news.clear();
      }
      _news.assignAll(response);
      update();
    } catch (e) {
      logger.e("Error fetching news: $e");
    }
  }

  Future<NewsModel> getNews(String title) async {
    final NewsModel news = _news.firstWhere((NewsModel element) => element.title == title);
    return news;
  }

  // clear news
  void clearNews() {
    _news.clear();
    update();
  }

  /// getters
  ///

  List<NewsModel> get news => _news;
}
