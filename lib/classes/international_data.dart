import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as HTTP;
import 'package:money2/money2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sigma/classes/country_currency.dart';

class InternationalData {
  /// List of countries.
  static List<Country> _countries;

  /// List of currencies that have at least an available exchange rate.
  static List<String> _availableCurrencyCodes;

  // Public methods
  static void updateData() {}
  static List<Country> searchCountry(String term) {}
  static List<Currency> searchCurrency(String term) {}
  static List<Country> getCountriesFromCurrency(String currencyCode) {}
  static Money getExchangeRate(String fromCurrencyCode, String toCurrencyCode) {}
  static String getFlagEmoji(Country country) {}

  // Private methods
  static void _saveToLocalJSON() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    File output = File('${documentsDirectory.path}/cache/InternationalData.json');
    String content = jsonEncode(_countries);
    await output.writeAsString(content);
  }

  static void _readFromLocalJSON() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    File input = File('${documentsDirectory.path}/cache/InternationalData.json');
    if (input.existsSync())
      throw PlatformException(
          code: 'SIGMA_NO_IDATA_CACHE',
          message: 'InternationalData cached JSON not available.',
          details: '${input.path} does not exist.');

    String serializedData = await input.readAsString();
    _countries = _parseCountries(serializedData);
  }

  static List<Country> _parseCountries(String body) {
    var jsonCountries = json.decode(body).cast<Map<String, dynamic>>();
    return jsonCountries.map<Country>((json) => Country.fromJson(json)).toList();
  }

  static Future<List<Country>> _fetchCountries() async {
    HTTP.Client client = HTTP.Client();

    try {
      HTTP.Response response = await client.get('https://restcountries.eu/rest/v2/all');
      return _parseCountries(response.body);
    } on Exception catch (ex) {
      throw PlatformException(
          code: 'SIGMA_NO_ONLINE_IDATA_COUNTRIES',
          message: 'Unable to get updated country data.',
          details: 'Inner exception was ${ex.toString()}');
    }
  }

  static Future<ExchangeRates> _fetchCurrencyData({DateTime dateTime}) async {
    HTTP.Client client = HTTP.Client();
    HTTP.Response response;

    if (dateTime == null) {
      // Get latest
      response = await client.get('https://api.exchangeratesapi.io/latest');
    } else {
      if (dateTime.year < 2000)
        throw PlatformException(
          code: 'SIGMA_ONLINE_IDATA_EXCHANGE_TOO_OLD',
          message: 'Unable to get exchange rates prior to the year 2000.',
          details: 'The online API does not allow for asking older exchange rates.',
        );

      response = await client
          .get('https://api.exchangeratesapi.io/${dateTime.year}-${dateTime.month}-${dateTime.day}');
    }

    return ExchangeRates.fromJson(response.body);
  }
}

class ExchangeRates {
  final Map<String, double> rates;
  final String base;
  final DateTime date;

  ExchangeRates({
    this.rates,
    this.base,
    this.date,
  });

  factory ExchangeRates.fromJson(String str) => ExchangeRates.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExchangeRates.fromMap(Map<String, dynamic> json) => ExchangeRates(
        rates: Map.from(json["rates"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        base: json["base"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toMap() => {
        "rates": Map.from(rates).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "base": base,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}
