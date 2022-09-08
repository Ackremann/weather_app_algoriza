import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/home/presentation/cubit/home_cubit.dart';

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
                ? Center(
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
                            TempByHourListViewWidget(),
                            const SizedBox(height: 20),
                            TempByDayListViewWidget(),
                            const SizedBox(height: 20),
                            SunriseSunsetWidget(),
                            const SizedBox(height: 20),
                            UvWindHumidityWidget(),
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
                ListTile(
                  leading: Icon(Icons.star_rate_rounded),
                  title: Text('Favorite Location'),
                  trailing: Icon(Icons.error_outline),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: ListTile(
                    leading: Icon(
                      Icons.place,
                      size: 20,
                    ),
                    title: Text('Mansoura'),
                    trailing: Text('33°'),
                  ),
                ),
                Divider(color: Colors.white),
                ListTile(
                  leading: Icon(Icons.add_location_rounded),
                  title: Text('Favorite Location'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: ListTile(
                    leading: Icon(
                      Icons.place,
                      size: 20,
                    ),
                    title: Text('Mansoura'),
                    trailing: Text('33°'),
                  ),
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
                children: const [
                  Icon(
                    Icons.sunny_snowing,
                    size: 40,
                  ),
                  Text('Sunrise'),
                  Text('5:21'),
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
                children: const [
                  Icon(
                    Icons.sunny_snowing,
                    size: 40,
                  ),
                  Text('Sunrise'),
                  Text('5:21'),
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
                children: const [
                  Icon(
                    Icons.sunny_snowing,
                    size: 40,
                  ),
                  Text('Sunrise'),
                  Text('5:21'),
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
                      Text(DateTime.fromMillisecondsSinceEpoch(
                              weather!.sys!.sunrise!)
                          .toString()),
                      Text('5:21'),
                    ],
                  ),
                  const Icon(
                    Icons.sunny_snowing,
                    size: 60,
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: const [
                      Text('Sunrise'),
                      Text('5:21'),
                    ],
                  ),
                  const Icon(
                    Icons.sunny_snowing,
                    size: 60,
                  )
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
        itemCount: 10,
        itemBuilder: (context, index) {
          return const TempByDayWidget();
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
        itemCount: 10,
        itemBuilder: (context, index) {
          return const TempByHourWidget();
        },
      ),
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
                  Icons.branding_watermark_rounded,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${weather!.main!.temp!.toInt()}°',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const Icon(
                  Icons.sunny,
                  size: 60,
                  color: Colors.orangeAccent,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Text(
                    '${weather.name}',
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
                      '${weather.main!.tempMin!.toInt()}° / ${weather.main!.tempMax!.toInt()}° Feels like ${weather.main!.feelsLike!.toInt()}°'),
                  Text(
                      'sun, ${DateTime.now().hour}:${DateTime.now().minute} pm'),
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Row(
              children: [
                Text(
                  'Today',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(width: 40),
                Icon(
                  Icons.water_drop,
                  size: 15,
                ),
                Text('0%'),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                const Text('33°/24'),
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('3 pm'),
          const SizedBox(height: 10),
          const Icon(
            Icons.sunny,
            color: Colors.orange,
            size: 30,
          ),
          const SizedBox(height: 10),
          const Text('33°'),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.water_drop,
                size: 15,
              ),
              Text('0%')
            ],
          ),
        ],
      ),
    );
  }
}
