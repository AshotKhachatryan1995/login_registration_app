import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:login_registration_app/constants/app_styles.dart';

import '../middleware/models/country.dart';
import 'countries/country_loader.dart';

class CountriesDropDown extends StatefulWidget {
  const CountriesDropDown({required this.onCountryChange, super.key});

  final CountryCallback onCountryChange;

  @override
  State<StatefulWidget> createState() => _CountriesDropDownState();
}

class _CountriesDropDownState extends State<CountriesDropDown> {
  Country? dropdownValue;

  @override
  void initState() {
    super.initState();

    dropdownValue = CountryLoader.instance.defaultCountry;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DropdownButton2<Country>(
          value: dropdownValue,
          alignment: Alignment.center,
          underline: const SizedBox(),
          onChanged: (Country? val) {
            if (val != null) {
              setState(() {
                dropdownValue = val;
              });
            }

            widget.onCountryChange.call(val);
          },
          buttonPadding: EdgeInsets.zero,
          itemPadding: EdgeInsets.zero,
          barrierColor: Colors.black.withOpacity(0.2),
          items: CountryLoader.instance.countries
              ?.map<DropdownMenuItem<Country>>((Country value) {
            return DropdownMenuItem<Country>(
                value: value,
                child: Row(children: [
                  Text(
                    value.flagEmoji(),
                    style: getStyle(fontSize: 30),
                  ),
                  Text(
                    ' +${value.e164CC}',
                    style: getStyle(fontSize: 12),
                  ),
                ]));
          }).toList()),
    );
  }
}

typedef CountryCallback = void Function(Country?);
