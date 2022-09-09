import 'package:flutter/services.dart';

import '../../middleware/models/country.dart';

abstract class CountryLoaderAbstract {
  List<Country>? get countries;
  Country? get defaultCountry;
}

class CountryLoader extends CountryLoaderAbstract {
  List<Country>? _countries;
  Country? _defaultCountry;

  CountryLoader();

  static CountryLoader? _instance;
  static CountryLoader get instance =>
      _instance ?? (_instance = CountryLoader());

  @override
  List<Country>? get countries => _countries;
  @override
  Country? get defaultCountry => _defaultCountry;

  Future<String> loadAsset(String assetsPath) async {
    return await rootBundle.loadString(assetsPath);
  }

  /// Load countries data from assets
  void load() {
    if (_countries != null && _defaultCountry != null) {
      return;
    }

    loadAsset('assets/resources/country-codes.json').then((jsonString) {
      var countries = Country.parseJson(jsonString);

      _countries = countries;

      if (countries != null) {
        _updateDefaultCountry(countries);
      }
    });
  }

  void _updateDefaultCountry(List<Country> countries) {
    Country.defaultCountry(countries).then((country) {
      _defaultCountry = country;
    });
  }

  String? getISOCode(String countryName) {
    if (_countries == null) {
      return null;
    }

    var countriesFiltered = _countries!
        .where((i) => i.name?.toLowerCase() == countryName.toLowerCase())
        .toList();

    if (countriesFiltered.isEmpty) {
      return null;
    }

    return countriesFiltered.first.iso2CC;
  }
}
