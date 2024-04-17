import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cqaaq_app/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class BasePage extends StatefulWidget {
  final Widget body;
  final bool showAppBar;
  final bool showDrawer;
  final String title;
  final Color? backgroundColor;
  final Widget? leading;
  const BasePage({
    super.key,
    required this.body,
    this.showAppBar = true,
    this.showDrawer = true,
    this.title = "CQAAQ",
    this.backgroundColor,
    this.leading,
  });

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  /// [Scaffold] key for [ScaffoldState]
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget get _space => Gap(5.0.h);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: widget.backgroundColor ?? Theme.of(context).colorScheme.background,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: widget.showAppBar
          ? AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              centerTitle: true,
              leading: widget.leading ??
                  IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                    icon: Icon(
                      LineAwesomeIcons.bars,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
              title: AutoSizeText(
                widget.title.toUpperCase(),
                style: GoogleFonts.poppins(
                  fontSize: 18.0.sp,
                  color: Theme.of(context).colorScheme.onPrimary,
                  letterSpacing: 1.5,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    NavigationService.navigateTo(
                      navigationMethod: NavigationMethod.push,
                      page: NotificationScreen.id,
                      isNamed: true,
                    );
                  },
                  icon: Icon(
                    LineAwesomeIcons.bell,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            )
          : null,
      drawer: widget.showDrawer
          ? Obx(
              () => Drawer(
                backgroundColor: Theme.of(context).colorScheme.background,
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        NavigationService.navigateTo(
                          navigationMethod: NavigationMethod.push,
                          page: ProfileScreen.id,
                          isNamed: true,
                        );
                      },
                      child: Container(
                        height: 80.0.h,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                        ),
                        child: DrawerHeader(
                          margin: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 70.0.w,
                                  width: 70.0.w,
                                  decoration: const BoxDecoration(),
                                  child: CachedNetworkImage(
                                    imageUrl: userController.user?.avatar ?? defaultAvatarUrl,
                                    progressIndicatorBuilder:
                                        (BuildContext context, String url, DownloadProgress downloadProgress) =>
                                            const AvatarPlaceholder(),
                                    errorWidget: (BuildContext context, String url, Object error) => Image.asset(
                                      Assets.imagesAccount,
                                    ),
                                  ),
                                ),
                              ),
                              _space,
                              Expanded(
                                flex: 6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ClipRRect(
                                      child: CustomText(
                                        userController.user?.firstName.toUpperCase() ??
                                            StringResource.janeDoe.toUpperCase(),
                                        fontSize: 16.0.sp,
                                        color: Theme.of(context).colorScheme.primary,
                                        maxLines: 3,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Gap(2.0.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        ClipRRect(
                                          child: CustomText(
                                            userController.user?.position?.toCapitalized() ??
                                                StringResource.unknownText,
                                            fontSize: 10.0.sp,
                                            color: Theme.of(context).colorScheme.onBackground,
                                            maxLines: 3,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Gap(4.0.w),
                                        Container(
                                          height: 10.0.h,
                                          width: 2.0.h,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                        ),
                                        Gap(4.0.w),
                                        ClipRRect(
                                          child: CustomText(
                                            userController.user?.district?.toCapitalized() ??
                                                StringResource.unknownText,
                                            fontSize: 10.0.sp,
                                            color: Theme.of(context).colorScheme.onBackground,
                                            maxLines: 3,
                                            fontWeight: FontWeight.normal,
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
                    ),
                    _space,
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          DrawerTile(
                            title: StringResource.homeText,
                            icon: FontAwesomeIcons.house,
                            onTap: () {
                              NavigationService.navigateTo(
                                navigationMethod: NavigationMethod.push,
                                page: HomeScreen.id,
                                isNamed: true,
                              );
                            },
                          ),
                          _space,
                          DrawerTile(
                            title: StringResource.reportText,
                            icon: FontAwesomeIcons.copy,
                            onTap: () {
                              NavigationService.navigateTo(
                                navigationMethod: NavigationMethod.push,
                                page: ReportScreen.id,
                                isNamed: true,
                              );
                            },
                          ),
                          _space,
                          DrawerTile(
                            title: StringResource.settingsText,
                            icon: FontAwesomeIcons.gear,
                            onTap: () {
                              NavigationService.navigateTo(
                                navigationMethod: NavigationMethod.push,
                                page: SettingsScreen.id,
                                isNamed: true,
                              );
                            },
                          ),
                          _space,
                          DrawerTile(
                            title: StringResource.profileText,
                            icon: FontAwesomeIcons.user,
                            onTap: () {
                              NavigationService.navigateTo(
                                navigationMethod: NavigationMethod.push,
                                page: ProfileScreen.id,
                                isNamed: true,
                              );
                            },
                          ),
                          _space,
                          DrawerTile(
                            title: StringResource.notificationText,
                            icon: FontAwesomeIcons.bell,
                            onTap: () {
                              NavigationService.navigateTo(
                                navigationMethod: NavigationMethod.push,
                                page: NotificationScreen.id,
                                isNamed: true,
                              );
                            },
                          ),
                          _space,
                          DrawerTile(
                            title: StringResource.newsUpdateText,
                            icon: FontAwesomeIcons.newspaper,
                            onTap: () {
                              NavigationService.navigateTo(
                                navigationMethod: NavigationMethod.push,
                                page: NewsUpdateScreen.id,
                                isNamed: true,
                              );
                            },
                          ),
                          _space,
                          Expanded(child: Container()),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                            child: CustomButton(
                              title: StringResource.getInTouchText,
                              color: Theme.of(context).colorScheme.primary,
                              onPressed: () {
                                showCustomFlushBar(
                                  context: context,
                                  message: StringResource.getInTouchMessage,
                                  icon: LineAwesomeIcons.phone,
                                  iconColor: Theme.of(context).colorScheme.onPrimary,
                                );
                              },
                            ),
                          ),
                          _space,
                          const TermsAndConditions(
                            text1: "You agree to our ",
                            text2: "Terms and Conditions & ",
                            text3: "Privacy Policy",
                          ),
                          _space,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: SafeArea(
        child: widget.body,
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final double? height;
  final Color? backgroundColor;
  final Color? onSurfaceColor;
  final bool showShadow;
  const DrawerTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.height,
    this.backgroundColor,
    this.onSurfaceColor,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 60.0.h,
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).colorScheme.background,
          boxShadow: showShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: onSurfaceColor?.withOpacity(0.3) ?? Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    offset: const Offset(0, 1),
                    blurRadius: 5,
                  ),
                ]
              : null,
        ),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 20.0.w),
              child: Row(
                children: <Widget>[
                  Icon(
                    icon,
                    color: onSurfaceColor ?? Theme.of(context).colorScheme.primary,
                    size: 16.0.sp,
                  ),
                  Gap(10.0.w),
                  CustomText(
                    title.toUpperCase(),
                    fontSize: 16.0.sp,
                    color: onSurfaceColor ?? Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            Container(
              height: 50.0.h,
              width: 10.0.w,
              decoration: BoxDecoration(
                color: onSurfaceColor ?? Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0.r),
                  bottomLeft: Radius.circular(10.0.r),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: onSurfaceColor?.withOpacity(0.3) ?? Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    offset: const Offset(-2.0, 1.0),
                    blurRadius: 5.0,
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
