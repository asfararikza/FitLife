import 'dart:core';
import 'dart:core';

class CurrencyModel {
  String? date;
  String? base;
  Map<String, dynamic>? rates;

  CurrencyModel({
    this.date,
    this.base,
    this.rates,
  });

  CurrencyModel.fromJson(Map<String, dynamic> json) {
    date = json['date'] as String?;
    base = json['base'] as String?;
    rates = json['rates'] as Map<String, dynamic>?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['date'] = date;
    json['base'] = base;
    json['rates'] = rates;
    return json;
  }
}
