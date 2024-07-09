import 'package:auto_size_text/auto_size_text.dart';
import 'package:cqaaq_app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: AutoSizeText(
              "Under Development",
              style: GoogleFonts.roboto(
                fontSize: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
