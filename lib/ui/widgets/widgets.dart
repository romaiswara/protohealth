import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../config/configs.dart';
import '../../core/core.dart';
import '../../cubit/cubit.dart';
import '../../helper/helper.dart';
import '../../model/model.dart';
import '../../shared/shared.dart';
import '../pages/pages.dart';

part 'card_general.dart';
part 'commons_widget.dart';
part 'custom_image_network.dart';
part 'custom_textfield.dart';
part 'dialog_error.dart';
part 'indicator.dart';
part 'item_list_hospital.dart';
part 'list_nearby_hospitals.dart';
part 'list_nearby_pharmacy.dart';
part 'list_nearby_rapid_test.dart';
part 'list_update_covid_province.dart';
part 'loader_covid_update.dart';
part 'loader_list_nearby_hospitals.dart';
part 'loader_list_nearby_pharmacy.dart';
part 'loader_list_nearby_rapid_test.dart';
part 'loader_list_update_covid_province.dart';
part 'loader_text.dart';
part 'loader_update_today.dart';
part 'login.dart';
part 'chart.dart';

List<String> metodeTest = ['Rapid Test', 'TCM', 'Swab Test'];
