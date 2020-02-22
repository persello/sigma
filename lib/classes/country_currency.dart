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
  String flag;

  Country(
      {this.name,
      this.alpha2Code,
      this.alpha3Code,
      this.altSpellings,
      this.currencies,
      this.nameTranslations,
      this.flag});

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    alpha2Code = json['alpha2Code'];
    alpha3Code = json['alpha3Code'];
    altSpellings = json['altSpellings'].cast<String>();
    if (json['currencies'] != null) {
      currencies = List<CurrencyData>();
      json['currencies'].forEach((v) {
        currencies.add(CurrencyData.fromJson(v));
      });
    }
    nameTranslations = json['translations'] != null ? json['translations'] : null;
    flag = json['flag'];
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
    data['flag'] = this.flag;

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
    code = json['code'];
    name = json['name'];
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    return data;
  }
}
