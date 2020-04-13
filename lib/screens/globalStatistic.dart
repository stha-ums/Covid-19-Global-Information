import 'package:covid19/models/summary_model.dart';
import 'package:covid19/style.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class GlobalStatisticsScreen extends StatefulWidget {
  final int index;
  GlobalStatisticsScreen({this.index});
  @override
  _GlobalStatisticsScreenState createState() => _GlobalStatisticsScreenState();
}

class _GlobalStatisticsScreenState extends State<GlobalStatisticsScreen> {
  int touchedIndex;
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
                    Text('Global',style: TextStyle(
                          color: Colors.white,
                          fontSize:20,
                          fontWeight: FontWeight.bold,
                          // letterSpacing: 1.5,
                          ),
                        ),
                    Icon(FontAwesomeIcons.globe,color: Colors.red,size:30,),
                  ]
                ),
              ),
              SizedBox(height:UiElements.padding*4),
              Container(
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(2),
                ),
                child:
               AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          if (pieTouchResponse.touchInput is FlLongPressEnd ||
                              pieTouchResponse.touchInput is FlPanEnd) {
                            touchedIndex = -1;
                          } else {
                            touchedIndex = pieTouchResponse.touchedSectionIndex;
                          }
                        });
                      }),
                      startDegreeOffset: 0,
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 2,
                      centerSpaceRadius: 0,
                      sections: showingSections()),
                ),
              ),
              ),
            Padding(
              padding:  EdgeInsets.only(top:UiElements.padding,left:UiElements.padding,right:UiElements.padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 20,
                    width: 20,
                    decoration:BoxDecoration(
                      color:Colors.blue,
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
                  Text('${summaryData.global.totalConfirmed}',
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
              padding:  EdgeInsets.only(top:UiElements.padding,left:UiElements.padding,right:UiElements.padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 20,
                    width: 20,
                    decoration:BoxDecoration(
                      color:Colors.green,
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
                  Text('${summaryData.global.totalRecovered}',
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
              padding:  EdgeInsets.only(top:UiElements.padding,left:UiElements.padding,right:UiElements.padding),
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 20,
                    width: 20,
                    decoration:BoxDecoration(
                      color:Colors.red,
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
                  Text('${summaryData.global.totalDeaths}',
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
              padding:  EdgeInsets.only(top:UiElements.padding,left:UiElements.padding,right:UiElements.padding),
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 20,
                    width: 20,
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
                  Text('${summaryData.global.newConfirmed}',
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
              padding:  EdgeInsets.only(top:UiElements.padding,left:UiElements.padding,right:UiElements.padding),
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 20,
                    width: 20,
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
                  Text('${summaryData.global.newRecovered}',
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
              padding: EdgeInsets.only(top:UiElements.padding,left:UiElements.padding,right:UiElements.padding),
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 20,
                    width: 20,
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
                  Text('${summaryData.global.newDeaths}',
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


 
List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 15 : 10;
      final double radiusConf = isTouched ? 60 : 90;
      final double radius = isTouched ? 80 : 70;
      final double radiusDeaths = isTouched ? 90 : 100;
      final double confirmedCasePercent = summaryData.global.totalConfirmed.toDouble()/(summaryData.global.totalConfirmed.toDouble()+summaryData.global.totalDeaths.toDouble()+summaryData.global.totalRecovered.toDouble())*100;
      final double deathsCasePercent = summaryData.global.totalDeaths.toDouble()/(summaryData.global.totalConfirmed.toDouble()+summaryData.global.totalDeaths.toDouble()+summaryData.global.totalRecovered.toDouble())*100;
      final double recoveredCasePercent =summaryData.global.totalRecovered.toDouble()/(summaryData.global.totalConfirmed.toDouble()+summaryData.global.totalDeaths.toDouble()+summaryData.global.totalRecovered.toDouble())*100;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color:  Colors.red,
            value: deathsCasePercent,
            title: '',
            radius: radiusDeaths,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.blue,
            value: confirmedCasePercent,
            title: '',
            radius: radiusConf,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.green,
            value: recoveredCasePercent,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
      
        default:
          return null;
      }
    });
  }

}

