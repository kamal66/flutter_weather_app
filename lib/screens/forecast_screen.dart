import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weatherappbloc/bloc/weather_bloc.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen(
      {super.key, required this.weather, required this.position});

  final Weather weather;
  final Position position;

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  String getWeatherIconString(int code) {
    switch (code) {
      case >= 200 && < 300:
        return 'assets/1.png';
      case >= 300 && < 400:
        return 'assets/2.png';
      case >= 500 && < 600:
        return 'assets/3.png';
      case >= 600 && < 700:
        return 'assets/4.png';
      case >= 700 && < 800:
        return 'assets/5.png';
      case == 800:
        return 'assets/6.png';
      case > 800 && <= 804:
        return 'assets/7.png';
      default:
        return 'assets/7.png';
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WeatherBloc()..add(FetchWeeklyWeather(widget.position)),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: Container(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(1, -0.2),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.deepPurple),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-1, -0.2),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.deepPurple),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(1, -1.2),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.15,
                  height: 360,
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle, color: Color(0xFF4A00E0)),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(1.25, -0.95),
                child: Image.asset(
                  getWeatherIconString(widget.weather.weatherConditionCode!),
                  width: 180,
                  scale: 1,
                ),
              ),
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(
                        20, 1.2 * kToolbarHeight, 20, 20),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                child: Image.asset(
                                  'assets/left_arrow.png',
                                  width: 30,
                                  height: 30,
                                ),
                                onTap: () => Navigator.pop(context),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Expanded(
                                  child: Text(
                                'Back',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w400),
                              )),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/calendar.png',
                                width: 28,
                                height: 28,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Expanded(
                                  child: Text(
                                'This Week',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w500),
                              )),
                            ],
                          ),
                          if (state is WeeklyWeatherBlocSuccess) ...[
                            Expanded(
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return _listWidget(state.forecasts[index]);
                                },
                                separatorBuilder: (context, index) => Divider(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                                itemCount: state.forecasts.length,
                                padding: const EdgeInsets.all(0),
                              ),
                            ),
                          ] else ...[
                            const Expanded(
                                child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ))
                          ]
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  String getDayAbbreviation(DateTime date) {
    const List<String> days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    return days[date.weekday - 1];
  }

  Widget _listWidget(Weather weather) {
    return Row(
      children: [
        Expanded(
            child: Text(
          getDayAbbreviation(weather.date!),
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        )),
        Image.asset(
          getWeatherIconString(weather.weatherConditionCode!),
          width: 28,
          height: 28,
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            weather.weatherMain!,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Text(
          '${weather.temperature!.celsius!.round()}°',
          style: const TextStyle(
              color: Colors.white, fontSize: 60, fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
