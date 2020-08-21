import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:background_location/background_location.dart' as bl;
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../config/configs.dart';
import '../core/core.dart';
import '../model/model.dart';
import '../repository/repository.dart';
import '../service/service.dart';

part 'feature/auth_cubit.dart';
part 'feature/connection_cubit.dart';
part 'feature/covid_cubit.dart';
part 'feature/google_map_cubit.dart';
part 'feature/history_cubit.dart';
part 'feature/hospital_cubit.dart';
part 'feature/location_device_cubit.dart';
part 'feature/location_permission_cubit.dart';
part 'feature/notification_cubit.dart';
part 'feature/splash_cubit.dart';
part 'feature/user_cubit.dart';
part 'top_level/language_cubit.dart';
part 'top_level/local_data_cubit.dart';
