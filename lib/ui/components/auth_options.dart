import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:cqaaq_app/index.dart';

class AuthOptions extends StatelessWidget {
  final bool showPhone;
  final bool showEmail;
  const AuthOptions({
    super.key,
    this.showPhone = false,
    this.showEmail = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if (showEmail)
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                LoginScreen.id,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Icon(
                FontAwesomeIcons.envelope,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        if (showPhone)
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, PhoneAuthScreen.id);
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Icon(
                FontAwesomeIcons.phone,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        const Gap(15.0),
        InkWell(
          onTap: () {
            showCustomFlushBar(
              context: context,
              message: "Google Sign In is not yet available.",
            );
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Icon(
              FontAwesomeIcons.google,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        const Gap(15.0),
        InkWell(
          onTap: () {
            showCustomFlushBar(
              context: context,
              message: "Apple Sign In is not yet available.",
            );
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Icon(
              FontAwesomeIcons.apple,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
