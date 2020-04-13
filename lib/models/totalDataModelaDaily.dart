// To parse this JSON data, do
//
//     final totalDailyCountry = totalDailyCountryFromJson(jsonString);

import 'dart:convert';
List <double> xDateData= [];

dynamic totalDailyCountryDataConfirmed;
dynamic totalDailyCountryDataRecovered;
dynamic totalDailyCountryDataDeaths;
List <double> numberofCasesConfirmedListTotal ;
List <DateTime> caseDateConfirmedListTotal ;

List <double> numberofCasesRecoveredListTotal;
List <DateTime> caseDateRecoveredListTotal;
List <double> numberofCasesDeathsListTotal;
List <DateTime> caseDateDeathsListTotal;

List<TotalDailyCountry> totalDailyCountryFromJson(String str) => List<TotalDailyCountry>.from(json.decode(str).map((x) => TotalDailyCountry.fromJson(x)));

String totalDailyCountryToJson(List<TotalDailyCountry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TotalDailyCountry {
    final double cases;
    final String country;
    final String countryCode;
    final DateTime date;
    final String lat;
    final String lon;
    final String status;

    TotalDailyCountry({
        this.cases,
        this.country,
        this.countryCode,
        this.date,
        this.lat,
        this.lon,
        this.status,
    });

    factory TotalDailyCountry.fromJson(Map<String, dynamic> json) => TotalDailyCountry(
        cases: json["Cases"].toDouble(),
        country:json["Country"],
        countryCode: json["CountryCode"],
        date: DateTime.parse(json["Date"]),
        lat: json["Lat"],
        lon: json["Lon"],
        status: json["Status"],
    );

    Map<String, dynamic> toJson() => {
        "Cases": cases,
        "Country": country,
        "CountryCode": countryCode,
        "Date": date.toIso8601String(),
        "Lat": lat,
        "Lon": lon,
        "Status": status,
    };
}
