import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/router/router.dart';
import 'package:weather_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:weather_app/features/home/presentation/pages/home_view.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  MagicRouter.navigateAndPopAll(HomeView());
                },
                icon: Icon(Icons.home))
          ],
          title: Builder(
            builder: (context) {
              final cubit = HomeCubit.of(context);
              return TextField(
                onSubmitted: (value) async {
                  await cubit.search(value);

                  MagicRouter.navigateAndPopAll(
                    HomeView(
                      path:
                          'q=${cubit.weather!.location!.lat},${cubit.weather!.location!.lon}',
                    ),
                  );
                },
              );
            },
          ),
        ),
        body: Column(
          children: [
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                final cubit = HomeCubit.of(context);
                if (state is SearchLodaing) {
                  const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (cubit.weather == null) {
                  return const Center(
                    child: Text('Invalid City name'),
                  );
                } else {
                  final weather = cubit.weather;
                  return Column(
                    children: [
                      ListTile(
                        title: Text(weather!.location!.name!),
                        subtitle: Text(weather.location!.country!),
                      )
                    ],
                  );
                }
                return Center(child: Text('Invalid City name'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
