import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_new/data/cubits/weather_cubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Weather Counter"),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (state is WeatherOnProgressState)
                      const CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    if (state is! WeatherOnProgressState)
                      Text(
                        context
                            .read<WeatherCubit>()
                            .weatherStr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                    const SizedBox(height: 15),
                    const Text(
                      "You have pressed the button this many time:",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      context
                          .read<WeatherCubit>()
                          .counter
                          .toString(),
                      style: const TextStyle(fontSize: 30),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              context.read<WeatherCubit>().getWeather();
                            },
                            child: const Icon(
                              Icons.cloud,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              context.read<WeatherCubit>().changeTheme(context);
                            },
                            child: const Icon(
                              Icons.color_lens,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Visibility(
                            maintainInteractivity: true,
                            maintainState: true,
                            maintainSize: true,
                            maintainAnimation: true,
                            visible: context.read<WeatherCubit>().counter != 10,
                            child: FloatingActionButton(
                              onPressed: () {
                                context.read<WeatherCubit>().increase();
                              },
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            maintainInteractivity: true,
                            maintainAnimation: true,
                            maintainSize: true,
                            maintainState: true,
                            visible: context.read<WeatherCubit>().counter != 0,
                            child: FloatingActionButton(
                              onPressed: () {
                                context.read<WeatherCubit>().decrease();
                              },
                              child: const Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
