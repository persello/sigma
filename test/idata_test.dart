import 'package:flutter_test/flutter_test.dart';
import 'package:sigma/classes/country_currency.dart';
import 'package:sigma/classes/international_data.dart';

void main() {
  test('Get online country data', () async {
    List<Country> countries = await InternationalData.fetchCountries();
    assert(countries.length > 0);
    countries.forEach((c) => print(
        '${c.name} has "${c.currencies.first.name}" (${c.currencies.first.code}) currency and ${c.alpha2Code} code.'));
  });

  test('Get currency data', () async {
    ExchangeRates data = await InternationalData.fetchExchangeRates();
    assert(data.rates.length > 0);
    data.rates.forEach((r, s) => print('1 ${data.base} is $s $r on ${data.date}.'));
  });
}
