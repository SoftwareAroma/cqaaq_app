import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cqaaq_app/index.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  static String id = "profile_screen";
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<StatefulWidget> {
  /// profile options
  get profileOptions => <ProfileOptionModel>[
        ProfileOptionModel.arrow(
          title: 'Edit Profile',
          icon: Icon(
            LineAwesomeIcons.user_shield,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          titleColor: Theme.of(context).colorScheme.onBackground,
          onClick: () {
            NavigationService.navigateTo(
              navigationMethod: NavigationMethod.push,
              page: () => BioDataScreen(user: userController.user),
              isNamed: false,
            );
          },
        ),
        ProfileOptionModel.arrow(
          title: 'Address',
          icon: Icon(
            LineAwesomeIcons.map_marker,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          titleColor: Theme.of(context).colorScheme.onBackground,
          onClick: () {
            // open a dialog to add address
            showCustomFlushBar(
              context: context,
              message: "This feature is not available at this time",
            );
          },
        ),
        ProfileOptionModel.arrow(
          title: 'Notifications',
          icon: Icon(
            LineAwesomeIcons.bell,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          titleColor: Theme.of(context).colorScheme.onBackground,
          onClick: () {
            NavigationService.navigateTo(
              navigationMethod: NavigationMethod.push,
              page: NotificationScreen.id,
              isNamed: true,
            );
          },
        ),
        ProfileOptionModel.arrow(
          title: 'Donate',
          icon: Icon(
            LineAwesomeIcons.credit_card,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          titleColor: Theme.of(context).colorScheme.onBackground,
          onClick: () {
            // Navigator.pushNamed(context, DonationScreen.id);
          },
        ),
        ProfileOptionModel.arrow(
          title: 'Settings',
          icon: Icon(
            LineAwesomeIcons.cogs,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          titleColor: Theme.of(context).colorScheme.onBackground,
          onClick: () {
            pageController.animateToPage(
              3,
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut,
            );
          },
        ),
        ProfileOptionModel.arrow(
          title: 'Logout',
          icon: Icon(
            LineAwesomeIcons.alternate_sign_out,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          titleColor: Theme.of(context).colorScheme.onBackground,
          onClick: () async {
            await userRepo.signOut();
            if (!mounted) return;
            NavigationService.offAll(
              page: HomeScreen.id,
              isNamed: true,
            );
          },
        ),
        ProfileOptionModel.arrow(
          title: 'Delete Account',
          icon: Icon(
            LineAwesomeIcons.trash,
            size: 20,
            color: Theme.of(context).colorScheme.error,
          ),
          titleColor: Theme.of(context).colorScheme.error,
          onClick: () async {
            String? response = await userRepo.deleteUser();
            if (!mounted) return;
            if (response != null) {
              showCustomFlushBar(
                context: context,
                message: response,
              );
            }
            NavigationService.offAll(
              page: HomeScreen.id,
              isNamed: true,
            );
          },
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: StringResource.profileText,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Obx(
        () => userController.user == null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Gap(10.0.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CustomText(
                          "No User Logged In".toUpperCase(),
                          fontSize: 22.0.sp,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ],
                    ),
                    Gap(5.0.h),
                    CustomText(
                      "Login to submit a review, report or an update",
                      fontSize: 14.0.sp,
                      textAlign: TextAlign.center,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    Gap(20.0.h),
                    CustomOutlineButton(
                      title: StringResource.loginText.toUpperCase(),
                      color: Theme.of(context).colorScheme.primary,
                      textColor: Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        NavigationService.navigateTo(
                          navigationMethod: NavigationMethod.push,
                          page: LoginScreen.id,
                          isNamed: true,
                        );
                      },
                    ),
                  ],
                ),
              )
            : CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      [
                        Column(
                          children: <Widget>[
                            Gap(10.0.h),

                            /// Profile Image and edit button
                            Stack(
                              children: <Widget>[
                                Container(
                                  height: 80.0.w,
                                  width: 80.0.w,
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
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: InkWell(
                                      onTap: () {
                                        // Navigator.of(context).pushNamed(NewProfilePictureScreen.id);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(4.0),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: Colors.black12,
                                              offset: Offset(0, 2),
                                              blurRadius: 6.0,
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          LineAwesomeIcons.user_edit,
                                          size: 25.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),

                            /// name and phone number
                            Gap(8.0.h),
                            AutoSizeText(
                              userController.user!.firstName,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0.sp,
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                            Gap(8.0.h),

                            /// phone number and email of user
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                CustomText(
                                  userController.user?.phone ?? StringResource.janeDoeNumber,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12.0.sp,
                                  maxLines: 2,
                                  textAlign: TextAlign.end,
                                  color: Theme.of(context).colorScheme.onBackground,
                                ),
                                CustomText(
                                  userController.user?.email ?? StringResource.janeDoeEmail,
                                  fontWeight: FontWeight.normal,
                                  maxLines: 3,
                                  fontSize: 12.0.sp,
                                  textAlign: TextAlign.start,
                                  color: Theme.of(context).colorScheme.onBackground,
                                ),
                              ],
                            ),
                            Gap(15.0.h),
                            Container(
                              color: Theme.of(context).colorScheme.primary,
                              height: 1,
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final data = profileOptions[index];
                          return _buildOption(context, index, data);
                        },
                        childCount: profileOptions.length,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildOption(BuildContext context, int index, ProfileOptionModel data) {
    return ListTile(
      leading: data.icon,
      title: AutoSizeText(
        data.title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 18.0,
          color: data.titleColor,
        ),
      ),
      trailing: data.trailing,
      onTap: data.onClick,
    );
  }
}
