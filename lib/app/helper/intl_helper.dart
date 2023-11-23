import 'package:intl/intl.dart';

class IntlHelper {
  static String convertToRupiah(int number) {
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(number);
  }

  static String convertDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }
}
