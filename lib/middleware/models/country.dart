import 'dart:convert';
import 'package:country_codes/country_codes.dart';

class Country {
  String? e164CC;
  String? iso2CC;
  int? e164SC;
  bool? geographic;
  int? level;
  String? name;
  String? example;
  String? displayName;
  String? fullExampleWithPlusSign;
  String? displayNameNoE164CC;
  String? e164Key;

  Country(
      this.e164CC,
      this.iso2CC,
      this.e164SC,
      this.geographic,
      this.level,
      this.name,
      this.example,
      this.displayName,
      this.fullExampleWithPlusSign,
      this.displayNameNoE164CC,
      this.e164Key);

  Country.fromJson(Map<String, dynamic> json)
      : e164CC = json['e164_cc'],
        iso2CC = json['iso2_cc'],
        e164SC = json['e164_sc'],
        geographic = json['geographic'],
        level = json['level'],
        name = json['name'],
        example = json['example'],
        displayName = json['display_name'],
        fullExampleWithPlusSign = json['full_example_with_plus_sign'],
        displayNameNoE164CC = json['display_name_no_e164_cc'],
        e164Key = json['e164_key'];

  Map<String, dynamic> toJson() => {
        'e164_cc': e164CC,
        'iso2_cc': iso2CC,
        'e164_sc': e164SC,
        'geographic': geographic,
        'level': level,
        'name': name,
        'example': example,
        'display_name': displayName,
        'full_example_with_plus_sign': fullExampleWithPlusSign,
        'display_name_no_e164_cc': displayNameNoE164CC,
        'e164_key': e164Key,
      };

  String flagEmoji() {
    var flagOffset = 0x1F1E6;
    var asciiOffset = 0x41;

    var firstChar =
        iso2CC == null ? 0 : iso2CC!.codeUnitAt(0) - asciiOffset + flagOffset;
    var secondChar =
        iso2CC == null ? 0 : iso2CC!.codeUnitAt(1) - asciiOffset + flagOffset;

    return String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
  }

  static Future<String?> defaultCountryCode() async {
    String? platformVersion;

    await CountryCodes.init();
    var deviceLocale = CountryCodes.getDeviceLocale();

    if (deviceLocale == null) {
      platformVersion = 'US';
    } else {
      platformVersion = deviceLocale.countryCode;
    }

    return platformVersion?.toUpperCase();
  }

  static Future<Country> defaultCountry(List<Country> countries) async {
    var countryCode = await defaultCountryCode();

    var country =
        countries.where((i) => i.iso2CC == countryCode).toList().first;

    return country;
  }

  static List<Country>? parseJson(String jsonString) {
    final parsed =
        json.decode(jsonString.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Country>((json) => Country.fromJson(json)).toList();
  }
}
