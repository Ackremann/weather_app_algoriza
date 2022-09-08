import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weather_app/core/router/router.dart';
import 'package:weather_app/core/services/location_services/location_services.dart';
import 'package:weather_app/features/home/presentation/pages/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  void getCurrentLocation() async {
    final position = await LocationServices.getCurrentLocation();
    print(position.altitude);
    print(position.longitude);
    print(LocationServices.currentPosition!.altitude);
    print(LocationServices.currentPosition!.longitude);
    MagicRouter.navigateAndPopAll(HomeView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [Text('data')],
      ),
    );
  }
}
