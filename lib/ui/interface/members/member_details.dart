import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cqaaq_app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class MemberDetailScreen extends StatefulWidget {
  static const String id = 'member_detail';
  final UserModel user;
  const MemberDetailScreen({
    super.key,
    required this.user,
  });

  @override
  State<MemberDetailScreen> createState() => _MemberDetailScreenState();
}

class _MemberDetailScreenState extends State<MemberDetailScreen> {
  Widget get _space => Gap(10.0.h);
  bool isLoading = true;

  @override
  void initState() {
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: StringResource.memberText,
      leading: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 4.0.r,
          vertical: 4.0.r,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          borderRadius: BorderRadius.circular(10.0.r),
        ),
        child: IconButton(
          onPressed: () {
            NavigationService.goBack();
          },
          icon: Icon(
            LineAwesomeIcons.angle_left,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0.w,
            vertical: 5.0.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              /// top row of user details
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 80.0.w,
                    width: 80.0.w,
                    decoration: const BoxDecoration(),
                    child: CachedNetworkImage(
                      imageUrl: widget.user.avatar ?? defaultAvatarUrl,
                      progressIndicatorBuilder: (BuildContext context, String url, DownloadProgress downloadProgress) =>
                          const AvatarPlaceholder(),
                      errorWidget: (BuildContext context, String url, Object error) => Image.asset(
                        Assets.imagesAccount,
                      ),
                    ),
                  ),
                  _space,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CustomText(
                          "${widget.user.firstName} ${widget.user.lastName}",
                          fontSize: 14.sp,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                        ),
                        _space,
                        CustomText(
                          "${widget.user.position} | ${widget.user.district}",
                          fontSize: 12.sp,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _space,
              _space,

              /// bio information
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.0.r),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                child: CustomText(
                  widget.user.about ?? "No bio available",
                  fontSize: 12.sp,
                  textAlign: TextAlign.justify,
                  maxLines: 50,
                  overflow: TextOverflow.ellipsis,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
              _space,
              _space,
              const BrandDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CustomText(
                    "Report History",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              const BrandDivider(),
              _space,

              /// report history
              ///
              (widget.user.reports.isNotEmpty)
                  ? Expanded(
                      child: isLoading
                          ? LoadingSkeleton(isEnabled: isLoading)
                          : ListView.separated(
                              itemBuilder: (BuildContext context, int index) {
                                final ReportModel reportModel =
                                    reportsController.getReportById(widget.user.reports[index]);
                                return ReportCard(
                                  reportModel: reportModel,
                                  backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                                  foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
                                  iconBackgroundColor: Theme.of(context).colorScheme.secondary,
                                  iconColor: Theme.of(context).colorScheme.onSecondary,
                                  showReportedBy: false,
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
                              itemCount: widget.user.reports.length,
                            ),
                    )
                  : Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10.0.r),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(2.0.r),
                            ),
                            child: AutoSizeText(
                              "No Reports by this member",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              _space,

              const BrandDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CustomText(
                    "Work History",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              const BrandDivider(),
              _space,

              /// work history
              ///
              (widget.user.history.isNotEmpty)
                  ? Expanded(
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          WorkHistoryModel history = widget.user.history[index];
                          String endDate = history.stillWorking ? "Current" : history.endDate ?? "";
                          return isLoading
                              ? LoadingSkeleton(isEnabled: isLoading)
                              : WorkHistoryTile(
                                  company: history.company,
                                  position: history.position,
                                  startDate: history.startDate.split(" ")[0],
                                  endDate: endDate.split(" ")[0],
                                );
                        },
                        separatorBuilder: (BuildContext context, int index) => _space,
                        itemCount: widget.user.history.length,
                      ),
                    )
                  : Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10.0.r),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(2.0.r),
                            ),
                            child: AutoSizeText(
                              "No work history",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              _space,
            ],
          ),
        ),
      ),
    );
  }
}
