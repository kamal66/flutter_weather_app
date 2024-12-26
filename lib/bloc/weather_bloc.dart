import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weatherappbloc/data/my_data.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>(
          (event, emit) async {
        emit(WeatherBlocLoading());
        try {
          WeatherFactory weatherFactory = WeatherFactory(
              API_KEY,
              language: Language.ENGLISH);


          Weather weather = await weatherFactory.currentWeatherByLocation(event.position.latitude, event.position.longitude);

          emit(WeatherBlocSuccess(weather, event.position));
        } catch (e) {
          print('Error >>>>>>>>>>>>>>> ${e.toString()}');
          emit(WeatherBlocFailure());
        }
      },
    );
    on<FetchWeeklyWeather>(
          (event, emit) async {
        emit(WeatherBlocLoading());
        try {
          WeatherFactory weatherFactory = WeatherFactory(
              API_KEY,
              language: Language.ENGLISH);

          List<Weather> forecasts = await weatherFactory.fiveDayForecastByLocation(event.position.latitude, event.position.longitude);
          final filteredList = filterUniqueDates(forecasts);
          emit(WeeklyWeatherBlocSuccess(filteredList));
        } catch (e) {
          print('Error >>>>>>>>>>>>>>> ${e.toString()}');
          emit(WeatherBlocFailure());
        }
      },
    );
  }

  List<Weather> filterUniqueDates(List<Weather> items) {
    final Set<String> seenDates = {};
    return items.where((item) {
      final dateString = item.date!.toIso8601String().split('T').first;
      if (seenDates.contains(dateString)) {
        return false;
      } else {
        seenDates.add(dateString);
        return true;
      }
    }).toList();
  }
}
