import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weatherappbloc/bloc/weather_bloc.dart';
import 'package:weatherappbloc/screens/forecast_screen.dart';
import 'package:weatherappbloc/screens/widgets/gradient_text.dart';
import 'package:weatherappbloc/screens/widgets/home_gradient.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  String getGreetingMessage() {
    final DateTime now = DateTime.now();
    final int hour = now.hour;

    if (hour >= 5 && hour < 12) {
      return "Good Morning";
    } else if (hour >= 12 && hour < 17) {
      return "Good Afternoon";
    } else if (hour >= 17 && hour < 21) {
      return "Good Evening";
    } else {
      return "Good Night";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _determinePosition(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return BlocProvider(
            create: (context) =>
                WeatherBloc()..add(FetchWeather(snapshot.data as Position)),
            child: Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.light),
              ),
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    const HomeGradient(),
                    BlocBuilder<WeatherBloc, WeatherState>(
                      builder: (context, state) {
                        if (state is WeatherBlocSuccess) {
                          return SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20, 1.2 * kToolbarHeight, 20, 20),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${state.weather.areaName}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Image.asset(
                                          'assets/top_right.png',
                                          width: 10,
                                          height: 10,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      getGreetingMessage(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 25),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                        child: Image.asset(
                                      getWeatherIconString(
                                          state.weather.weatherConditionCode!),
                                      width: 200,
                                      height: 200,
                                    )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Text(
                                        '${state.weather.temperature!.celsius!.round()}°C',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 55,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        state.weather.weatherMain!
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        DateFormat('EEEE dd •')
                                            .add_jm()
                                            .format(state.weather.date!),
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    NextDayButton(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ForecastScreen(
                                              weather: state.weather,
                                              position: state.position,
                                            ),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconTextWidget(
                                          image: 'assets/11.png',
                                          title: 'Sunrise',
                                          dateTime: state.weather.sunrise,
                                        ),
                                        IconTextWidget(
                                          image: 'assets/12.png',
                                          title: 'Sunset',
                                          dateTime: state.weather.sunset,
                                        ),
                                      ],
                                    ),
                                    const DividerWidget(),
                                    HomeDataRow(
                                      title1: 'Feels Like',
                                      title2: 'Humidity',
                                      data1: '${state.weather.tempFeelsLike}',
                                      data2:
                                          '${state.weather.humidity!.round()}%',
                                    ),
                                    const DividerWidget(),
                                    HomeDataRow(
                                      title1: 'Temp Max',
                                      title2: 'Temp Min',
                                      data1:
                                          '${state.weather.tempMax!.celsius!.round()}°C',
                                      data2:
                                          '${state.weather.tempMin!.celsius!.round()}°C',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator(color: Colors.white,));
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light),
            ),
            body: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    HomeGradient(),
                    Center(
                        child: CircularProgressIndicator(color: Colors.white))
                  ],
                )),
          );
        }
      },
    );
  }

  Future<Position?> _determinePosition() async {
    final hasPermission = await _handlePermission();
    if (!hasPermission) {
      return null;
    }
    late LocationSettings locationSettings;
    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
          accuracy: LocationAccuracy.lowest,
          distanceFilter: 100,
          forceLocationManager: true,
          intervalDuration: const Duration(seconds: 10),
          foregroundNotificationConfig: const ForegroundNotificationConfig(
            notificationText:
                "Example app will continue to receive your location even when you aren't using it",
            notificationTitle: "Running in Background",
            enableWakeLock: true,
          ));
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.lowest,
        activityType: ActivityType.fitness,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: true,
        showBackgroundLocationIndicator: false,
      );
    }
    return await Geolocator.getCurrentPosition(
        locationSettings: locationSettings);
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;

    serviceEnabled = await geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }
}

class NextDayButton extends StatelessWidget {
  const NextDayButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GradientText(
              'Next days',
              gradient: LinearGradient(
                colors: [Colors.deepPurple.shade300, Colors.yellow.shade300],
              ),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset(
              'assets/right_arrow.png',
              width: 30,
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Divider(
        color: Colors.white.withOpacity(0.2),
      ),
    );
  }
}

class HomeDataRow extends StatelessWidget {
  const HomeDataRow({
    super.key,
    required this.title1,
    required this.title2,
    required this.data1,
    required this.data2,
  });

  final String title1, title2, data1, data2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title1,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              data1,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title2,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              data2,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}

class IconTextWidget extends StatelessWidget {
  const IconTextWidget({
    super.key,
    required this.image,
    required this.title,
    this.dateTime,
  });

  final String image, title;
  final DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          image,
          scale: 8,
          width: 36,
          height: 36,
        ),
        const SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ' $title',
              style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              dateTime != null
                  ? DateFormat('').add_jm().format(dateTime!)
                  : '---',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ],
        )
      ],
    );
  }
}
