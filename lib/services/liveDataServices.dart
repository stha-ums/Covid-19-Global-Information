import 'package:covid19/models/liveDatamodel.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

//from API

Future getLive(String country) async{
  final Map liveCountryDataConfirmedDate = new Map();
  final Map liveCountryDataRecoveredDate = new Map();
  final Map liveCountryDataDeathsDate = new Map();
  //requesting data to api
  final responseLiveConfirmed = await http.get('https://api.covid19api.com/country/$country/status/confirmed/live');
  liveCountryDataConfirmed = liveFromJson(responseLiveConfirmed.body); 
  //getting only those data which we need.(date,case number)
  for(int i =0;i<liveCountryDataConfirmed.length;i++){
  liveCountryDataConfirmedDate[liveCountryDataConfirmed[i].date]=liveCountryDataConfirmed[i].cases; 
  }

  // print(liveCountryDataConfirmedDate);
  final responseLiveRecovered = await http.get('https://api.covid19api.com/country/$country/status/recovered/live');
  liveCountryDataRecovered =liveFromJson(responseLiveRecovered.body);

  for(int i =0;i<liveCountryDataRecovered.length;i++){
  liveCountryDataRecoveredDate[liveCountryDataRecovered[i].date]=liveCountryDataRecovered[i].cases; 
  }

  final responseLiveDeaths = await http.get('https://api.covid19api.com/country/$country/status/deaths/live');
  liveCountryDataDeaths = liveFromJson(responseLiveDeaths.body);  

  for(int i =0;i<liveCountryDataDeaths.length;i++){
  liveCountryDataDeathsDate[liveCountryDataDeaths[i].date]=liveCountryDataDeaths[i].cases; 
  }
  //conveting the map to list
  numberofCasesConfirmedList = liveCountryDataConfirmedDate.entries.map<double>((entry) => entry.value).toList();
  caseDateConfirmedList =liveCountryDataConfirmedDate.entries.map((entry) => readble(entry.key)).toList();
  //converting the map to list
  numberofCasesRecoveredList=liveCountryDataRecoveredDate.entries.map<double>((entry) => entry.value).toList();
  caseDateRecoveredList=liveCountryDataRecoveredDate.entries.map((entry) => readble(entry.key)).toList();
  //conveting the map to list
  numberofCasesDeathsList=liveCountryDataDeathsDate.entries.map<double>((entry) => entry.value).toList();
  caseDateDeathsList=liveCountryDataDeathsDate.entries.map((entry) => readble(entry.key)).toList();


  return liveCountryDataConfirmed;
}

String readble(DateTime date){
                          String month;
                          switch (date.month) {
                            case 1:
                              month = 'jan';
                              break;
                            case 2:
                              month = 'feb';
                              break;
                            case 3:
                              month = 'mar';
                              break;
                            case 4:
                              month = 'apr';
                              break;
                            case 5:
                              month = 'may';
                              break;
                            case 6:
                              month = 'jun';
                              break;
                            case 7:
                              month = 'jul';
                              break;
                            case 8:
                              month = 'aug';
                              break;
                            case 9:
                              month = 'sep';
                              break;
                            case 10:
                              month = 'oct';
                              break;
                            case 11:
                              month = 'nov';
                              break;   
                            case 12:
                              month = 'dec';
                              break;                                                         
                            default:
                              month = 'jan';
                          }
                          String readbleDate = month + '-' + date.day.toString();
                          return readbleDate;
                        }