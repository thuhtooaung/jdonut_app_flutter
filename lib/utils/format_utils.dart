import 'package:intl/intl.dart';

class FormatUtils {
  static String formatDuration(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  static String formatMonthName(DateTime value) {
    final formatter = DateFormat('MMMM');
    return formatter.format(value);
  }

  static String formatPrice(num value) {
    final formatter = NumberFormat('#,###');
    return formatter.format(value);
  }
}
