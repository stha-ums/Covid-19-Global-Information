import 'dart:convert';
import 'package:covid19/status.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:covid19/models/summary_model.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

//from API
String url = 'https://api.covid19api.com/summary';
Future <Summary> getSummary() async{
  try{
  final response = await http.get('$url');
  writeJson(response.body);

  firstTime = false;
    if(firstLauch==1){
      String ipUrl='https://api.ipify.org?format=json';
      final responseIp = await http.get('$ipUrl');
      Map valueMap = json.decode(responseIp.body);
      String ip = valueMap['ip'];

      String urcountryCode='https://ipapi.co';
      final responseCode = await http.get('$urcountryCode/$ip/country');
      countryCode = responseCode.body;
      print(countryCode);
      writeFile();  }
    else{
      readFile();
    }
  return summaryFromJson(response.body);
  }
  catch(e){
    print(e);
    deviceOffline = true;
    firstTime = true;
  }
  
  return summaryFromJson(await readJson());
}

//from Local file
Future<Summary> getSummaryLocally() async{
  print('From local file');
  String response = await readJson();
  //print(response);
  return summaryFromJson(response);
}


//finding path to save file

Future<File> get localFilePath async {
  final directory = await getApplicationDocumentsDirectory();

  return File('${directory.path}/summary.json');
}

Future<File> writeJson(summary) async {
  final file = await localFilePath;
  // Write the file.
  return file.writeAsString('$summary');
}

Future<String> readJson() async {
  try {
    final file = await localFilePath;
    String contents = await file.readAsString();
    return contents;
  } catch (e) {
    // If encountering an error, return 0.
    return null;
  }
}

Future<File> writeFile() async {
   final directory = await getApplicationDocumentsDirectory();
   File name = File('${directory.path}/status.txt');
  return name.writeAsString('$countryCode');
}
Future readFile() async {
  try {
        final directory = await getApplicationDocumentsDirectory();
        File name = File('${directory.path}/status.txt');
        countryCode = await name.readAsString();
    
  } catch (e) {
    countryCode = 'NP';
  }
}

// Future<File> writeFileFirstLaunch() async {
//    final directory = await getApplicationDocumentsDirectory();
//    File name = File('${directory.path}/FirstLaunch.txt');
//   return name.writeAsString('$firstLauch');
// }
// Future readFileFirstLaunch() async {
//   try {
//         final directory = await getApplicationDocumentsDirectory();
//         File name = File('${directory.path}/FirstLaunch.txt');
//         String firstLauchStr = await name.readAsString();
//         firstLauch = int.parse(firstLauchStr);
    
//   } catch (e) {
//     firstLauch = 1;
//   }
// }
