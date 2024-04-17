import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:cqaaq_app/index.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// [Scaffold] key for the [ScaffoldState]
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    return Scaffold(
      key: _scaffoldKey,
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
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: <Widget>[
                        const Gap(10.0),
                        CustomText(
                          StringResource.loginText.toUpperCase(),
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).colorScheme.primary,
                          letterSpacing: 2.0,
                        ),
                        const Gap(30.0),
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
                              const Gap(15.0),
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
                                onSubmitted: (value) => _loginLogic(),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                              ),
                              const Gap(20.0),
                              CustomButton(
                                title: StringResource.loginText,
                                color: Theme.of(context).colorScheme.primary,
                                textSize: 18.0.sp,
                                onPressed: () => _loginLogic(),
                              ),
                              const Gap(15.0),
                              InkWell(
                                onTap: () {
                                  NavigationService.navigateTo(
                                    navigationMethod: NavigationMethod.push,
                                    page: RegisterScreen.id,
                                    isNamed: true,
                                  );
                                },
                                child: CustomText(
                                  StringResource.noAccountYetRegisterText,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              const Gap(25.0),
                              const AuthOptions(
                                showEmail: false,
                                showPhone: true,
                              ),
                              const Gap(10.0),
                              const TermsAndConditions(),
                            ],
                          ),
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

  _loginLogic() async {
    /// check internet connection
    _checkInternet();

    /// continue with the login
    showLoading(context);
    try {
      // hide all keyboard
      FocusScope.of(context).unfocus();
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      // if form is not filled return
      if (!(_formKey.currentState!.saveAndValidate())) {
        Navigator.of(context).pop();
        showCustomFlushBar(
          context: context,
          message: "Please provide all required fields",
        );
        return;
      }

      String email = _formKey.currentState!.fields['email']!.value.toString();
      String password = _formKey.currentState!.fields['password']!.value.toString();

      User? response = await userRepo.signInWithEmailAndPassword(email, password);
      if (!mounted) return;
      if (response == null) {
        Navigator.of(context).pop();
        showCustomFlushBar(
          context: context,
          message: "Invalid email or password",
          icon: LineAwesomeIcons.exclamation_circle,
          iconColor: Theme.of(context).colorScheme.error,
        );
        return;
      } else {
        var userExist = await userRepo.checkUserData(firebaseAuth.currentUser!.uid);
        if (!mounted) return;
        if (userExist) {
          NavigationService.offAll(
            page: HomeScreen.id,
            isNamed: true,
          );
          showCustomFlushBar(
            context: context,
            message: "Welcome back",
            icon: LineAwesomeIcons.check_circle,
            iconColor: Theme.of(context).colorScheme.onPrimary,
          );
        } else {
          NavigationService.offAll(
            page: () => BioDataScreen(email: email),
            isNamed: false,
          );
          showCustomFlushBar(
            context: context,
            message: "Please Complete your profile",
            icon: LineAwesomeIcons.check_circle,
            iconColor: Theme.of(context).colorScheme.onPrimary,
          );
        }
      }
    } catch (e) {
      Navigator.of(context).pop();
      // remove [**] and return the error message
      String error = e.toString().replaceAll(RegExp(r'\[.*\]'), '');
      showCustomFlushBar(context: context, message: error);
    }
  }
}
