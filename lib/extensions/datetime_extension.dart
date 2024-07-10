import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String formatDate() {
    return DateFormat('EEEE, MMM d, yyyy').format(this);
  }

  String formatTime() {
    return DateFormat('h:mm a').format(this);
  }

  String formatDateTime() {
    return DateFormat('EEEE, MMM d, yyyy h:mm a').format(this);
  }
}
