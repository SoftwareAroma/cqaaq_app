import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cqaaq_app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class MembersScreen extends StatefulWidget {
  static const String id = 'members';
  const MembersScreen({super.key});

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  Widget get _space => Gap(10.0.h);
  bool isLoading = true;

  @override
  void initState() {
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    isLoading = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: StringResource.membersText,
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
            children: <Widget>[
              if (appController.users.isEmpty)
                Container(
                  padding: EdgeInsets.all(10.0.r),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(2.0.r),
                  ),
                  child: AutoSizeText(
                    "No Members Found",
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    UserModel user = appController.users[index];
                    return UserTile(
                      user: user,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) => MemberDetailScreen(user: user)),
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) => Column(
                    children: [
                      _space,
                      const BrandDivider(),
                    ],
                  ),
                  itemCount: userController.user?.history.length ?? 0,
                ),
              ),

              /// space bottom
              _space,
            ],
          ),
        ),
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  final UserModel user;
  final Function() onTap;
  const UserTile({
    super.key,
    required this.user,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        height: 60.0.w,
        width: 60.0.w,
        decoration: const BoxDecoration(),
        child: CachedNetworkImage(
          imageUrl: user.avatar ?? defaultAvatarUrl,
          progressIndicatorBuilder: (BuildContext context, String url, DownloadProgress downloadProgress) =>
              const AvatarPlaceholder(),
          errorWidget: (BuildContext context, String url, Object error) => Image.asset(
            Assets.imagesAccount,
          ),
        ),
      ),
      title: AutoSizeText(
        "${user.firstName} ${user.lastName}",
        style: GoogleFonts.poppins(
          fontSize: 12.0.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: AutoSizeText(
        user.position ?? user.region,
        style: GoogleFonts.poppins(
          fontSize: 10.0.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
