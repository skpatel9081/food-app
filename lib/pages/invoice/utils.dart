import 'package:intl/intl.dart';

class Utils {
  static formatPrice(num price) => 'Rs ${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMMMd().format(date);
}
