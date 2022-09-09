import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/services/dio_helper/dio_helper.dart';
import 'package:weather_app/core/services/location_services/location_services.dart';
import 'package:weather_app/features/home/data/models/weather_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit of(context) => BlocProvider.of(context);
  Weather? weather;
  Future<void> geCurrentWeather() async {
    emit(HomeLodaing());
    try {
      final response = await DioHelper.get(
          'q=${LocationServices.currentPosition!.latitude},${LocationServices.currentPosition!.longitude}');
      weather = Weather.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
    }
    emit(HomeInitial());
  }
}
