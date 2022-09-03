import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_new/data/cubits/weather_cubit.dart';
import 'package:weather_new/presentation/routes/routes.dart';

import 'config/theme/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeCollection = ThemeCollection(
      themes: {
        0: Themes.lightTheme,
        1: Themes.darkTheme,
      },
    );
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //     systemNavigationBarIconBrightness: Brightness.dark,
    //     statusBarBrightness: Brightness.dark,
    //     statusBarIconBrightness: Brightness.dark));
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherCubit>(create: (_) => WeatherCubit()),
      ],
      child: DynamicTheme(
        defaultThemeId: 0,
        themeCollection: themeCollection,
        builder: (BuildContext context, ThemeData themeData) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: themeData,
            onGenerateRoute: (setting) => Routes.generateRoutes(setting),
          );
        },
      ),
    );
  }
}
