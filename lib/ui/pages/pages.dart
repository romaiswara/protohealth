import 'dart:ui';

import 'package:animated_size_and_fade/animated_size_and_fade.dart';
// import 'package:connectivity/connectivity.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/configs.dart';
import '../../core/core.dart';
import '../../cubit/cubit.dart';
import '../../helper/helper.dart';
import '../../model/model.dart';
import '../../repository/repository.dart';
import '../../shared/shared.dart';
import '../../ui/widgets/widgets.dart';
import '../widgets/widgets.dart';

part 'account_page.dart';
part 'dashboard_page.dart';
part 'history_page.dart';
part 'home_page.dart';
part 'hospitals_page.dart';
part 'language_page.dart';
part 'login_page.dart';
part 'nearby_pharmacy_page.dart';
part 'nearby_rapid_test_page.dart';
part 'no_internet_page.dart';
part 'notification_page.dart';
part 'on_boarding_page.dart';
part 'profile_page.dart';
part 'select_address_maps_page.dart';
part 'splash_page.dart';
part 'update_covid_page.dart';
part 'update_covid_province_page.dart';
part 'update_profile_page.dart';
