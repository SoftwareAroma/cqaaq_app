import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cqaaq_app/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class BioDataScreen extends StatefulWidget {
  static String id = "bio_data_screen";

  final UserModel? user;
  final String? email;
  final String? phone;
  const BioDataScreen({
    super.key,
    this.user,
    this.email,
    this.phone,
  });

  @override
  State<BioDataScreen> createState() => _BioDataScreenState();
}

class _BioDataScreenState extends State<BioDataScreen> {
  /// [FormBuilder] key for the [FormBuilderState]
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  /// [Scaffold] key for the [ScaffoldState]
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    if (widget.email != null) {
      _formKey.currentState?.patchValue({
        "email": widget.email,
      });
    }
    if (widget.phone != null) {
      _formKey.currentState?.patchValue({
        "phone": widget.phone,
      });
    }
    if (widget.user != null) {
      _formKey.currentState?.patchValue({
        "first_name": widget.user?.firstName,
        "last_name": widget.user?.lastName,
        "other_name": widget.user?.otherName,
        "phone": widget.user?.phone,
        "region": widget.user?.region,
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // logger.i("BioDataScreen: $email, $phone, $userModel");
    // logger.i("BioDataScreen: ${widget.arguments}");
    return Scaffold(
      key: _scaffoldKey,
      appBar: widget.user != null
          ? AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
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
              centerTitle: true,
              title: Text(
                "Update Bio Data",
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.w),
            child: Column(
              children: <Widget>[
                Gap(15.0.h),
                CustomText(
                  StringResource.bioDataInfoTitle.toUpperCase(),
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.primary,
                  letterSpacing: 2.0,
                ),
                Gap(10.0.h),
                CustomText(
                  StringResource.bioDataInfoText,
                  maxLines: 15,
                  textAlign: TextAlign.justify,
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 12.0.sp,
                ),
                Gap(20.0.h),
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      if ((widget.user != null && widget.email == null) || (widget.email == null))
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
                              borderRadius: BorderRadius.circular(10.0.r),
                              gapPadding: 5.0,
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.email(),
                          ]),
                        ),
                      if ((widget.user != null && widget.email == null) || (widget.email == null)) Gap(15.0.h),
                      FormBuilderTextField(
                        name: "uid",
                        enabled: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        initialValue: widget.user == null ? randomString() : widget.user?.uid,
                        decoration: InputDecoration(
                          labelText: "ID Number",
                          prefixIcon: Icon(
                            LineAwesomeIcons.user,
                            color: Theme.of(context).colorScheme.onBackground.withOpacity(
                                  0.3,
                                ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                            gapPadding: 5.0,
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      Gap(15.0.h),
                      FormBuilderTextField(
                        name: "first_name",
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "First Name",
                          prefixIcon: Icon(
                            LineAwesomeIcons.user,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                            gapPadding: 5.0,
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      Gap(15.0.h),
                      FormBuilderTextField(
                        name: "last_name",
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Last Name",
                          prefixIcon: Icon(
                            LineAwesomeIcons.user,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                            gapPadding: 5.0,
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      Gap(15.0.h),
                      FormBuilderTextField(
                        name: "other_name",
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Other Name",
                          prefixIcon: Icon(
                            LineAwesomeIcons.user,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                            gapPadding: 5.0,
                          ),
                        ),
                      ),
                      Gap(15.0.h),
                      FormBuilderTextField(
                        name: "phone",
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          prefixIcon: Icon(
                            LineAwesomeIcons.phone,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                            gapPadding: 5.0,
                          ),
                        ),
                      ),
                      Gap(15.0.h),
                      FormBuilderTextField(
                        name: "region",
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Region",
                          prefixIcon: Icon(
                            LineAwesomeIcons.registered_trademark,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                            gapPadding: 5.0,
                          ),
                        ),
                      ),
                      Gap(15.0.h),
                      FormBuilderTextField(
                        name: "district",
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "District",
                          prefixIcon: Icon(
                            LineAwesomeIcons.directions,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                            gapPadding: 5.0,
                          ),
                        ),
                      ),
                      Gap(20.0.h),
                      FormBuilderTextField(
                        name: "position",
                        textInputAction: TextInputAction.go,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Position",
                          prefixIcon: Icon(
                            LineAwesomeIcons.user_graduate,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                            gapPadding: 5.0,
                          ),
                        ),
                        onSubmitted: (_) => widget.user == null ? _saveLogic() : _updateLogic(),
                      ),
                      Gap(20.0.h),
                      CustomButton(
                        title: "Save",
                        color: Theme.of(context).colorScheme.primary,
                        textSize: 18.0.sp,
                        onPressed: () => widget.user == null ? _saveLogic() : _updateLogic(),
                      ),
                      Gap(10.0.h),
                      const TermsAndConditions(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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

  _updateLogic() async {
    /// hide all keyboards
    FocusScope.of(context).unfocus();
    // if form is not filled return
    if (!(_formKey.currentState!.saveAndValidate())) {
      showCustomFlushBar(
        context: context,
        message: "Please provide all required fields",
      );
      return;
    }
    _checkInternet();

    // get the form data
    final Map<String, dynamic> formData = _formKey.currentState!.value;
    final String uid = formData['uid'];
    final String firstName = formData['first_name'];
    final String lastName = formData['last_name'];
    final String? otherName = formData['other_name'];
    final String phoneNumber = formData['phone'];
    final String region = formData['region'];
    final String district = formData['district'];
    final String position = formData['position'];
    final String email = formData['email'];
    Map<String, dynamic> data = {
      "id": widget.user?.id,
      "uid": widget.user?.uid ?? uid,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "otherName": otherName,
      "phone": phoneNumber,
      "region": region,
      "district": district,
      "position": position,
      "avatar": widget.user?.avatar,
      // "reports": widget.userModel?.reports,
    };
    UserModel user = UserModel.fromJson(data);
    showLoading(context);
    bool response = await userRepo.updateUserData(user.toJson());
    if (!mounted) return;
    Navigator.of(context).pop();
    if (!response) {
      showCustomFlushBar(
        context: context,
        message: "Error updating bio data",
        icon: LineAwesomeIcons.exclamation_circle,
        iconColor: Theme.of(context).colorScheme.error,
      );
      return;
    }

    Navigator.of(context).pop();
    Navigator.of(context).pop();
    showCustomFlushBar(context: context, message: "Bio Data updated successfully.");
  }

  _saveLogic() async {
    /// hide all keyboards
    FocusScope.of(context).unfocus();
    // if form is not filled return
    if (!(_formKey.currentState!.saveAndValidate())) {
      showCustomFlushBar(
        context: context,
        message: "Please provide all required fields",
      );
      return;
    }
    _checkInternet();
    final auth = FirebaseAuth.instance;

    // get the form data
    final Map<String, dynamic> formData = _formKey.currentState!.value;
    final String uid = formData['uid'];
    final String firstName = formData['first_name'];
    final String lastName = formData['last_name'];
    final String? otherName = formData['other_name'];
    final String phoneNumber = formData['phone'];
    final String region = formData['region'];
    final String district = formData['district'];
    final String position = formData['position'];
    final String email = formData['email'];
    Map<String, dynamic> data = {
      "uid": uid,
      "id": auth.currentUser!.uid,
      "firstName": firstName,
      "lastName": lastName,
      "region": region,
      "reports": [],
      "district": district,
      "position": position,
      "email": auth.currentUser?.email ?? email,
      "phone": phoneNumber,
      "otherName": otherName ?? "",
      "avatar": defaultAvatarUrl,
    };
    showLoading(context);
    bool response = await userRepo.saveUserData(data);
    if (!mounted) return;
    Navigator.of(context).pop();
    if (!response) {
      showCustomFlushBar(
        context: context,
        message: "There was an error, please try again later.",
        icon: LineAwesomeIcons.exclamation_circle,
        iconColor: Theme.of(context).colorScheme.error,
      );
      return;
    }
    NavigationService.offAll(
      page: HomeScreen.id,
      isNamed: true,
    );
    showCustomFlushBar(context: context, message: "Welcome $firstName.");
  }
}

String randomString({int length = 8}) {
  const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
  Random rnd = Random.secure();
  String value = String.fromCharCodes(
    Iterable.generate(
      length,
      (_) => chars.codeUnitAt(
        rnd.nextInt(chars.length),
      ),
    ),
  );

  /// add CQAAQ-GH- infront of the generated code
  return 'CQAAQ-GH-$value';
}
