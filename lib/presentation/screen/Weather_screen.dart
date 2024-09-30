import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_bloc/logic/bloc/weather_bloc.dart';
import 'package:weather_app_bloc/logic/bloc/weather_state.dart';
import 'package:weather_app_bloc/presentation/const/app_space.dart';
import 'package:weather_app_bloc/presentation/const/app_text_style.dart';
import 'package:weather_app_bloc/presentation/const/color.dart';
import 'package:weather_app_bloc/presentation/custom_widget/detailedwidget.dart';
import 'package:weather_app_bloc/presentation/custom_widget/image.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherBlocLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WeatherBlocSuccess) {
            return ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        appColor.primarylinearcolor,
                        appColor.secondarylinearcolor,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10), // Small height for spacing
                      Center(
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: getWeatherIcon(int.parse(
                              state.weather.weatherConditionCode.toString())),
                        ),
                      ),
                      // Display current temperature
                      Text(
                        '${state.weather.temperature!.celsius!.round()}\u00B0C',
                        style: appTextStyle.f40w400white,
                      ),
                      // Display weather condition and location
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            state.weather.weatherMain.toString().toUpperCase(),
                            style: appTextStyle.f25w500white,
                          ),
                          appSpace.width10,
                          Text(
                            '|',
                            style: appTextStyle.f25w100white,
                          ),
                          Text(
                            '📍${state.weather.areaName.toString()}',
                            style: appTextStyle.f20w100white,
                          ),
                        ],
                      ),
                      appSpace.height5,
                      // Display max and min temperatures
                      Text(
                        'Temp Feels Like: ${state.weather.tempFeelsLike}',
                        style: appTextStyle.f20w100white,
                      ),
                      appSpace.height20,

                      const Image(image: AssetImage('assets/images/House.png')),

                      // Forecast for the next 4 hours
                      Container(
                        height: 210,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              appColor.primarylinearcolor,
                              appColor.secondarylinearcolor,
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            appSpace.height10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Today',
                                  style: appTextStyle.f20w100white,
                                ),
                                Text(
                                  DateFormat('EEEE dd      ')
                                      .add_jm()
                                      .format(state.weather.date!),
                                  style: appTextStyle.f20w100white,
                                ),
                              ],
                            ),
                            appSpace.height5,
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                              height: 1,
                            ),
                            appSpace.height15,
                            Center(
                              child: SizedBox(
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.hourlyForecast.length,
                                  itemBuilder: (context, index) {
                                    final forecast =
                                        state.hourlyForecast[index];

                                    // Debugging output to ensure we have the correct weather condition code
                                    print(
                                        'Forecast for ${forecast.date}: ${forecast.temperature!.celsius!.round()}°C, Condition Code: ${forecast.weatherConditionCode}');

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Display forecast temperature
                                          Text(
                                            '${forecast.temperature!.celsius!.round()}\u00B0C',
                                            style: appTextStyle.f20w100white,
                                          ),
                                          // Display forecast icon based on weather condition code
                                          SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: getWeatherIcon(int.parse(
                                                forecast.weatherConditionCode
                                                    .toString())),
                                          ),
                                          // Display time of forecast
                                          Text(
                                            DateFormat.Hm()
                                                .format(forecast.date!),
                                            style: appTextStyle.f20w100white,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Show more detailed weather information
                      Center(
                        child: TextButton.icon(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0),
                                ),
                              ),
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        appColor.primarylinearcolor,
                                        appColor.secondarylinearcolor,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(25.0),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Center(
                                        child: Container(
                                          height: 5,
                                          width: 40,
                                          margin:
                                              const EdgeInsets.only(bottom: 20),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      // Detailed weather widget section
                                      DetailedWidget(
                                        iconname: 'Sunrise',
                                        icondetail: DateFormat()
                                            .add_jm()
                                            .format(state.weather.sunrise!),
                                        iconimage: const Image(
                                          height: 70,
                                          image:
                                              AssetImage('assets/images/1.png'),
                                        ),
                                        iconimage1: const Image(
                                          height: 80,
                                          image:
                                              AssetImage('assets/images/4.png'),
                                        ),
                                        iconname1: 'Sunset',
                                        icondetai1l: DateFormat()
                                            .add_jm()
                                            .format(state.weather.sunset!),
                                      ),
                                      const Divider(color: Colors.grey),
                                      DetailedWidget(
                                        iconname: 'Max',
                                        icondetail:
                                            '${state.weather.tempMax!.celsius!.round()}\u00B0C',
                                        iconimage: const Image(
                                          height: 70,
                                          image: AssetImage(
                                              'assets/images/10.png'),
                                        ),
                                        iconimage1: const Image(
                                          height: 70,
                                          image: AssetImage(
                                              'assets/images/11.png'),
                                        ),
                                        iconname1: 'Min',
                                        icondetai1l:
                                            '${state.weather.tempMin!.celsius!.round()}\u00B0C',
                                      ),
                                      const Divider(color: Colors.grey),
                                      DetailedWidget(
                                        iconname: 'Wind',
                                        icondetail:
                                            '${state.weather.windSpeed} mph',
                                        iconimage: const Image(
                                          height: 70,
                                          image: AssetImage(
                                              'assets/images/12.png'),
                                        ),
                                        iconimage1: const Image(
                                          height: 70,
                                          image: AssetImage(
                                              'assets/images/14.png'),
                                        ),
                                        iconname1: 'Humidity',
                                        icondetai1l:
                                            '${state.weather.humidity}%',
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                            size: 30,
                          ),
                          label: Text(
                            'Show Details',
                            style: appTextStyle.f20w100white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is WeatherBlocFailure) {
            return const Center(
              child: Text(
                'Failed to fetch weather data:',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const Center(
              child: Text(
                'Welcome! Please wait for the weather data...',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }
}
