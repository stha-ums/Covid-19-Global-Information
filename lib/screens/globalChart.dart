
import 'package:covid19/models/summary_model.dart';
import 'package:covid19/style.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PieChartGloble extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PieChartGloble();
}

class _PieChartGloble extends State {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(UiElements.padding),
        color: UiElements.cardViewColor3,),
        child: Column(
          children: <Widget>[
            SizedBox(height:8),
            Text('Global Data',style: TextStyle(
              color:UiElements.primaryFontColor,
              fontSize: 18,
              fontWeight:FontWeight.w600
            ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: AspectRatio(
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
                      sectionsSpace: 5,
                      centerSpaceRadius: 0,
                      sections: showingSections()),
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.all(UiElements.padding),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('Total Deaths: ${summaryData.global.totalDeaths}',
                      style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      ), 
                      ),
                      SizedBox(width: UiElements.padding,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Icon(FontAwesomeIcons.squareFull,color: Colors.red,)),
                    ],
                  ),
                  SizedBox(height : UiElements.padding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('Total Recovered: ${summaryData.global.totalRecovered}',
                      style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      ),                      
                      ),
                      SizedBox(width: UiElements.padding,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Icon(FontAwesomeIcons.squareFull,color: Colors.green,)),
                    ],
                  ),
                  SizedBox(height : UiElements.padding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('Total Confirmed: ${summaryData.global.totalConfirmed}',
                      style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      ),
                      ),
                      SizedBox(width: UiElements.padding,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Icon(FontAwesomeIcons.squareFull,color: Colors.blue,)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 15 : 10;
      final double radiusConf = isTouched ? 60 : UiElements.screenWidth*0.22;
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