import 'dart:async';
import 'dart:core';

import 'package:covid19/models/summary_model.dart';
import 'package:covid19/screens/statisticsScreen.dart';
import 'package:covid19/services/searchCountries.dart';
import 'package:covid19/services/summery_services.dart';
import 'package:covid19/status.dart';
import 'package:covid19/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';



class CountryWise extends StatefulWidget {
  @override
  _CountryWiseState createState() => _CountryWiseState();
}

class _CountryWiseState extends State<CountryWise> {

String message='SORTED BY CONFIRMED CASES';
String selectedSortOption = 'confirmed';
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

Future <Widget> customDialoge(context){
  return showDialog(
    context: context,
    builder: (_) => Center( // Aligns the container to center
      child: Container( // A simplified version of dialog. 
        width: 250.0,
        decoration: BoxDecoration(
          color: UiElements.cardViewColor3,
          borderRadius: BorderRadius.circular(UiElements.padding),
          
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:<Widget>[
            SizedBox(height:10),
            Container(
                height: 40,
                width: 220,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(UiElements.padding),
                ),
                child: Text('Sort By:',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  // letterSpacing: 1.5,
                  ),  
                ),
              ),

            SizedBox(height:10),
            GestureDetector(
              onTap: (){
                setState(() {
                  message = 'Sorted By Total Confimed';
                  selectedSortOption = 'confirmed';
                  Navigator.pop(context);
                });
                
              },              
              child: Container(
                height: 40,
                width: 220,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(UiElements.padding),
                  color:UiElements.cardViewColor1,

                ),
                child: Text('Total Confimed',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  // letterSpacing: 1.5,
                  ),  
                ),
              ),
            ),
            SizedBox(height:10),
            GestureDetector(
              onTap: (){
                setState(() {
                  message = 'Sorted By Total Deaths';
                  selectedSortOption = 'deaths';
                  Navigator.pop(context);
                });
                
              },              
              child: Container(
                height: 40,
                width: 220,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(UiElements.padding),
                  color:UiElements.cardViewColor1,

                ),
                child: Text('Total Deaths',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  // letterSpacing: 1.5,
                  ),  
                ),
              ),
            ),
            SizedBox(height:10),
          ]
        ),
        )
      )
  );
}
  @override
  Widget build(BuildContext context) {
    if(findingSortedIndexFirst){
      findSortedInex();
      }
    
    return SafeArea(
          child:Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(UiElements.padding*2,0, UiElements.padding*1.5,0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(message,style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        // letterSpacing: 1.5,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          customDialoge(context);
                        },
                        child:Container(
                          height:30,
                          width:30,
                          child:Icon(FontAwesomeIcons.sort,color: Colors.white,),
                        )
                      )
                    ]
                  ),
                ),
                Expanded(
                  child: LiquidPullToRefresh(
                    key:_refreshIndicatorKey,
                    onRefresh:_handleRefresh ,
                    showChildOpacityTransition: false,
                    backgroundColor: UiElements.primaryColor,
                    color: Colors.transparent,
                    springAnimationDurationInMilliseconds : 500,
                    height: 50,
                    borderWidth: 1,
                    child: ListView.builder(
                    itemCount: summaryData.countries.length,
                    itemBuilder: (BuildContext context, int index){
                          if(selectedSortOption=='confimed'){
                            index = sortedIndexKeysTotalConfirmed[(sortedIndexKeysTotalConfirmed.length-1)-index];
                          }
                          else if(selectedSortOption=='deaths'){
                            index = sortedIndexKeysTotalDeaths[(sortedIndexKeysTotalDeaths.length-1)-index];
                          }
                          else{
                            index = sortedIndexKeysTotalConfirmed[(sortedIndexKeysTotalConfirmed.length-1)-index];
                          }
                    return GestureDetector(
                      onTap: (){
                        
                        Navigator.push(context,MaterialPageRoute(builder: (context) => StatisticsScreen(index: index,)),);
                        },
                        child: Stack(
                        children: <Widget>[
                          Container(
                                margin: EdgeInsetsDirectional.fromSTEB(UiElements.padding*1.5,UiElements.padding, UiElements.padding*1.5,0),
                                width: UiElements.screenWidth - UiElements.padding*3,
                                height: UiElements.screenHeight*.08,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(UiElements.padding),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      height: UiElements.screenHeight*.13,
                                      width: (UiElements.screenWidth - UiElements.padding*3)*2/4,
                                      decoration: BoxDecoration(
                                        color: UiElements.cardViewColor3,
                                        borderRadius: BorderRadius.only(topLeft:Radius.circular(UiElements.padding) ,bottomLeft: Radius.circular(UiElements.padding)),
                                      ),                        
                                      child: Padding(
                                        padding: const EdgeInsets.only(left:UiElements.padding*1.5),
                                        child: Text(summaryData.countries[index].country, // TODO update this data
                                        textAlign: TextAlign.left,
                                          style: TextStyle(
                                          color:UiElements.primaryFontColor,
                                          fontSize: 25,
                                          fontWeight:FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      
                                    ),

                                    Container(
                                      width: (UiElements.screenWidth - UiElements.padding*3)/4,
                                      height: UiElements.screenHeight*.13,
                                      decoration: BoxDecoration(
                                        color: UiElements.cardViewColor1,
                                        //borderRadius: BorderRadius.only(topLeft:Radius.circular(UiElements.padding) ,bottomLeft: Radius.circular(UiElements.padding)),
                                      ),                        
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text('${summaryData.countries[index].totalConfirmed}', //Confirmed cases //TODO: update this data
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
                                    width:(UiElements.screenWidth - UiElements.padding*3)/4, 
                                    height: UiElements.screenHeight*.13,
                                    decoration: BoxDecoration(
                                      
                                      color: UiElements.cardViewColor1,
                                      borderRadius: BorderRadius.only(topRight:Radius.circular(UiElements.padding) ,bottomRight: Radius.circular(UiElements.padding)),
                                    ),                        
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text('${summaryData.countries[index].totalDeaths}', // TOD0:update This Data
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

                        ],
                      ),
                    );
                  },
              ),
              ),
                )
          ],

              
            ),

            
            
          
        );
  }
}
