import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  NumberFormat formatter;

  CurrencyInputFormatter(locale, currency)
      : formatter = NumberFormat.currency(locale: locale, symbol: currency);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {

    bool isNegative = RegExp('−|-').hasMatch(newValue.text);

    final newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    final int? newTextAsNum = int.tryParse(newText);

    if (newTextAsNum == null) {
      return oldValue;
    }

    String formattedText = formatter.format(newTextAsNum / 100);

    if (isNegative) {
      formattedText = '−$formattedText';
    }

    int newOffset;
    if (oldValue.text.length > newValue.text.length) {
      newOffset = oldValue.selection.baseOffset;
      if (oldValue.text == formattedText) {
        newOffset -= 1;
      }
    } else {
      newOffset = oldValue.selection.extentOffset;
    }

    if (0 > newOffset) {
      newOffset = 0;
    }

    if (formattedText.length < newOffset) {
      newOffset = formattedText.length;
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.fromPosition(TextPosition(offset: newOffset)),
    );
  }
}
