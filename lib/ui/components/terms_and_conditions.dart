import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditions extends StatelessWidget {
  final String? text1;
  final String? text2;
  final String? text3;
  const TermsAndConditions({
    super.key,
    this.text1,
    this.text2,
    this.text3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Gap(10.0),
        const Divider(),
        AutoSizeText(
          text1 ?? 'By continuing, you agree to our ',
          style: GoogleFonts.poppins(
            fontSize: 12.0,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const Gap(4.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                // open web view
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (BuildContext context) => MyWebView(selectedUrl: termsAndConditionsUrl),
                //   ),
                // );
              },
              child: AutoSizeText(
                text2 ?? 'Terms and Conditions',
                style: GoogleFonts.poppins(
                  fontSize: 12.0,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        if (text3 != null) const Gap(5.0),
        if (text3 != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  // open web view
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) => MyWebView(selectedUrl: termsAndConditionsUrl),
                  //   ),
                  // );
                },
                child: AutoSizeText(
                  text3 ?? 'privacy policy',
                  style: GoogleFonts.poppins(
                    fontSize: 12.0,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
