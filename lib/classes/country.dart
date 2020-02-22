class Country {
  String name;
  List<String> topLevelDomain;
  String alpha2Code;
  String alpha3Code;
  List<String> callingCodes;
  String capital;
  List<String> altSpellings;
  String region;
  String subregion;
  int population;
  List<int> latlng;
  String demonym;
  int area;
  double gini;
  List<String> timezones;
  List<String> borders;
  String nativeName;
  String numericCode;
  List<Currency> currencies;
  List<Language> languages;
  Translations translations;
  String flag;
  List<RegionalBloc> regionalBlocs;
  String cioc;

  Country(
      {this.name,
      this.topLevelDomain,
      this.alpha2Code,
      this.alpha3Code,
      this.callingCodes,
      this.capital,
      this.altSpellings,
      this.region,
      this.subregion,
      this.population,
      this.latlng,
      this.demonym,
      this.area,
      this.gini,
      this.timezones,
      this.borders,
      this.nativeName,
      this.numericCode,
      this.currencies,
      this.languages,
      this.translations,
      this.flag,
      this.regionalBlocs,
      this.cioc});

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    topLevelDomain = json['topLevelDomain'].cast<String>();
    alpha2Code = json['alpha2Code'];
    alpha3Code = json['alpha3Code'];
    callingCodes = json['callingCodes'].cast<String>();
    capital = json['capital'];
    altSpellings = json['altSpellings'].cast<String>();
    region = json['region'];
    subregion = json['subregion'];
    population = json['population'];
    latlng = json['latlng'].cast<int>();
    demonym = json['demonym'];
    area = json['area'];
    gini = json['gini'];
    timezones = json['timezones'].cast<String>();
    borders = json['borders'].cast<String>();
    nativeName = json['nativeName'];
    numericCode = json['numericCode'];
    if (json['currencies'] != null) {
      currencies = new List<Currency>();
      json['currencies'].forEach((v) {
        currencies.add(new Currency.fromJson(v));
      });
    }
    if (json['languages'] != null) {
      languages = new List<Language>();
      json['languages'].forEach((v) {
        languages.add(new Language.fromJson(v));
      });
    }
    translations = json['translations'] != null ? new Translations.fromJson(json['translations']) : null;
    flag = json['flag'];
    if (json['regionalBlocs'] != null) {
      regionalBlocs = new List<RegionalBloc>();
      json['regionalBlocs'].forEach((v) {
        regionalBlocs.add(new RegionalBloc.fromJson(v));
      });
    }
    cioc = json['cioc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['topLevelDomain'] = this.topLevelDomain;
    data['alpha2Code'] = this.alpha2Code;
    data['alpha3Code'] = this.alpha3Code;
    data['callingCodes'] = this.callingCodes;
    data['capital'] = this.capital;
    data['altSpellings'] = this.altSpellings;
    data['region'] = this.region;
    data['subregion'] = this.subregion;
    data['population'] = this.population;
    data['latlng'] = this.latlng;
    data['demonym'] = this.demonym;
    data['area'] = this.area;
    data['gini'] = this.gini;
    data['timezones'] = this.timezones;
    data['borders'] = this.borders;
    data['nativeName'] = this.nativeName;
    data['numericCode'] = this.numericCode;
    if (this.currencies != null) {
      data['currencies'] = this.currencies.map((v) => v.toJson()).toList();
    }
    if (this.languages != null) {
      data['languages'] = this.languages.map((v) => v.toJson()).toList();
    }
    if (this.translations != null) {
      data['translations'] = this.translations.toJson();
    }
    data['flag'] = this.flag;
    if (this.regionalBlocs != null) {
      data['regionalBlocs'] = this.regionalBlocs.map((v) => v.toJson()).toList();
    }
    data['cioc'] = this.cioc;
    return data;
  }
}

class Currency {
  String code;
  String name;
  String symbol;

  Currency({this.code, this.name, this.symbol});

  Currency.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    return data;
  }
}

class Language {
  String iso6391;
  String iso6392;
  String name;
  String nativeName;

  Language({this.iso6391, this.iso6392, this.name, this.nativeName});

  Language.fromJson(Map<String, dynamic> json) {
    iso6391 = json['iso639_1'];
    iso6392 = json['iso639_2'];
    name = json['name'];
    nativeName = json['nativeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iso639_1'] = this.iso6391;
    data['iso639_2'] = this.iso6392;
    data['name'] = this.name;
    data['nativeName'] = this.nativeName;
    return data;
  }
}

class Translations {
  Map<String, String> values;

  Translations({this.values});

  Translations.fromJson(Map<String, dynamic> json) {
    values = json;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data = values;
    return data;
  }
}

class RegionalBloc {
  String acronym;
  String name;
  List<String> otherAcronyms;
  List<String> otherNames;

  RegionalBloc({this.acronym, this.name, this.otherAcronyms, this.otherNames});

  RegionalBloc.fromJson(Map<String, dynamic> json) {
    acronym = json['acronym'];
    name = json['name'];
    if (json['otherAcronyms'] != null) {
      otherAcronyms = new List<String>();
      json['otherAcronyms'].forEach((v) {
        otherAcronyms.add(v.toString());
      });
    }
    if (json['otherNames'] != null) {
      otherNames = new List<String>();
      json['otherNames'].forEach((v) {
        otherNames.add(v.toString());
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['acronym'] = this.acronym;
    data['name'] = this.name;
    if (this.otherAcronyms != null) {
      data['otherAcronyms'] = this.otherAcronyms.map((v) => v.toString()).toList();
    }
    if (this.otherNames != null) {
      data['otherNames'] = this.otherNames.map((v) => v.toString()).toList();
    }
    return data;
  }
}
