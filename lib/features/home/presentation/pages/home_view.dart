import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/wi.dart';

import 'package:intl/intl.dart';
import 'package:weather_app/features/home/presentation/cubit/home_cubit.dart';

import '../../data/models/weather_model.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => HomeCubit()..geCurrentWeather(),
      child: Scaffold(
        key: scaffoldKey,
        // backgroundColor: Colors.blue,
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return state is HomeLodaing
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MainWeatherInfo(scaffoldKey: scaffoldKey),
                            const SizedBox(height: 20),
                            const TempByHourListViewWidget(),
                            const SizedBox(height: 20),
                            const TempByDayListViewWidget(),
                            const SizedBox(height: 20),
                            const SunriseSunsetWidget(),
                            const SizedBox(height: 20),
                            const UvWindHumidityWidget(),
                          ],
                        ),
                      ),
                    ),
                  );
          },
        ),
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.settings),
                    ),
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.star_rate_rounded),
                  title: Text('Favorite Location'),
                  trailing: Icon(Icons.error_outline),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: ListTile(
                    leading: Icon(
                      Icons.place,
                      size: 20,
                    ),
                    title: Text('Mansoura'),
                    trailing: Text(
                      '33°',
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ),
                const Divider(color: Colors.white, endIndent: 20, indent: 20),
                const ListTile(
                  leading: Icon(Icons.add_location_rounded),
                  title: Text('Favorite Location'),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: ListTile(
                    title: Text('Mansoura'),
                    trailing: Text(
                      '33°',
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Mange Location'),
                ),
                const Divider(color: Colors.white, endIndent: 20, indent: 20),
                const ListTile(
                  leading: Icon(Icons.error_outline),
                  title: Text('Report Wrong Location'),
                ),
                const ListTile(
                  leading: Icon(Icons.headphones),
                  title: Text('Contact Us'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UvWindHumidityWidget extends StatelessWidget {
  const UvWindHumidityWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit.of(context);
    final weather = cubit.weather;
    double? uv = weather!.current!.uv;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.grey[700]),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Iconify(Wi.moon_full, size: 40, color: Colors.yellow),
                  const Text('UV'),
                  Text(uv! < 3
                      ? 'Low'
                      : uv >= 3 || uv <= 5
                          ? 'Moderate'
                          : 'Hight'),
                ],
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 25),
            color: Colors.white,
            width: 1,
            height: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Iconify(Wi.strong_wind, size: 40, color: Colors.white),
                  const Text('Wind'),
                  Text('${weather.current!.windKph}%'),
                ],
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 25),
            color: Colors.white,
            width: 1,
            height: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Iconify(
                    Wi.humidity,
                    size: 40,
                    color: Colors.lightBlue[300],
                  ),
                  const Text('Humidity'),
                  Text('${weather.current!.humidity}%'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SunriseSunsetWidget extends StatelessWidget {
  const SunriseSunsetWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit.of(context);
    final weather = cubit.weather;
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: Colors.grey[700]),
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text('Sunrise'),
                      Text(weather!.forecast!.forecastday![0].astro!.sunrise
                          .toString()),
                      const Iconify(
                        Wi.sunrise,
                        size: 70,
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text('Sunset'),
                      Text(weather.forecast!.forecastday![0].astro!.sunset
                          .toString()),
                      const Iconify(
                        Wi.sunset,
                        size: 70,
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class TempByDayListViewWidget extends StatelessWidget {
  const TempByDayListViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit.of(context);
    final weather = cubit.weather;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.grey[700]),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 3,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 20,
        ),
        scrollDirection: Axis.vertical,
        itemCount: 7,
        itemBuilder: (context, index) {
          final forcatByDay = weather!.forecast!.forecastday![index];
          return TempByDayWidget(
            forcatByDay: forcatByDay,
          );
        },
      ),
    );
  }
}

class TempByHourListViewWidget extends StatelessWidget {
  const TempByHourListViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit.of(context);
    final weather = cubit.weather;
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: Colors.grey[700]),
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: 150,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              width: 20,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: 24,
            itemBuilder: (context, index) {
              final forcatByHour =
                  weather!.forecast!.forecastday![0].hour![index];

              return TempByHourWidget(forcatByHour: forcatByHour);
            },
          ),
        );
      },
    );
  }
}

class MainWeatherInfo extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const MainWeatherInfo({super.key, required this.scaffoldKey});
  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit.of(context);
    final weather = cubit.weather;
    final date = weather!.location!.localtime!.split(" ");
    DateTime day = DateTime.parse(date[0]);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: IconButton(
                onPressed: () => scaffoldKey.currentState!.openDrawer(),
                icon: const Icon(
                  Icons.menu_rounded,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${weather.current?.tempC}°',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Iconify(
                  Ic.round_wb_sunny,
                  size: 70,
                  color: Colors.orangeAccent,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Text(
                    '${weather.location!.name}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Icon(Icons.location_on),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${weather.forecast!.forecastday![0].day!.mintempC}° / ${weather.forecast!.forecastday![0].day!.maxtempC}° Feels like ${weather.current!.feelslikeC}°',
                  ),
                  Text(
                      '${DateFormat("EEEE").format(day)}, ${DateTime.now().hour - 12}:${DateTime.now().minute} pm'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class TempByDayWidget extends StatelessWidget {
  const TempByDayWidget({
    Key? key,
    required this.forcatByDay,
  }) : super(key: key);
  final Forecastday? forcatByDay;
  @override
  Widget build(BuildContext context) {
    DateTime day = DateTime.parse(forcatByDay!.date!);
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateTime.now().day == day.day
                      ? 'Today'
                      : DateFormat("EEEE").format(day),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                // const SizedBox(width: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.water_drop,
                      size: 15,
                    ),
                    Text('${forcatByDay!.day!.avghumidity.toInt()}%'),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: Row(
              children: [
                const Icon(
                  Icons.sunny,
                  color: Colors.orange,
                  size: 30,
                ),
                const Icon(
                  Icons.nights_stay,
                  color: Colors.orange,
                  size: 30,
                ),
                Text(
                    '${forcatByDay!.day!.mintempC!.toInt()}°/${forcatByDay!.day!.maxtempC!.toInt()}°'),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TempByHourWidget extends StatelessWidget {
  const TempByHourWidget({
    Key? key,
    required this.forcatByHour,
  }) : super(key: key);
  final Hour forcatByHour;
  @override
  Widget build(BuildContext context) {
    DateTime hour = DateTime.parse(forcatByHour.time!);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(DateFormat("h a").format(hour)),
          const SizedBox(height: 10),
          const Icon(
            Icons.sunny,
            color: Colors.orange,
            size: 30,
          ),
          const SizedBox(height: 10),
          Text('${forcatByHour.tempC}°'),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.water_drop,
                size: 15,
              ),
              Text('${forcatByHour.humidity}%')
            ],
          ),
        ],
      ),
    );
  }
}
