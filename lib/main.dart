
import 'package:covid19/models/summary_model.dart';
import 'package:covid19/screens/homescreen.dart';
import 'package:covid19/services/summery_services.dart';
import 'package:covid19/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'status.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    return MaterialApp(
      title: 'Covid -19',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<Summary>(
      future: (firstTime)?getSummary():getSummaryLocally(),
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.done){
          if(snapshot.hasError){
              deviceOffline = true;
          }
          if(deviceOffline)
          {
            deviceOffline=false;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('No Internet',style:TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                         fontWeight: FontWeight.bold,
                          // letterSpacing: 1.5,
                        ),
                      ),
                    Text('Please Check your Internet ',style:TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                         fontWeight: FontWeight.bold,
                          // letterSpacing: 1.5,
                        ),
                      ),
                Text('Stay Home, Stay Safe',
                style:TextStyle(
                        color: UiElements.primaryColor,
                        fontSize: 20,
                         fontWeight: FontWeight.bold,
                          // letterSpacing: 1.5,
                        ),)
              ],
            );
            
          }
          else //this will be the main page
          {
            for(int i = 0; i<snapshot.data.countries.length; i++){
             if(snapshot.data.countries[i].countryCode==countryCode)
             {
               countryIndex=i;
             }
              if(snapshot.data.countries[i].countryCode=='CN')
             {
               chinaIndex=i;
             }

            } //to find the country 
            summaryData = snapshot.data;
            return HomeScreens();
          }
        }
        else
          return Center(child: CircularProgressIndicator());
    }
),
    );
  }
}
