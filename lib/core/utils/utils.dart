import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
  
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }
  
  static DateTime getToday() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
  
  static DateTime getYesterday() {
    final today = getToday();
    return today.subtract(const Duration(days: 1));
  }
  
  static DateTime getStartOfWeek() {
    final today = getToday();
    return today.subtract(Duration(days: today.weekday - 1));
  }
  
  static DateTime getStartOfMonth() {
    final today = getToday();
    return DateTime(today.year, today.month, 1);
  }
  
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
  
  static bool isToday(DateTime date) {
    return isSameDay(date, DateTime.now());
  }
}

class NumberUtils {
  static String formatNumber(double number, {int decimals = 2}) {
    return number.toStringAsFixed(decimals);
  }
  
  static String formatCurrency(double amount) {
    final formatter = NumberFormat('#,##0', 'en_US');
    return formatter.format(amount);
  }
  
  static String formatPercentage(double percentage) {
    return '${percentage.toStringAsFixed(2)}%';
  }
}
