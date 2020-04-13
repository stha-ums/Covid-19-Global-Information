import 'dart:async';
import 'dart:wasm';

import 'package:covid19/models/summary_model.dart';
import 'package:covid19/screens/statisticsScreen.dart';
import 'package:covid19/status.dart';
import 'package:covid19/style.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:sortedmap/sortedmap.dart';

class Debouncher{
  final int miliseconds;
  VoidCallback action;
  Timer _timer;
  
  Debouncher({this.miliseconds});
  run(VoidCallback action){
    if(null!=_timer){
      _timer.cancel();
    }
    _timer =Timer(Duration(milliseconds: miliseconds),action);
  }
}

class SearchListView extends StatefulWidget {
  @override
  _SearchListViewState createState() => _SearchListViewState();
}

class _SearchListViewState extends State<SearchListView> {
  final TextEditingController _controller = new TextEditingController();
  final _debouncer =Debouncher(miliseconds:500);
  List <Country> summaryCountryDataList ;
  List <Country> filteredDataList;
  bool indexingAll = true;
  @override
  void initState() {
    super.initState();
    setState(() {
      summaryCountryDataList = summaryData.countries;
      filteredDataList = summaryCountryDataList;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
        child: AppBar(
      backgroundColor: UiElements.backgroundcolor,
      elevation: 0,
      title :Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10*.1, 10, 10*.1, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: UiElements.screenWidth*.76,
                    child: TextField(
                      controller:_controller ,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hoverColor: Colors.white,
                        // labelText: "Search",
                        // labelStyle: TextStyle(color:Colors.white),
                        hintText: "Search",
                        hintStyle: TextStyle(color:Colors.white),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear,color: Colors.white,
                          ),
                        splashColor: Colors.transparent, 
                        onPressed: (){
                         _controller.clear();
                        }),
                      ),
                      style: TextStyle(
                        color:Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        ), 

                        onChanged: (string){
                          
                            _debouncer.run((){
                            setState(() {
                                  filteredDataList = summaryCountryDataList
                                      .where((u)=>(u.country)
                                            .toLowerCase()
                                            .contains(string.toLowerCase())).toList();
                                            print(filteredDataList);
                                      indexingAll =false;
                                  }
                                );
                            });

                        },
                    ),

                  ),
                ],
              ),
            ),
          ],
        ),
       ), 
      preferredSize: Size(400, 80)),
      backgroundColor: UiElements.backgroundcolor,
      body: Column(
      children:<Widget> [
      Expanded(child: ListView.builder(
      itemCount: filteredDataList.length,
      itemBuilder: (BuildContext context, int index){
        if(indexingAll){index = sortedIndexKeysTotalConfirmed[(sortedIndexKeysTotalConfirmed.length-1)-index];}
        else
          {index=index;}

        return GestureDetector(
          onTap: (){
            
            
            // Navigator.pop(context);
            if(indexingAll){
            Navigator.push(context,MaterialPageRoute(builder: (context) => StatisticsScreen(index: index,)),);    
            }
            else{
                int indexNew = summaryData.countries.indexOf(filteredDataList[index]);
                Navigator.push(context,MaterialPageRoute(builder: (context) => StatisticsScreen(index: indexNew,)),);
            }
                    },
            child: Stack(
            children: <Widget>[
              Container(
                    margin: EdgeInsetsDirectional.fromSTEB(UiElements.padding*1.5,0, UiElements.padding*1.5,UiElements.padding),
                    width: UiElements.screenWidth - UiElements.padding*3,
                    height: UiElements.screenHeight*.06,
                    decoration: BoxDecoration(
                      color: UiElements.cardViewColor3,
                      borderRadius: BorderRadius.circular(UiElements.padding),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: (UiElements.screenWidth-3*UiElements.padding)-UiElements.screenHeight*.2,
                          alignment: Alignment.centerLeft,
                          height: UiElements.screenHeight*.13,
                          padding: const EdgeInsets.only(left:UiElements.padding),
                          decoration: BoxDecoration(
                            //color: Colors.white,
                            borderRadius: BorderRadius.only(topLeft:Radius.circular(UiElements.padding) ,bottomLeft: Radius.circular(UiElements.padding)),
                          ),                        
                          child: Text(filteredDataList[index].country, // TODO update this data
                            textAlign: TextAlign.start,
                              style: TextStyle(
                                decoration: TextDecoration.none,
                              color:UiElements.primaryFontColor,
                              fontSize: 20,
                              fontWeight:FontWeight.w600,
                              ),
                            ),
                          
                        ),

                        Container(
                          padding: EdgeInsets.only(right:UiElements.padding),
                          //width: UiElements.screenHeight*.2,
                          height: UiElements.screenHeight*.13,
                          child: 
                              Flags.getMiniFlag('${filteredDataList[index].countryCode}', 20, 20)                                           
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
      ],
    ));
}
}


Void findSortedInex() {
if(findingSortedIndexFirst){

  var sortedIndexKeysTotalConfirmedMap = new SortedMap(Ordering.byValue());
  var sortedIndexKeysTotalRecoveredMap= new SortedMap(Ordering.byValue());
  var sortedIndexKeysTotalDeathsMap= new SortedMap(Ordering.byValue());
  var sortedIndexKeysNewConfimedMap= new SortedMap(Ordering.byValue());
  var sortedIndexKeysNewRecoveredMap= new SortedMap(Ordering.byValue());
  var sortedIndexKeysNewDeathsMap= new SortedMap(Ordering.byValue());
  
  for(int i=0; i<summaryData.countries.length;i++){
    var data1 =summaryData.countries[i].totalConfirmed;
    var data2 =summaryData.countries[i].totalRecovered;
    var data3 =summaryData.countries[i].totalDeaths;
    var data4 =summaryData.countries[i].newConfirmed;
    var data5 =summaryData.countries[i].newRecovered;
    var data6 =summaryData.countries[i].newDeaths;

    sortedIndexKeysTotalConfirmedMap[i]= data1;
    sortedIndexKeysTotalRecoveredMap[i]= data2;
    sortedIndexKeysTotalDeathsMap[i]= data3;
    sortedIndexKeysNewConfimedMap[i]= data4;
    sortedIndexKeysNewRecoveredMap[i]= data5;
    sortedIndexKeysNewDeathsMap[i]= data6;

  }
  sortedIndexKeysTotalConfirmed = sortedIndexKeysTotalConfirmedMap.keys.toList();
  sortedIndexKeysTotalRecovered = sortedIndexKeysTotalRecoveredMap.keys.toList();
  sortedIndexKeysTotalDeaths = sortedIndexKeysTotalDeathsMap.keys.toList();
  sortedIndexKeysNewConfimed = sortedIndexKeysNewConfimedMap.keys.toList();
  sortedIndexKeysNewRecovered = sortedIndexKeysNewRecoveredMap.keys.toList();
  sortedIndexKeysNewDeaths = sortedIndexKeysNewDeathsMap.keys.toList();
 
  findingSortedIndexFirst=false;
}
return null;
}