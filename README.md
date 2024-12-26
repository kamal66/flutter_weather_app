# Flutter Weather App

A modern Flutter-based weather application that provides accurate weather information using the OpenWeather API. The app utilizes BLoC for state management and offers a sleek and user-friendly interface with two primary screens:

1. **Home Screen**: Displays the current weather details for a selected area.
2. **Weekly Forecast Screen**: Shows the weather forecast for the entire week.

---

## Features

### Home Screen
- Current temperature in Celsius.
- Description of the atmosphere (e.g., Clear, Cloudy, Thunderstorm, etc.).
- Sunrise and sunset timings.
- Humidity level.
- Maximum and minimum temperatures for the day.

### Weekly Forecast Screen
- Daily temperature for the next 7 days.
- Atmospheric description for each day (e.g., Clear, Cloudy, Thunderstorm, etc.).

---

## Technologies Used

- **Flutter**: For building a cross-platform mobile application.
- **BLoC (Business Logic Component)**: For state management to separate business logic from UI.
- **OpenWeather API**: To fetch real-time weather data.
- **Dart**: Programming language used for Flutter development.

---

## Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- OpenWeather API Key (Get it from [OpenWeather](https://openweathermap.org/api))

## Folder Structure

lib/
├── bloc/
│   ├── weather_bloc.dart          # BLoC implementation for weather logic
│   ├── weather_event.dart         # Events for BLoC
│   └── weather_state.dart         # States for BLoC
├── data/
│   └── my_data.dart               # OpenWeather API Key
├── screens/
│   ├── data/
│   │   ├── gradient_text.dart     # Reusable widget for weather info
│   │   └── home_gradient.dart     # Reusable widget for weekly forecast
│   ├── home_screen.dart           # Home Screen UI
│   └── forecast_screen.dart       # Weekly Forecast UI
├── widgets/
│   ├── weather_card.dart          # Reusable widget for weather info
│   └── forecast_list.dart         # Reusable widget for weekly forecast
└── main.dart                      # App entry point


## API Integration

The app fetches weather data from the OpenWeather API, ensuring accurate and up-to-date information.

- **Endpoint for Current Weather**:  
  `https://api.openweathermap.org/data/2.5/weather`

- **Endpoint for Weekly Forecast**:  
  `https://api.openweathermap.org/data/2.5/forecast/daily`

---

## Screenshots

### Home Screen
*Shows current weather details for the selected location.*

### Weekly Forecast Screen
*Displays weather forecast for the next 7 days.*

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

- [Flutter Documentation](https://flutter.dev/docs)
- [OpenWeather API](https://openweathermap.org/api)
- The Flutter and Dart community for their support and resources!


