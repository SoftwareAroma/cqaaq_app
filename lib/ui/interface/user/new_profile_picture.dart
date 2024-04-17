import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:gap/gap.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:cqaaq_app/index.dart';

class NewProfilePictureScreen extends StatefulWidget {
  static const String id = 'new_profile_picture_screen';
  const NewProfilePictureScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NewProfilePictureScreenState();
}

class _NewProfilePictureScreenState extends State<NewProfilePictureScreen> {
  /// profile picture [FormBuilderState] key
  final GlobalKey<FormBuilderState> _profilePictureFormKey = GlobalKey<FormBuilderState>();

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

  @override
  Widget build(BuildContext context) {
    return BasePage(
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
        children: <Widget>[
          FormBuilder(
            key: _profilePictureFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Gap(20.0),
                  CustomText(
                    "Select Profile Picture or Take a Photo",
                    fontSize: 20.0,
                    maxLines: 2,
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.normal,
                  ),
                  const Gap(20.0),
                  FormBuilderImagePicker(
                    name: "avatar",
                    maxImages: 1,
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    iconColor: Theme.of(context).colorScheme.onPrimaryContainer,
                    decoration: const InputDecoration(
                      //remove the border
                      border: InputBorder.none,
                    ),
                    onSaved: (value) {
                      debugPrint("Value $value");
                    },
                    onChanged: (value) {
                      debugPrint("Value $value");
                    },
                  ),
                  const Gap(20.0),
                  CustomOutlineButton(
                    title: "Save",
                    fontSize: 18.0,
                    color: Theme.of(context).colorScheme.tertiary,
                    onPressed: () => _onSaveButton(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _onSaveButton() async {
    /// check internet connection
    _checkInternet();

    /// continue with the save
    if (_profilePictureFormKey.currentState!.saveAndValidate()) {
      showLoading(context);

      /// save the image to the user
      dynamic image = _profilePictureFormKey.currentState!.value['avatar'][0];
      // create a file from the image
      File file = File(image.path);
      // print(file);

      /// upload image to firestore and save the url to the user
      bool resp = await userController.updateProfilePicture(file);
      if (!mounted) return;
      if (resp) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        showCustomFlushBar(
          context: context,
          message: "Profile Picture Updated",
        );
      } else {
        Navigator.of(context).pop();
        showCustomFlushBar(
          context: context,
          message: "Error updating profile picture",
          iconColor: Colors.red,
          icon: LineAwesomeIcons.exclamation_circle,
        );
        return;
      }
    } else {
      showCustomFlushBar(
        context: context,
        message: "Please select an image",
        iconColor: Colors.red,
        icon: LineAwesomeIcons.exclamation_circle,
      );
    }
  }
}
