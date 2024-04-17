import 'package:flutter/material.dart';

class ProfileOptionModel {
  String title;
  Widget icon;
  Color? titleColor;
  VoidCallback? onClick;
  Widget? trailing;

  ProfileOptionModel({
    required this.title,
    required this.icon,
    this.onClick,
    this.titleColor,
    this.trailing,
  });

  ProfileOptionModel.arrow({
    required this.title,
    required this.icon,
    this.onClick,
    this.titleColor = const Color(0xFF212121),
    this.trailing,
    // this.trailing = const Icon(
    //   LineAwesomeIcons.dot_circle,
    //   size: 20,
    //   color: Color(0xFF212121),
    // ),
  });
}
