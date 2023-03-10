import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:weather_app/constants/api_constants.dart';
import 'package:weather_app/constants/app_constants.dart';
import 'package:weather_app/models/current_weather_model.dart';

final currentWeatherprovider =
    FutureProvider.family<CurrentWeatherModel?, String?>((ref, city) async {
  if (city == null) {
    return null;
  } else {
    final params = {
      "key": AppConstants.weatherAPIKey,
      "q": city,
      "aqi": "no",
    };

    Uri url = Uri.parse(ApiConstants.currentWeather);
    url = url.replace(queryParameters: params);

    final response = await get(url);

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return CurrentWeatherModel.fromJson(responseJson);
    } else {
      return null;
    }
  }
});
