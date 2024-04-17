import 'package:cqaaq_app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class NewsUpdateScreen extends StatefulWidget {
  static const String id = 'news_update_screen';
  const NewsUpdateScreen({super.key});

  @override
  State<NewsUpdateScreen> createState() => _NewsUpdateScreenState();
}

class _NewsUpdateScreenState extends State<NewsUpdateScreen> {
  bool _isFetching = true;
  @override
  void initState() {
    _isFetching = true;
    newsController.fetchNews();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          _isFetching = false;
        });
      });
    });
    super.initState();
  }

  Widget get _space => Gap(10.0.h);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: StringResource.newsUpdateText,
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 2.0.h),
          child: ListView.separated(
            itemCount: newsController.news.length,
            itemBuilder: (BuildContext context, int index) {
              final NewsModel newsModel = newsController.news[index];
              if (newsModel.title == "[Removed]") {
                return const SizedBox.shrink();
              }
              return _isFetching ? LoadingSkeleton(isEnabled: _isFetching) : ArticleCard(news: newsModel);
            },
            separatorBuilder: (BuildContext context, int index) => _space,
          ),
        ),
      ),
    );
  }
}
