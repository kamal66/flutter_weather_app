part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchWeather extends WeatherEvent{
  final Position position;

  FetchWeather(this.position);

  @override
  List<Object?> get props => [position];

}

class FetchWeeklyWeather extends WeatherEvent{
  final Position position;

  const FetchWeeklyWeather(this.position);

  @override
  List<Object?> get props => [position];

}



