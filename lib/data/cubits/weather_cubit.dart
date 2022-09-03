import 'dart:io';

import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:weather_new/config/constants/apis.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(const WeatherInitialState());
  String weatherStr = "Press the cloud icon to get your location";
  int counter = 0;
  int themeId = 0;

  Future increase() async {
    if (counter < 10) {
      if (themeId == 0) {
        counter++;
      } else {
        counter += 2;
        if (counter > 10 || counter - 2 == 9) {
          counter = 10;
        }
      }
      emit(WeatherCountState(counter));
    }
  }

  Future decrease() async {
    if (counter > 0) {
      if (themeId == 0) {
        counter--;
      } else {
        counter -= 2;
        if (counter < 0 || counter + 2 == 1) {
          counter = 0;
        }
      }
      emit(WeatherCountState(counter));
    }
  }

  Future changeTheme(BuildContext context) async {
    if (themeId == 1) {
      themeId = 0;
    } else {
      themeId = 1;
    }
    DynamicTheme.of(context)!.setTheme(themeId);
    // emit(WeatherOnThemeChangedState(themeId));
  }

  Future getWeather() async {
    try {
      emit(const WeatherOnProgressState());
      var response = await get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        var row = parse(response.body).querySelector('div.padd-block');

        String today =
            row!.querySelector("div.current-day")!.text.split(",").last.trim();

        String temp = row
            .querySelector("div.current-forecast")!
            .querySelectorAll("span,span")[1]
            .querySelector("strong,strong")!
            .text;

        String tempN = row
            .querySelector("div.current-forecast")!
            .querySelectorAll("span,span")[2]
            .text;

        String? condition = row
            .querySelector("div.current-forecast-desc")!
            .text
            .split(",")
            .last
            .trim();

        weatherStr =
            "Forecast for Uzbekistan, Fergana : $today - $condition , $temp ($tempN),";

        emit(WeatherOnCompletedState(weatherStr));
      }
    } on SocketException {
      emit(const WeatherOnFailedState('Error with connection internet'));
    } catch (e) {
      emit(WeatherOnFailedState(e.toString()));
    }
  }
}
