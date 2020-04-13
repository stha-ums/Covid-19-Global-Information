
import 'dart:async';
import 'package:covid19/models/totalDataModelaDaily.dart';
import 'package:http/http.dart' as http;

//from API

Future getTotalDaily(String country) async{
  try{
  numberofCasesConfirmedListTotal=[];
  caseDateConfirmedListTotal =[];

  numberofCasesRecoveredListTotal=[];
  caseDateRecoveredListTotal=[];

  numberofCasesDeathsListTotal=[];
  caseDateDeathsListTotal=[];

  final Map totalDailyCountryDataConfirmedDate = new Map();
  final Map totalDailyCountryDataRecoveredDate = new Map();
  final Map totalDailyCountryDataDeathsDate = new Map();
  //requesting data to api
  
  final responsetotalDailyConfirmed = await http.get('https://api.covid19api.com/total/country/$country/status/confirmed');
  totalDailyCountryDataConfirmed = totalDailyCountryFromJson(responsetotalDailyConfirmed.body); 
  //getting only those data which we need.(date,case number)
  for(int i =0;i<totalDailyCountryDataConfirmed.length;i++){
  totalDailyCountryDataConfirmedDate[totalDailyCountryDataConfirmed[i].date]=totalDailyCountryDataConfirmed[i].cases; 
  }

  // print(totalDailyCountryDataConfirmedDate);
  final responsetotalDailyRecovered = await http.get('https://api.covid19api.com/total/country/$country/status/recovered');
  totalDailyCountryDataRecovered =totalDailyCountryFromJson(responsetotalDailyRecovered.body);

  for(int i =0;i<totalDailyCountryDataRecovered.length;i++){
  totalDailyCountryDataRecoveredDate[totalDailyCountryDataRecovered[i].date]=totalDailyCountryDataRecovered[i].cases; 
  }

  final responsetotalDailyDeaths = await http.get('https://api.covid19api.com/total/country/$country/status/deaths');
  totalDailyCountryDataDeaths = totalDailyCountryFromJson(responsetotalDailyDeaths.body);  

  for(int i =0;i<totalDailyCountryDataDeaths.length;i++){
  totalDailyCountryDataDeathsDate[totalDailyCountryDataDeaths[i].date]=totalDailyCountryDataDeaths[i].cases; 
  }
  //conveting the map to list
  numberofCasesConfirmedListTotal = totalDailyCountryDataConfirmedDate.entries.map<double>((entry) => entry.value).toList();
  caseDateConfirmedListTotal =totalDailyCountryDataConfirmedDate.entries.map<DateTime>((entry) => entry.key).toList();
  //converting the map to list
  numberofCasesRecoveredListTotal=totalDailyCountryDataRecoveredDate.entries.map<double>((entry) => entry.value).toList();
  caseDateRecoveredListTotal=totalDailyCountryDataRecoveredDate.entries.map<DateTime>((entry) => entry.key).toList();
  //conveting the map to list
  numberofCasesDeathsListTotal=totalDailyCountryDataDeathsDate.entries.map<double>((entry) => entry.value).toList();
  caseDateDeathsListTotal=totalDailyCountryDataDeathsDate.entries.map<DateTime>((entry) => entry.key).toList();
  }
  catch(e){
    print('there is error in getting data');
  }

  return totalDailyCountryDataConfirmed;
}
