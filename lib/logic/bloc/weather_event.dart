import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FeatchWeather extends WeatherEvent {
  final Position position;
  const FeatchWeather(this.position);

  @override
  List<Object> get props => [position];
}
