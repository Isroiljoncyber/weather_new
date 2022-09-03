part of 'weather_cubit.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherInitialState extends WeatherState {
  const WeatherInitialState();

  @override
  List<Object> get props => [];
}

class WeatherCountState extends WeatherState {
  const WeatherCountState(this.counter);

  final int counter;

  @override
  List<Object?> get props => [counter];
}

class WeatherOnProgressState extends WeatherState {
  const WeatherOnProgressState();

  @override
  List<Object?> get props => [];
}

class WeatherOnCompletedState extends WeatherState {
  const WeatherOnCompletedState(this.currentDayWeather);

  final String currentDayWeather;

  @override
  List<Object?> get props => [currentDayWeather];
}

class WeatherOnThemeChangedState extends WeatherState {
  const WeatherOnThemeChangedState(this.themeId);

  final int themeId;

  @override
  List<Object?> get props => [themeId];
}

class WeatherOnFailedState extends WeatherState {
  const WeatherOnFailedState(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
