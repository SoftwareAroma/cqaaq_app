import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cqaaq_app/index.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pinput/pinput.dart';

class PhoneAuthScreen extends StatefulWidget {
  static String id = "phone_auth_screen";
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  /// [FormBuilder] key for the [FormBuilderState]
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController pinController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  String _verificationId = '';

  bool _isRequestingCode = false;
  bool _isCodeSent = false;
  // timer for the resend otp
  Timer? _timer;
  // ticker start time or the time the otp was sent
  int _start = 30;

  String phoneNumber = '';

  @override
  void initState() {
    _isRequestingCode = false;
    _isCodeSent = false;
    _timer = null;
    super.initState();
  }

  @override
  void dispose() {
    _isRequestingCode = false;
    _isCodeSent = false;
    _timer?.cancel();
    super.dispose();
  }

  // start timer for the resend otp
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start < 1) {
          timer.cancel();
          setState(() {
            _isCodeSent = false;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  // stop timer for the resend otp
  void stopTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final PinTheme defaultPinTheme = PinTheme(
      width: 56.0,
      height: 56.0,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

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
                  child: Column(
                    children: <Widget>[
                      Gap(16.0.h),
                      FormBuilder(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            CustomText(
                              _isRequestingCode ? "Enter OTP" : "Enter your phone number",
                              fontSize: 20.0.sp,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            Gap(30.0.h),
                            if (!_isRequestingCode)
                              FormBuilderPhoneField(
                                name: "phone",
                                defaultSelectedCountryIsoCode: 'GH',
                                textInputAction: TextInputAction.go,
                                decoration: InputDecoration(
                                  labelText: "Phone Number",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    gapPadding: 5.0,
                                  ),
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.numeric(),
                                  FormBuilderValidators.minLength(9),
                                ]),
                                onFieldSubmitted: (_) => _verifyPhoneNumber(),
                              ),
                            if (_isRequestingCode)
                              Column(
                                children: <Widget>[
                                  Directionality(
                                    // Specify direction if desired
                                    textDirection: TextDirection.ltr,
                                    child: Pinput(
                                      controller: pinController,
                                      focusNode: focusNode,
                                      length: 6,
                                      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                                      listenForMultipleSmsOnAndroid: true,
                                      defaultPinTheme: defaultPinTheme,
                                      separatorBuilder: (int index) => const Gap(8.0),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter OTP';
                                        }
                                        return null;
                                      },
                                      onClipboardFound: (String value) {
                                        debugPrint('onClipboardFound: $value');
                                        pinController.setText(value);
                                      },
                                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                                      onCompleted: (String pin) {
                                        debugPrint('onCompleted: $pin');
                                        _submitCode();
                                      },
                                      onChanged: (String value) {
                                        debugPrint('onChanged: $value');
                                      },
                                      cursor: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.only(bottom: 9),
                                            width: 22,
                                            height: 1,
                                            color: focusedBorderColor,
                                          ),
                                        ],
                                      ),
                                      focusedPinTheme: defaultPinTheme.copyWith(
                                        decoration: defaultPinTheme.decoration!.copyWith(
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: focusedBorderColor),
                                        ),
                                      ),
                                      submittedPinTheme: defaultPinTheme.copyWith(
                                        decoration: defaultPinTheme.decoration!.copyWith(
                                          color: fillColor,
                                          borderRadius: BorderRadius.circular(19),
                                          border: Border.all(color: focusedBorderColor),
                                        ),
                                      ),
                                      errorPinTheme: defaultPinTheme.copyBorderWith(
                                        border: Border.all(color: Colors.redAccent),
                                      ),
                                    ),
                                  ),
                                  Gap(15.0.h),
                                  // resend otp countdown timer display
                                  if (_isCodeSent)
                                    Text(
                                      "Resend OTP in $_start seconds",
                                      style: GoogleFonts.poppins(
                                        color: Theme.of(context).colorScheme.primary,
                                        fontSize: 16.0.sp,
                                      ),
                                    ),
                                  if (!_isCodeSent)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              _start = 30;
                                              _isCodeSent = false;
                                              _isRequestingCode = false;
                                            });
                                            // resend otp
                                            _verifyPhoneNumber();
                                          },
                                          child: Text(
                                            "Resend OTP",
                                            style: GoogleFonts.poppins(
                                              color: Theme.of(context).colorScheme.primary,
                                              fontSize: 12.0.sp,
                                            ),
                                          ),
                                        ),
                                        Gap(16.0.h),
                                        Container(
                                          height: 10.0.h,
                                          width: 1.0,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        Gap(16.0.h),
                                        InkWell(
                                          onTap: () {
                                            // stop the timer
                                            stopTimer();
                                            setState(() {
                                              _isCodeSent = false;
                                              _isRequestingCode = false;
                                              _start = 30;
                                            });
                                          },
                                          child: Text(
                                            StringResource.changePhoneNumberText,
                                            style: GoogleFonts.poppins(
                                              color: Theme.of(context).colorScheme.tertiary,
                                              fontSize: 12.0.sp,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                ],
                              ),
                            Gap(30.0.h),
                            if (!_isCodeSent)
                              CustomButton(
                                title: StringResource.continueText,
                                color: Theme.of(context).colorScheme.primary,
                                textSize: 18.0.sp,
                                onPressed: () async => await _verifyPhoneNumber(),
                              ),
                            if (_isCodeSent)
                              CustomButton(
                                title: StringResource.submitText,
                                color: Theme.of(context).colorScheme.primary,
                                textSize: 18.0.sp,
                                onPressed: () async => await _submitCode(),
                              ),
                            Gap(20.0.h),
                            const AuthOptions(),
                            Gap(10.0.h),
                            const TermsAndConditions(),
                            Gap(10.0.h),
                          ],
                        ),
                      ),
                    ],
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

  _verifyPhoneNumber() async {
    // hide the keyboard
    FocusScope.of(context).unfocus();
    // check for internet connection
    _checkInternet();
    // if form is not filled return
    if (!(_formKey.currentState!.saveAndValidate())) {
      showCustomFlushBar(
        context: context,
        message: "Please provide a valid phone number",
      );
      return;
    }
    try {
      showLoading(context);

      if (!_isRequestingCode) {
        setState(() {
          _isRequestingCode = true;
          _isCodeSent = true;
        });
        startTimer();
      }

      Map<String, dynamic> data = _formKey.currentState!.value;
      // replace the first 0
      final phone = data['phone'];
      final RegExp regExp = RegExp(r'^0+(?=.)');
      final String formattedPhone = phone.replaceAll(regExp, '');
      setState(() {
        phoneNumber = '+233$formattedPhone';
      });
      if (!_isRequestingCode) {
        // start the timer
        _timer = Timer(const Duration(seconds: 60), () {
          setState(() {
            _isCodeSent = false;
          });
        });
      }

      /// authentication with firebase
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,

        /// verification completed
        verificationCompleted: (PhoneAuthCredential credential) async {
          // debugPrint('verification complete >>> ${credential.smsCode}');
          // hide loading indicator
          Navigator.of(context).pop();

          /// update state
          setState(() {
            pinController.setText(credential.smsCode!);
          });
        },

        /// verification failed
        verificationFailed: (FirebaseAuthException error) {
          Navigator.of(context).pop();
          setState(() {
            _isCodeSent = false;
          });
        },

        /// code sent
        codeSent: (String verificationId, int? resendToken) async {
          Navigator.of(context).pop();
          // debugPrint('code sent >>> $verificationId');
          setState(() {
            _verificationId = verificationId;
          });
          showCustomFlushBar(
            context: context,
            message: 'OTP sent to $phoneNumber',
            duration: const Duration(seconds: 5),
            icon: LineAwesomeIcons.check_circle,
            iconColor: Theme.of(context).colorScheme.onPrimary,
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // debugPrint('code retrieval timeout >>> $verificationId');
          if (!mounted) return;
          // Navigator.of(context).pop();
          setState(() {
            _isCodeSent = false;
            pinController.setText('');
          });
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _submitCode() async {
    // hide the keyboard
    FocusScope.of(context).unfocus();

    /// check for internet connection
    _checkInternet();

    /// continue with login logic
    showLoading(context);
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: pinController.text.trim(),
      );
      // logger.i("credential: $credential");
      UserCredential user = await firebaseAuth.signInWithCredential(credential);
      // logger.i('response: $user');
      if (user.user != null) {
        bool response = await userRepo.checkUserData(FirebaseAuth.instance.currentUser!.uid);
        if (!mounted) return;
        // logger.i("is user data available: $response");
        if (!response) {
          NavigationService.offAll(
            page: () => BioDataScreen(phone: phoneNumber),
            isNamed: false,
          );
        } else {
          NavigationService.offAll(
            page: HomeScreen.id,
            isNamed: true,
          );
          showCustomFlushBar(
            context: context,
            message: "Welcome back",
          );
        }
      } else {
        if (!mounted) return;
        showCustomFlushBar(
          context: context,
          message: "There was an error verifying the code. Please try again.",
        );
      }
    } catch (e) {
      if (!mounted) return;
      logger.e('error: $e');
      Navigator.of(context).pop();
      showCustomFlushBar(
        context: context,
        message: "There was an error verifying the code. Please try again.",
      );
    }
  }
}
