import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String format(DateFormat format) {
    return format.format(this);
  }

  String formatYYYYMMdd() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String formatddMMyyyy() {
    return DateFormat('dd-MM-yyyy').format(this);
  }

  String formatddMMMMyyyy() {
    return DateFormat('dd MMMM yyyy').format(this);
  }

  String formatddMMMyyyy() {
    return DateFormat('dd MMM yyyy').format(this);
  }

  String formatMMM() {
    return DateFormat('MMM').format(this);
  }

  String formatyyyyMMdd() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String formatHHmm() {
    return DateFormat('hh:mm a').format(this);
  }

  bool isToday() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime currentDay = DateTime(year, month, day);
    return currentDay == today;
  }

  bool isTomorrow() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime tomorrow = today.add(const Duration(days: 1));
    DateTime currentDay = DateTime(year, month, day);
    return currentDay == tomorrow;
  }

  bool isYesterDay() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(const Duration(days: 1));
    DateTime currentDay = DateTime(year, month, day);
    return currentDay == yesterday;
  }

  bool isAfterOrEqualTo(DateTime dateTime) {
    final DateTime date = this;
    final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
    return isAtSameMomentAs | date.isAfter(dateTime);
  }

  bool isBeforeOrEqualTo(DateTime dateTime) {
    final DateTime date = this;
    final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
    return isAtSameMomentAs | date.isBefore(dateTime);
  }

  bool isBetween(
    DateTime fromDateTime,
    DateTime toDateTime,
  ) {
    final DateTime date = this;
    final bool isAfter = date.isAfterOrEqualTo(fromDateTime);
    final bool isBefore = date.isBeforeOrEqualTo(toDateTime);
    return isAfter && isBefore;
  }
}
