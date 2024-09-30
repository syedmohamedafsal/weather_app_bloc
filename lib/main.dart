import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_bloc/logic/bloc/weather_bloc.dart';
import 'package:weather_app_bloc/logic/bloc/weather_event.dart';
import 'package:weather_app_bloc/presentation/screen/homepage.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WeatherBloc(), // Provide WeatherBloc at a higher level
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const LocationScreen(),
      ),
    );
  }
}

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late Future<Position> _positionFuture;

  @override
  void initState() {
    super.initState();
    _positionFuture =
        _determinePosition(); // Initialize location fetch on screen load
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _positionFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final position = snapshot.data as Position;
          // Trigger the fetch weather event when position is available
          BlocProvider.of<WeatherBloc>(context).add(FeatchWeather(position));
          return const Homepage();
        } else if (snapshot.hasError) {
          // If there is an error, show an error message
          return Scaffold(
            body: Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        } else {
          // Loading indicator while waiting for location permission or data
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled, return error.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, return error.
    return Future.error(
        'Location permissions are permanently denied, cannot request permissions.');
  }

  // Permissions granted, get the current position.
  return await Geolocator.getCurrentPosition();
}
