import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';
import 'package:weather_app/core/router/router.dart';
import 'package:weather_app/core/services/location_services/location_services.dart';
import 'package:weather_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:weather_app/features/home/presentation/pages/home_view.dart';
import 'package:weather_app/features/home/presentation/pages/search_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // getCurrentLocation();
    super.initState();
  }

  void getCurrentLocation() async {
    // await LocationServices.getCurrentLocation();
    MagicRouter.navigateAndPopAll(HomeView());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        body: Center(
          child: Builder(builder: (context) {
            final cubit = HomeCubit.of(context);
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await LocationServices.getCurrentLocation();
                      MagicRouter.navigateAndPopAll(HomeView());
                    },
                    child: Text('Get Weather By location (GPS)'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      MagicRouter.navigateAndPopAll(const SearchView());
                    },
                    child: Text('Get Weather By City Name'),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
