import 'package:flutter/material.dart';
import 'package:weather_app_bloc/presentation/const/app_space.dart';
import 'package:weather_app_bloc/presentation/const/app_text_style.dart';

class DetailedWidget extends StatelessWidget {
  final Image iconimage;
  final String iconname;
  final String icondetail;
  final Image iconimage1;
  final String iconname1;
  final String icondetai1l;

  const DetailedWidget({
    super.key,
    required this.iconimage,
    required this.iconname,
    required this.icondetail,
    required this.iconimage1,
    required this.iconname1,
    required this.icondetai1l,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Sunrise Column
        Expanded(
          child: Column(
            children: [
              iconimage,
              appSpace.height5,
              Text(
                iconname,
                style: appTextStyle.f20w100white,
                textAlign: TextAlign.center,
              ),
              Text(
                icondetail,
                style: appTextStyle.f20w100white,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        // Sunset Column
        Expanded(
          child: Column(
            children: [
              iconimage1,
              appSpace.height5,
              Text(
                iconname1,
                style: appTextStyle.f20w100white,
                textAlign: TextAlign.center,
              ),
              Text(
                icondetai1l,
                style: appTextStyle.f20w100white,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
