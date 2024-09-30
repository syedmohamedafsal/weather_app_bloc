import 'package:flutter/material.dart';
import 'package:weather_app_bloc/presentation/const/color.dart';

AppTextStyle appTextStyle = AppTextStyle();

class AppTextStyle {
  TextStyle f20w700buttontxtcolor = TextStyle(
    color: appColor.buttontxtcolor,
    fontSize: 20,
    fontFamily: 'popins_bold',
  );
  TextStyle f20w100white = TextStyle(
    color: appColor.primarytxtcolor,
    fontSize: 20,
    fontFamily: 'popins_regular',
  );
  TextStyle f25w500white = TextStyle(
    color: appColor.primarytxtcolor,
    fontSize: 25,
    fontFamily: 'popins_bold',
  );
  TextStyle f25w100white = TextStyle(
    color: appColor.primarytxtcolor,
    fontSize: 25,
    fontFamily: 'popins_light',
  );
  TextStyle f30w400white = TextStyle(
    color: appColor.primarytxtcolor,
    fontSize: 30,
    fontFamily: 'popins_semibold',
    letterSpacing: 2,
  );
   TextStyle f40w400white = TextStyle(
    color: appColor.primarytxtcolor,
    fontSize: 40,
    fontFamily: 'popins_semibold',
    letterSpacing: 2,
  );
  TextStyle f40w800white = TextStyle(
      color: appColor.primarytxtcolor,
      fontSize: 40,
      fontFamily: 'popins_bold',
      letterSpacing: 2,
      fontWeight: FontWeight.w800);
  TextStyle f40w800yellow = TextStyle(
    color: appColor.secondarytxtcolor,
    fontFamily: 'popins_medium',
    fontSize: 40,
  );
}
