import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:cqaaq_app/index.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class RegisterScreen extends StatefulWidget {
  static String id = "register_screen";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  /// [FormBuilder] key for the [FormBuilderState]
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  bool _isPasswordVisible = false;

  @override
  void initState() {
    _isPasswordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    _isPasswordVisible = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // is keyboard open
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: SafeArea(
              child: Image.asset(
                Assets.imagesSplashBackground,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Container(
          //   decoration: const BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage(Assets.imagesBackgroundTied),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Material(
              elevation: 40.0,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const Gap(15.0),
                        CustomText(
                          StringResource.registerText.toUpperCase(),
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).colorScheme.primary,
                          letterSpacing: 2.0,
                        ),
                        Gap(20.0.h),
                        FormBuilder(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              FormBuilderTextField(
                                name: "email",
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  prefixIcon: Icon(
                                    LineAwesomeIcons.envelope,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    gapPadding: 5.0,
                                  ),
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.email(),
                                ]),
                              ),
                              Gap(15.0.h),
                              FormBuilderTextField(
                                name: "password",
                                obscureText: !_isPasswordVisible,
                                textInputAction: TextInputAction.go,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  prefixIcon: Icon(
                                    LineAwesomeIcons.lock,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _isPasswordVisible = !_isPasswordVisible;
                                      });
                                    },
                                    child: Icon(
                                      _isPasswordVisible ? LineAwesomeIcons.eye_slash : LineAwesomeIcons.eye,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    gapPadding: 5.0,
                                  ),
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                                onSubmitted: (_) => _registerLogic(),
                              ),
                              Gap(25.0.h),
                              CustomButton(
                                title: StringResource.signUpText,
                                color: Theme.of(context).colorScheme.primary,
                                textSize: 18.0.sp,
                                onPressed: () => _registerLogic(),
                              ),
                              Gap(15.0.h),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(LoginScreen.id);
                                },
                                child: CustomText(
                                  StringResource.alreadyHaveAccountLoginText,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(10.0.h),
                        if (!isKeyboardOpen)
                          Column(
                            children: <Widget>[
                              Gap(5.0.h),
                              const AuthOptions(
                                showEmail: false,
                                showPhone: true,
                              ),
                              const Gap(10.0),
                              const TermsAndConditions(),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _checkInternet() async {
    List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
    if (!mounted) return;
    // if no internet connection, show error message and return
    if (connectivityResult.contains(ConnectivityResult.none)) {
      showCustomFlushBar(
        context: context,
        message: "No internet connection",
        icon: LineAwesomeIcons.exclamation_circle,
        iconColor: Theme.of(context).colorScheme.error,
      );
      return;
    }
  }

  _registerLogic() async {
    _checkInternet();
    showLoading(context);
    try {
      // if form is not filled return
      if (!(_formKey.currentState!.saveAndValidate())) {
        Navigator.of(context).pop();
        showCustomFlushBar(
          context: context,
          message: "Please provide all required fields",
        );
        return;
      }
      final email = _formKey.currentState!.fields['email']!.value as String;
      final password = _formKey.currentState!.fields['password']!.value as String;
      showLoading(context);
      // call the register method from the auth repo
      User? user = await userRepo.signUpWithEmailAndPassword(email.trim(), password);
      if (!mounted) return;
      Navigator.of(context).pop();
      if (user == null) {
        showCustomFlushBar(
          context: context,
          message: "Invalid email or password",
          icon: LineAwesomeIcons.exclamation_circle,
          iconColor: Theme.of(context).colorScheme.error,
        );
        return;
      }
      NavigationService.navigateTo(
        navigationMethod: NavigationMethod.push,
        page: () => BioDataScreen(email: email),
        isNamed: false,
      );
    } catch (e) {
      Navigator.of(context).pop();
      logger.e("Error signing up: $e");
      // remove [**] and return the error message
      String errorMessage = e.toString().replaceAll(RegExp(r'\[.*\]'), '');
      showCustomFlushBar(
        context: context,
        message: errorMessage,
        icon: LineAwesomeIcons.exclamation_circle,
        iconColor: Theme.of(context).colorScheme.error,
      );
    }
  }
}
