import 'package:covid19/chart.dart';
import 'package:covid19/models/summary_model.dart';
import 'package:covid19/services/totalDataServicesDaily.dart';
import 'package:covid19/status.dart';
import 'package:covid19/style.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';



class StatisticsScreen extends StatefulWidget {
  final int index;
  StatisticsScreen({this.index});
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiElements.backgroundcolor,
      body: SafeArea(
        child:ListView(
                  children: <Widget> [Column(
            children: <Widget>[
              SizedBox(height:UiElements.padding),
              Padding(
                padding:  EdgeInsets.fromLTRB(UiElements.padding, 0, UiElements.padding, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(icon:Icon(Icons.arrow_back), 
                    splashColor: Colors.transparent,
                    color:Colors.white,
                    onPressed: (){
                      Navigator.pop(context);
                    }),
                    Text('${summaryData.countries[widget.index].country}',style: TextStyle(
                          color: Colors.white,
                          fontSize:20,
                          fontWeight: FontWeight.bold,
                          // letterSpacing: 1.5,
                          ),
                        ),
                    Flags.getMiniFlag('${summaryData.countries[widget.index].countryCode}', 20, 20),
                  ]
                  
                ),
              ),
              SizedBox(height:UiElements.padding*4),
              Text('${summaryData.countries[widget.index].totalConfirmed}',style: TextStyle(
                          color: Colors.white,
                          fontSize: UiElements.primaryFontSize,
                          fontWeight: FontWeight.bold,
                          // letterSpacing: 1.5,
                          ),
              ),
              Text('Total Confimed',style: TextStyle(
                          color: UiElements.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          // letterSpacing: 1.5,
                          ),
                        ),        
              SizedBox(height:UiElements.padding*1.5),
              Container(
                height: UiElements.screenHeight*0.45,
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(2),
                ),
                child: FutureBuilder(
                  future:getTotalDaily(summaryData.countries[widget.index].slug),
                  builder: (context,livedataOnline){
                    if(livedataOnline.connectionState==ConnectionState.done){
                      if(livedataOnline.hasError){
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
                                  Text('Please Check your Internet',style:TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                        // letterSpacing: 1.5,
                                      ),
                                    ),
                              Text('Stay Home, Stay Safe from co',
                              style:TextStyle(
                                      color: UiElements.primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                        // letterSpacing: 1.5,
                                      ),
                                    )
                          ],
                        );
                      }
                      else{                       
                      return  Chart();
                      }                   
                    }
                    else
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            Padding(
              padding:  EdgeInsets.all(UiElements.padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 10,
                    width: 70,
                    decoration:BoxDecoration(
                      color:Color(0xff4af699),
                      borderRadius: BorderRadius.circular(UiElements.padding),
                    ),
                  ),
                  SizedBox(width:20),
                  Text('Total Confirmed',
                  style: TextStyle(
                    color: UiElements.primaryFontColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    // letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(width:20),
                  SizedBox(width:20),
                  SizedBox(width:20),
                  Text('${summaryData.countries[widget.index].totalConfirmed}',
                  style: TextStyle(
                    color: UiElements.primaryFontColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    // letterSpacing: 1.5,
                    ),
                  ),


                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.all(UiElements.padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 10,
                    width: 70,
                    decoration:BoxDecoration(
                      color:Color(0xffaa4cfc),
                      borderRadius: BorderRadius.circular(UiElements.padding),
                    ),
                  ),
                  SizedBox(width:20),
                  Text('Total Recovered',
                  style: TextStyle(
                    color: UiElements.primaryFontColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    // letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(width:20),
                  SizedBox(width:20),
                  SizedBox(width:20),
                  Text('${summaryData.countries[widget.index].totalRecovered}',
                  style: TextStyle(
                    color: UiElements.primaryFontColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    // letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding:  EdgeInsets.all(UiElements.padding),
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    
                    height: 10,
                    width: 70,
                    decoration:BoxDecoration(
                      color:Color(0xff27b6fc),
                      borderRadius: BorderRadius.circular(UiElements.padding),
                    ),
                  ),
                  SizedBox(width:20),
                  Text('Total Deaths',
                  style: TextStyle(
                    color: UiElements.primaryFontColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    // letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(width:20),
                  SizedBox(width:20),
                  SizedBox(width:20),
                  Text('${summaryData.countries[widget.index].totalDeaths}',
                  style: TextStyle(
                    color: UiElements.primaryFontColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    // letterSpacing: 1.5,
                    ),
                  ),      
                ],
              ),
            ),


            Padding(
              padding:  EdgeInsets.all(UiElements.padding),
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    
                    height: 10,
                    width: 70,
                    decoration:BoxDecoration(
                      color:Colors.transparent,
                      borderRadius: BorderRadius.circular(UiElements.padding),
                    ),
                  ),
                  SizedBox(width:20),
                  Text('New Confirmed',
                  style: TextStyle(
                    color: UiElements.primaryFontColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    // letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(width:20),
                  SizedBox(width:20),
                  SizedBox(width:20),
                  Text('${summaryData.countries[widget.index].newConfirmed}',
                  style: TextStyle(
                    color: UiElements.primaryFontColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    // letterSpacing: 1.5,
                    ),
                  ),      
                ],
              ),
            ),

            Padding(
              padding:  EdgeInsets.all(UiElements.padding),
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    
                    height: 10,
                    width: 70,
                    decoration:BoxDecoration(
                      color:Colors.transparent,
                      borderRadius: BorderRadius.circular(UiElements.padding),
                    ),
                  ),
                  SizedBox(width:20),
                  Text('New Recovered',
                  style: TextStyle(
                    color: UiElements.primaryFontColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    // letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(width:20),
                  SizedBox(width:20),
                  SizedBox(width:20),
                  Text('${summaryData.countries[widget.index].totalRecovered}',
                  style: TextStyle(
                    color: UiElements.primaryFontColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    // letterSpacing: 1.5,
                    ),
                  ),      
                ],
              ),
            ),

            Padding(
              padding:  EdgeInsets.all(UiElements.padding),
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    
                    height: 10,
                    width: 70,
                    decoration:BoxDecoration(
                      color:Colors.transparent,
                      borderRadius: BorderRadius.circular(UiElements.padding),
                    ),
                  ),
                  SizedBox(width:20),
                  Text('New Deaths',
                  style: TextStyle(
                    color: UiElements.primaryFontColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    // letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(width:20),
                  SizedBox(width:20),
                  SizedBox(width:20),
                  Text('${summaryData.countries[widget.index].newDeaths}',
                  style: TextStyle(
                    color: UiElements.primaryFontColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    // letterSpacing: 1.5,
                    ),
                  ),      
                ],
              ),
            ),

            ],
          ),
        ]
        )
      
      ),

    );
  }
}