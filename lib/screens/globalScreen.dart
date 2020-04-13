import 'dart:async';
import 'package:covid19/models/summary_model.dart';
import 'package:covid19/screens/globalChart.dart';
import 'package:covid19/screens/globalStatistic.dart';
import 'package:covid19/screens/statisticsScreen.dart';
import 'package:covid19/services/summery_services.dart';
import 'package:covid19/status.dart';
import 'package:covid19/style.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class GlobalScreen extends StatefulWidget {

  @override
  _GlobalScreenState createState() => _GlobalScreenState();
}

class _GlobalScreenState extends State<GlobalScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

Future<void> _handleRefresh() async {
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
      final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });
    summaryData = await getSummary();
    return completer.future.then<void>((_) {
      _scaffoldKey.currentState?.showSnackBar(SnackBar(
          content: const Text('Refresh complete'),
          action: SnackBarAction(
              label: 'RETRY',
              onPressed: () {
                _refreshIndicatorKey.currentState.show();
              })));
    });
}
  @override
  Widget build(BuildContext context) {
    return 
    SafeArea(
          child: LiquidPullToRefresh(
            key:_refreshIndicatorKey,
            onRefresh:_handleRefresh ,
            showChildOpacityTransition: false,
            backgroundColor: UiElements.primaryColor,
            color: Colors.transparent,
            springAnimationDurationInMilliseconds : 500,
            height: 50,
            borderWidth: 1,
            child:ListView(
            children:<Widget>[ Column(
              crossAxisAlignment:CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => GlobalStatisticsScreen()));
                  },
                  child: Container(
                    margin: EdgeInsetsDirectional.fromSTEB(UiElements.padding,UiElements.padding, UiElements.padding,0),
                    width: UiElements.screenWidth - UiElements.padding*2,
                    height: UiElements.screenHeight*.09,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(UiElements.padding),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        
                        Container(
                          alignment: Alignment.center,
                          height: UiElements.screenHeight*.10,
                          width: (UiElements.screenWidth - UiElements.padding*2)/3,
                          decoration: BoxDecoration(
                            color: UiElements.cardViewColor3,
                            borderRadius: BorderRadius.only(topLeft:Radius.circular(UiElements.padding) ,bottomLeft: Radius.circular(UiElements.padding)),
                          ),                        
                          child: Text('Global',
                            style: TextStyle(
                            color:UiElements.primaryFontColor,
                            fontSize: 25,
                            fontWeight:FontWeight.w600,
                           ),
                          ),
                          
                        ),

                        Container(
                          width: (UiElements.screenWidth - UiElements.padding*2)/3,
                          height: UiElements.screenHeight*.13,
                          decoration: BoxDecoration(
                            color: UiElements.cardViewColor1,
                            //borderRadius: BorderRadius.only(topLeft:Radius.circular(UiElements.padding) ,bottomLeft: Radius.circular(UiElements.padding)),
                          ),                        
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('${summaryData.global.totalConfirmed}', //Confirmed cases
                                style: TextStyle(
                                color:UiElements.primaryFontColor,
                                fontSize: 20,
                                fontWeight:FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: UiElements.padding*.5,),
                              Text('Confirmed cases',
                                style: TextStyle(
                                color:UiElements.primaryColor,
                                fontSize: 12,
                                fontWeight:FontWeight.w600,
                                ),
                              ),
                                                                
                            ],
                          ),
                      ), 
                                        
                      Container(
                        width:(UiElements.screenWidth - UiElements.padding*2)/3, 
                        height: UiElements.screenHeight*.09,
                        decoration: BoxDecoration(
                          
                          color: UiElements.cardViewColor1,
                          borderRadius: BorderRadius.only(topRight:Radius.circular(UiElements.padding) ,bottomRight: Radius.circular(UiElements.padding)),
                        ),                        
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('${summaryData.global.totalDeaths}',
                                style: TextStyle(
                                color:UiElements.primaryFontColor,
                                fontSize: 20,
                                fontWeight:FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: UiElements.padding*.5,),
                              Text('Confirmed deaths',
                                style: TextStyle(
                                color:UiElements.primaryColor,
                                fontSize: 12,
                                fontWeight:FontWeight.w600,
                                ),
                              ),
                                                                
                            ],
                          )
                    ),    
                    ],
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StatisticsScreen(index:countryIndex)));
                    },
                  child: Container(
                            margin: EdgeInsetsDirectional.fromSTEB(UiElements.padding,UiElements.padding, UiElements.padding,0),
                    width: UiElements.screenWidth - UiElements.padding*2,
                    height: UiElements.screenHeight*.09,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(UiElements.padding),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        
                        Container(
                          alignment: Alignment.center,
                          height: UiElements.screenHeight*.13,
                          width: (UiElements.screenWidth - UiElements.padding*2)/3,
                          decoration: BoxDecoration(
                            color: UiElements.cardViewColor3,
                            borderRadius: BorderRadius.only(topLeft:Radius.circular(UiElements.padding) ,bottomLeft: Radius.circular(UiElements.padding)),
                          ),                        
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(summaryData.countries[countryIndex].country, //device location
                                style: TextStyle(
                                color:UiElements.primaryFontColor,
                                fontSize: 25,
                                fontWeight:FontWeight.w600,
                              ),
                              ),
                              Text('Your Country',
                                style: TextStyle(
                                color:UiElements.primaryColor,
                                fontSize: 12,
                                fontWeight:FontWeight.w600,
                              ),
                              ),
                            ],
                          ),
                          
                        ),

                        Container(
                          width: (UiElements.screenWidth - UiElements.padding*2)/3,
                          height: UiElements.screenHeight*.09,
                          decoration: BoxDecoration(
                            color: UiElements.cardViewColor1,
                            //borderRadius: BorderRadius.only(topLeft:Radius.circular(UiElements.padding) ,bottomLeft: Radius.circular(UiElements.padding)),
                          ),                        
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('${summaryData.countries[countryIndex].totalConfirmed}',
                                style: TextStyle(
                                color:UiElements.primaryFontColor,
                                fontSize: 20,
                                fontWeight:FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: UiElements.padding*.5,),
                              Text('Confirmed cases',
                                style: TextStyle(
                                color:UiElements.primaryColor,
                                fontSize: 12,
                                fontWeight:FontWeight.w600,
                                ),
                              ),
                                                                
                            ],
                          ),
                      ), 
                                        
                      Container(
                        width:(UiElements.screenWidth - UiElements.padding*2)/3, 
                        height: UiElements.screenHeight*.13,
                        decoration: BoxDecoration(
                          
                          color: UiElements.cardViewColor1,
                          borderRadius: BorderRadius.only(topRight:Radius.circular(UiElements.padding) ,bottomRight: Radius.circular(UiElements.padding)),
                        ),                        
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('${summaryData.countries[countryIndex].totalDeaths}',
                                style: TextStyle(
                                color:UiElements.primaryFontColor,
                                fontSize: 20,
                                fontWeight:FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: UiElements.padding*.5,),
                              Text('Confirmed deaths',
                                style: TextStyle(
                                color:UiElements.primaryColor,
                                fontSize: 12,
                                fontWeight:FontWeight.w600,
                                ),
                              ),
                                                                
                            ],
                          )
                      
                    ),    

                    ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StatisticsScreen(index:chinaIndex)));
                  },
                    child: Container(
                    margin: EdgeInsetsDirectional.fromSTEB(UiElements.padding,UiElements.padding, UiElements.padding,0),
                    width: UiElements.screenWidth - UiElements.padding*2,
                    height: UiElements.screenHeight*.09,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(UiElements.padding),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        
                        Container(
                          alignment: Alignment.center,
                          height: UiElements.screenHeight*.13,
                          width: (UiElements.screenWidth - UiElements.padding*2)/3,
                          decoration: BoxDecoration(
                            color: UiElements.cardViewColor3,
                            borderRadius: BorderRadius.only(topLeft:Radius.circular(UiElements.padding) ,bottomLeft: Radius.circular(UiElements.padding)),
                          ),                        
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('China',
                                style: TextStyle(
                                color:UiElements.primaryFontColor,
                                fontSize: 25,
                                fontWeight:FontWeight.w600,
                              ),
                              ),
                              Text('Epicenter',
                                style: TextStyle(
                                color:UiElements.primaryColor,
                                fontSize: 12,
                                fontWeight:FontWeight.w600,
                              ),
                              ),
                            ],
                          )
                        ),

                        Container(
                          width: (UiElements.screenWidth - UiElements.padding*2)/3,
                          height: UiElements.screenHeight*.13,
                          decoration: BoxDecoration(
                            color: UiElements.cardViewColor1,
                            //borderRadius: BorderRadius.only(topLeft:Radius.circular(UiElements.padding) ,bottomLeft: Radius.circular(UiElements.padding)),
                          ),                        
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('${summaryData.countries[chinaIndex].totalConfirmed}',
                                style: TextStyle(
                                color:UiElements.primaryFontColor,
                                fontSize: 20,
                                fontWeight:FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: UiElements.padding*.5,),
                              Text('Confirmed cases',
                                style: TextStyle(
                                color:UiElements.primaryColor,
                                fontSize: 12,
                                fontWeight:FontWeight.w600,
                                ),
                              ),
                                                                
                            ],
                          ),
                      ), 
                                        
                      Container(
                        width:(UiElements.screenWidth - UiElements.padding*2)/3, 
                        height: UiElements.screenHeight*.13,
                        decoration: BoxDecoration(
                          color: UiElements.cardViewColor1,
                          borderRadius: BorderRadius.only(topRight:Radius.circular(UiElements.padding) ,bottomRight: Radius.circular(UiElements.padding)),
                        ),                        
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('${summaryData.countries[chinaIndex].totalDeaths}',
                                style: TextStyle(
                                color:UiElements.primaryFontColor,
                                fontSize: 20,
                                fontWeight:FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: UiElements.padding*.5,),
                              Text('Confirmed deaths',
                                style: TextStyle(
                                color:UiElements.primaryColor,
                                fontSize: 12,
                                fontWeight:FontWeight.w600,
                                ),
                              ),
                                                                
                            ],
                          )
                    ),    
                    ],
                    ),
                  ),
                ),
              SizedBox(height:UiElements.screenHeight*.0136),
              Container(
                  width: UiElements.screenWidth - UiElements.padding*2,
                  height: UiElements.screenHeight*.47,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(UiElements.padding),
                  ),
                  child:PieChartGloble() ,
                ),
             
              ],
            ),
            ]
          ),
    ),
        );
  }
}









