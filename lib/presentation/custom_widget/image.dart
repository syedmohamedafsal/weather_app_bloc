import 'package:flutter/material.dart';

Widget getWeatherIcon(int code){
  switch (code) {
    case >= 200 && < 300:
    return const Image(image: AssetImage('assets/images/8.png'));
    case >= 300 && < 400:
    return const Image(image: AssetImage('assets/images/13.png'));
    case >= 500 && < 600:
    return const Image(image: AssetImage('assets/images/7.png'));
    case >= 600 && < 700:
    return const Image(image: AssetImage('assets/images/5.png'));
    case >= 700 && < 800:
    return const Image(image: AssetImage('assets/images/15.png'));
    case == 800:
    return const Image(image: AssetImage('assets/images/1.png'));
    case >= 800 && < 804:
    return const Image(image: AssetImage('assets/images/2.png'));
    default:
    return const Image(image: AssetImage('assets/images/3.png'));
  }
}
