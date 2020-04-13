import 'dart:convert';

dynamic liveCountryDataConfirmed;
dynamic liveCountryDataRecovered;
dynamic liveCountryDataDeaths;

List <double> numberofCasesConfirmedList ;
List <String> caseDateConfirmedList ;

List <double> numberofCasesRecoveredList;
List <String> caseDateRecoveredList;

List <double> numberofCasesDeathsList;
List <String> caseDateDeathsList;


List<Live> liveFromJson(String str) => List<Live>.from(json.decode(str).map((x) => Live.fromJson(x)));

String liveToJson(List<Live> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Live {
    final double cases;
    final String country;
    final String countryCode;
    final DateTime date;
    final String lat;
    final String lon;
    final String status;

    Live({
        this.cases,
        this.country,
        this.countryCode,
        this.date,
        this.lat,
        this.lon,
        this.status,
    });

    factory Live.fromJson(Map<String, dynamic> json) => Live(
        cases: json["Cases"].toDouble(),
        country: json["Country"],
        countryCode:json["CountryCode"],
        date: DateTime.parse(json["Date"]),
        lat: json["Lat"],
        lon: json["Lon"],
        status:json["Status"],
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
