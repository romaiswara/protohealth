part of 'helper.dart';

class Utility{
  String formatNumber(value, {String separator='.'}) {
    return value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}$separator');
  }
}