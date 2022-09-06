import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_new/data/cubits/weather_cubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}



class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late AnimationController animationController1;
  final service = FlutterBackgroundService();



  late AnimationController animationController2;

  late Animation<double> scaleAnim1;
  late Animation<double> scaleAnim2;

  @override
  void initState() {
    animationController1 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    animationController2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));

    scaleAnim1 = Tween<double>(begin: 1, end: 0).animate(animationController1);
    scaleAnim2 = Tween<double>(begin: 0, end: 1).animate(animationController2);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        int count = context.read<WeatherCubit>().counter;
        if (count >= 1) {
          animationController2.forward();
        } else {
          animationController2.reverse();
        }
        if (count >= 10) {
          animationController1.forward();
        } else {
          animationController1.reverse();
        }
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
                        context.read<WeatherCubit>().weatherStr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                    const SizedBox(height: 15),
                    const Text(
                      "You have pressed the button this many time:",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      context.read<WeatherCubit>().counter.toString(),
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
                          AnimatedBuilder(
                            animation: animationController1,
                            builder: (context, child) {
                              return AnimatedScale(
                                scale: scaleAnim1.value,
                                duration: const Duration(milliseconds: 100),
                                child: FloatingActionButton(
                                  onPressed: () {
                                    context.read<WeatherCubit>().increase();
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AnimatedBuilder(
                            animation: animationController2,
                            builder: (BuildContext context, Widget? child) {
                              return AnimatedScale(
                                duration: const Duration(milliseconds: 100),
                                scale: scaleAnim2.value,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    context.read<WeatherCubit>().decrease();
                                  },
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
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
