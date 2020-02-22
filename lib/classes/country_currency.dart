/// Represents a country and some of its data (alternative names and currency).
///
/// Can be updated with a JSON file from https://restcountries.eu/.
class Country {
  String name;
  String alpha2Code;
  String alpha3Code;
  List<String> altSpellings;
  List<CurrencyData> currencies;
  Map<String, String> nameTranslations;

  Country(
      {this.name,
      this.alpha2Code,
      this.alpha3Code,
      this.altSpellings,
      this.currencies,
      this.nameTranslations});

  factory Country.fromJson(Map<String, dynamic> json) {
    List<CurrencyData> currencies;
    if (json['currencies'] != null) {
      currencies = List<CurrencyData>();
      json['currencies'].forEach((v) {
        currencies.add(CurrencyData.fromJson(v));
      });
    }

    return Country(
        name: json['name'] as String,
        alpha2Code: json['alpha2Code'] as String,
        alpha3Code: json['alpha3Code'] as String,
        altSpellings: json['altSpellings'].cast<String>(),
        currencies: currencies,
        nameTranslations: json['translations'] != null ? json['translations'] : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['alpha2Code'] = this.alpha2Code;
    data['alpha3Code'] = this.alpha3Code;
    data['altSpellings'] = this.altSpellings;
    if (this.currencies != null) {
      data['currencies'] = this.currencies.map((v) => v.toJson()).toList();
    }

    if (this.nameTranslations != null) {
      data['translations'] = this.nameTranslations;
    }

    return data;
  }
}

/// Represents currency information obtained from local data or the Internet.
/// It is easily adaptable to money2's [Currency].
class CurrencyData {
  String code;
  String name;
  String symbol;

  Map<DateTime, double> exchangeRateEUR;

  CurrencyData({this.code, this.name, this.symbol});

  CurrencyData.fromJson(Map<String, dynamic> json) {
    code = json['code'] as String;
    name = json['name'] as String;
    symbol = json['symbol'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    return data;
  }
}
