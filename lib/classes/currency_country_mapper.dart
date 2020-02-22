class CurrencyCountryMapper {
  /// Transforms a string to a string of regional indicators. Accepts A-Z, a-z
  /// input with no spaces inbetween.
  static String _charToRegionalIndicator(String string) {
    // Everything to uppercase and trimmed
    string = string
      ..toUpperCase()
      ..trim();

    StringBuffer output;

    // Transform A-Z to regional indicators and add to buffer
    for (var char in string.runes) {
      output.writeCharCode(char + (0x1F1E6 - 0x41));
    }

    return output.toString();
  }
}
