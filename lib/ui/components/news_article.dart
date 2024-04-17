import 'package:cached_network_image/cached_network_image.dart';
import 'package:cqaaq_app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    super.key,
    required this.news,
  });

  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigationService.navigateTo(
          navigationMethod: NavigationMethod.push,
          page: ArticleDetailScreen(newsModel: news),
          isNamed: false,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10.0.r),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 250.0.h,
              width: double.infinity,
              child: (news.urlToImage != null)
                  ? ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0.r),
                        topRight: Radius.circular(10.0.r),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: news.urlToImage!,
                        fit: BoxFit.cover,
                        placeholder: (BuildContext context, String url) {
                          return Image.asset(
                            Assets.newsNews,
                            fit: BoxFit.cover,
                          );
                        },
                        errorWidget: (BuildContext context, String url, dynamic error) {
                          return Image.asset(
                            Assets.newsNews,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0.r),
                        topRight: Radius.circular(10.0.r),
                      ),
                      child: Image.asset(
                        Assets.newsNews1,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.0.h),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0.r),
                  bottomRight: Radius.circular(15.0.r),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomText(
                    news.title,
                    maxLines: 8,
                    lineHeight: 1.2,
                    textAlign: TextAlign.start,
                    color: Theme.of(context).colorScheme.primaryContainer,
                    fontSize: 18.0.sp,
                    fontWeight: FontWeight.w900,
                  ),
                  Gap(10.0.h),
                  CustomText(
                    news.description,
                    textAlign: TextAlign.justify,
                    color: Theme.of(context).colorScheme.onPrimary,
                    maxLines: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
