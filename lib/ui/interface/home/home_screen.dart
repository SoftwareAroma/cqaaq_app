import 'package:cqaaq_app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isFetching = true;
  @override
  void initState() {
    userController.initUser();
    appController.fetchUsers();
    reportsController.fetchReports();
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
      title: StringResource.homeText,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: <Widget>[
          /// top container
          Material(
            elevation: 12.0,
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5.0.r),
              bottomRight: Radius.circular(5.0.r),
            ),
            shadowColor: Colors.black12,
            child: Container(
              height: 180.0.h,
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 10.0.w,
                vertical: 10.0.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5.0.r),
                  bottomRight: Radius.circular(5.0.r),
                ),
                image: DecorationImage(
                  image: const AssetImage(Assets.imagesAuthBackground),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.95),
                    BlendMode.overlay,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CustomText(
                    "Welcome to CQAAQ".toUpperCase(),
                    fontSize: 32.0.sp,
                    lineHeight: 1.2,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  _space,
                  CustomText(
                    "We give you the latest reports, articles, and updates from various team members. Stay tuned!",
                    fontSize: 14.0.sp,
                    maxLines: 10,
                    textAlign: TextAlign.center,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ],
              ),
            ),
          ),
          Gap(5.0.h),
          Expanded(
            child: Obx(
              () => ListView.separated(
                itemCount: reportsController.reports.length,
                itemBuilder: (BuildContext context, int index) {
                  final ReportModel reportModel = reportsController.reports[index];
                  return _isFetching
                      ? LoadingSkeleton(isEnabled: _isFetching)
                      : ReportCard(
                          reportModel: reportModel,
                          onTap: () {
                            NavigationService.navigateTo(
                              isNamed: false,
                              navigationMethod: NavigationMethod.push,
                              page: () => ReportDetailScreen(reportModel: reportModel),
                            );
                          },
                        );
                },
                separatorBuilder: (BuildContext context, int index) => _space,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReportCard extends StatefulWidget {
  final ReportModel reportModel;
  final VoidCallback onTap;
  const ReportCard({
    super.key,
    required this.reportModel,
    required this.onTap,
  });

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  Widget get _space => Gap(10.0.h);

  @override
  void initState() {
    if (appController.users.isEmpty) {
      appController.fetchUsers();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Obx(
        () => Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0.w,
            vertical: 10.0.h,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(0.0.r),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8.0.r,
                offset: const Offset(4.0, 0.8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0.r),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 2.0.w,
                  ),
                ),
                child: Icon(
                  FontAwesomeIcons.newspaper,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              _space,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomText(
                      widget.reportModel.site.toTitleCase(),
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    Gap(2.0.h),
                    Row(
                      children: <Widget>[
                        CustomText(
                          "Reported by: ".toUpperCase(),
                          fontSize: 12.0.sp,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        Gap(2.0.w),
                        Expanded(
                          child: ClipRRect(
                            child: CustomText(
                              appController.getUser(widget.reportModel.reporterId)?.firstName.toTitleCase() ??
                                  widget.reportModel.reporterUid,
                              fontSize: 12.0.sp,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
