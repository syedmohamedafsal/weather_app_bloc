import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app_bloc/presentation/const/app_space.dart';
import 'package:weather_app_bloc/presentation/const/app_text_style.dart';
import 'package:weather_app_bloc/presentation/const/color.dart';
import 'package:weather_app_bloc/presentation/screen/Weather_screen.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: AlignmentDirectional.topCenter,
                    end: AlignmentDirectional.bottomCenter,
                    colors: [
                      appColor.primarylinearcolor,
                      appColor.secondarylinearcolor
                    ]),
              ),
            ),
            Column(
              children: [
                appSpace.height100,
                const Center(
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: Image(
                        image: AssetImage('assets/images/home_image.png')),
                  ),
                ),
                appSpace.height40,
                Text(
                  "Weather",
                  style: appTextStyle.f40w800white,
                ),
                Text(
                  "ForeCasts",
                  style: appTextStyle.f40w800yellow,
                ),
                appSpace.height50,
                TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(appColor.buttoncolor)),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => WeatherScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Text(
                        'Get Start',
                        style: appTextStyle.f20w700buttontxtcolor,
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
