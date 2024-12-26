part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();
}

final class WeatherInitial extends WeatherState {
  @override
  List<Object> get props => [];
}

final class WeatherBlocLoading extends WeatherState {
  @override
  List<Object> get props => [];
}

final class WeatherBlocFailure extends WeatherState {
  @override
  List<Object> get props => [];
}

final class WeatherBlocSuccess extends WeatherState {
  final Weather weather;
  final Position position;

  const WeatherBlocSuccess(this.weather, this.position);

  @override
  List<Object> get props => [weather, position];
}

final class WeeklyWeatherBlocSuccess extends WeatherState {
  final List<Weather> forecasts;

  const WeeklyWeatherBlocSuccess(this.forecasts);

  @override
  List<Object> get props => [forecasts];
}
