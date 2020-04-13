bool deviceOffline = false; 
bool firstTime = true;
int firstLauch = 1;
int countryIndex =1;
int chinaIndex =2;
bool findingSortedIndexFirst = true;
//data to operate
String countryCode='';



List sortedIndexKeysTotalConfirmed ;
List sortedIndexKeysTotalRecovered;
List sortedIndexKeysTotalDeaths;
List sortedIndexKeysNewConfimed;
List sortedIndexKeysNewRecovered;
List sortedIndexKeysNewDeaths;

// Text('${snapshot.data.countries.length}',style:TextStyle(
//                     color: Colors.white,
//                     fontSize: 30,
//                      fontWeight: FontWeight.bold,
//                       // letterSpacing: 1.5,
//                     ),