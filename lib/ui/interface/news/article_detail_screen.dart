import 'package:cached_network_image/cached_network_image.dart';
import 'package:cqaaq_app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ArticleDetailScreen extends StatefulWidget {
  static String id = 'article_detail_screen';
  final NewsModel newsModel;
  const ArticleDetailScreen({
    super.key,
    required this.newsModel,
  });

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  Widget get _space => Gap(10.0.h);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Text(
          'Detail Reading'.toUpperCase(),
          style: GoogleFonts.poppins(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        leading: Container(
          margin: EdgeInsets.symmetric(horizontal: 2.0.w, vertical: 4.0.h),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            borderRadius: BorderRadius.circular(10.0.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  LineAwesomeIcons.angle_left,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  NavigationService.goBack();
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.0.h),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomText(
                widget.newsModel.title.toUpperCase(),
                fontSize: 16.0.sp,
                maxLines: 4,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
                lineHeight: 1.2,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              _space,
              Container(
                height: 8.0.h,
                width: 80.0.w,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              _space,
              CachedNetworkImage(
                imageUrl: widget.newsModel.urlToImage ?? defaultImagePlaceholder,
                height: 200.0.h,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (BuildContext context, String url) {
                  return Image.asset(
                    Assets.newsNews,
                    fit: BoxFit.cover,
                  );
                },
                errorWidget: (BuildContext context, String url, Object error) {
                  return Image.asset(
                    Assets.newsNews1,
                    fit: BoxFit.cover,
                  );
                },
              ),
              _space,
              CustomText(
                widget.newsModel.source?.name.toUpperCase() ?? "Unkown".toUpperCase(),
                fontSize: 14.0.sp,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).colorScheme.primary,
                letterSpacing: 1.4,
              ),
              _space,
              CustomText(
                widget.newsModel.description,
                fontSize: 14.0.sp,
                maxLines: 200,
                textAlign: TextAlign.justify,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              _space,
              Container(
                height: 2.0.h,
                width: 100.0.w,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              _space,
              // CustomText(
              //   widget.newsModel.content,
              //   fontSize: 14.0.sp,
              //   maxLines: 200,
              //   textAlign: TextAlign.justify,
              //   color: Theme.of(context).colorScheme.onBackground,
              // ),
              _space,
              _space,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      leading: Container(
                        padding: EdgeInsets.all(10.0.r),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        child: Icon(
                          LineAwesomeIcons.calendar,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      title: CustomText(
                        DateFormat('dd MMM yyyy, \n hh:mm a')
                            .format(
                              DateTime.parse(widget.newsModel.publishedAt),
                            )
                            .toString(),
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w900,
                        maxLines: 5,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: Container(
                        padding: EdgeInsets.all(10.0.r),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        child: Icon(
                          LineAwesomeIcons.user,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      title: CustomText(
                        widget.newsModel.author?.toUpperCase() ?? 'Unknown',
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w900,
                        maxLines: 5,
                      ),
                    ),
                  ),
                ],
              ),
              _space,
              _space,
              CustomOutlineButton(
                title: 'Read More',
                textColor: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  HelperFunctions.iLaunchUrl(widget.newsModel.url);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
