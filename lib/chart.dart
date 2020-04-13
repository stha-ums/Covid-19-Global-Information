import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'package:covid19/models/totalDataModelaDaily.dart';

// import '../fl_chart/lib/fl_chart.dart';

class Chart extends StatefulWidget {
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient:LinearGradient(
            colors: const [
              Colors.black,
              Colors.black,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            ),
          ),
          child: LineChart(
            plotData(),
          ),
        ) ,
        );
  }
}

LineChartData plotData() {
    xFinder();
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.black.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {
        },
        handleBuiltInTouches: true,
      ),
      borderData:FlBorderData(
        show: true,
      ),
      gridData: const FlGridData(
        drawVerticalLine: true,
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          interval: 1,
          reservedSize: 100,
          textStyle: const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            return getTitles(value);
            },
        ),
        leftTitles: SideTitles(
          showTitles: false,
          interval: 1
        ),
      ),

      minX: xDateData.reduce(min),
      maxX: xDateData.reduce(max),
      maxY: (numberofCasesConfirmedListTotal.isEmpty)?0:numberofCasesConfirmedListTotal.reduce(max),
      minY: (numberofCasesConfirmedListTotal.isEmpty)?0:numberofCasesConfirmedListTotal.reduce(min),
      lineBarsData: linesBarData1(),
      
    );
  }

  List<LineChartBarData> linesBarData1() {
   LineChartBarData lineChartBarConfirmed = LineChartBarData(
      spots: spotList('confirmed'),
      isCurved: true,
      colors: [
        Color(0xff4af699),
         Color(0xff4af699)],
      curveSmoothness: 0,
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
       LineChartBarData lineChartBarRecovered = LineChartBarData(
      spots: spotList('recovered'),
      isCurved: true,
      colors: [
        Color(0xffaa4cfc),
        Color(0xffaa4cfc)],
      curveSmoothness: 0,
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    LineChartBarData lineChartBarDeaths = LineChartBarData(
      spots: spotList('deaths'),
      isCurved: true,
      colors: [
        Color(0xff27b6fc),
        Color(0xff27b6fc)],
      curveSmoothness: 0,
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [
      lineChartBarConfirmed,
      lineChartBarRecovered,
      lineChartBarDeaths,

    ];
  }

List <FlSpot> spotList(String status){
  List <FlSpot> spots=[];
    
  try{
      if(status =='recovered'){
        if(caseDateRecoveredListTotal.isEmpty){
          spots.add(FlSpot(0,0));}
        else{        
          for(int i=0;i<caseDateRecoveredListTotal.length;i++)
          { 
            spots.add(FlSpot(xDateData[i],numberofCasesRecoveredListTotal[i]));
          }
          }
      }
      else if(status =='confirmed'){
        if(numberofCasesConfirmedListTotal.isEmpty){
          spots.add(FlSpot(0,0));
        }
        else{
        for(int i=0;i<numberofCasesConfirmedListTotal.length;i++)
        {
          spots.add(FlSpot(xDateData[i],numberofCasesConfirmedListTotal[i]));
        }
        }
      }
      else if(status =='deaths'){
        if(caseDateDeathsListTotal.isEmpty){
          spots.add(FlSpot(0,0));
        }
        else{
        for(int i=0;i<caseDateDeathsListTotal.length;i++)
        {
          spots.add(FlSpot(xDateData[i],numberofCasesDeathsListTotal[i]));
        }
        }
      }
   }
  catch(e){print('error');
   print(e);
   }
  return spots;
}

Tuple2 <List <double>,List<double> > devizerMonth(){
  List <double> dividerVal=[] ;
  List <double> outmouth=[];
  for(int i=0;i<caseDateDeathsListTotal.length;i++){
    if(caseDateDeathsListTotal[i].day==31){
      dividerVal.add(31);
      outmouth.add(caseDateDeathsListTotal[i].month.toDouble());
    }
    else if(caseDateDeathsListTotal[i].day==32)
    {
      dividerVal.add(32);
      outmouth.add(caseDateDeathsListTotal[i].month.toDouble());

    }
    else{
      dividerVal.add(30);
    }
  }
  return new Tuple2(dividerVal,outmouth);    
}

void xFinder() {
  double xData ;
  List <double> mnth32=[]; 
  List <double> divimnth32date=[];
  bool isMnth32 =false;
  Tuple2 devizermnth = devizerMonth();

  if(devizermnth.item2.length!=0)
  {
    for(int k=0;k<devizermnth.item2.length;k++){
      mnth32.add(devizermnth.item2[k]);
      divimnth32date.add(devizermnth.item1[k]);
    }
  }
      
  try{
        for(int i=0;i<caseDateRecoveredListTotal.length;i++)
        { 
          for(int j=0;j<mnth32.length;j++){
            if(caseDateRecoveredListTotal[i].month==mnth32[j]){
              xData = caseDateRecoveredListTotal[i].month+ 1/divimnth32date[j]*caseDateRecoveredListTotal[i].day;   
              xDateData.add(xData);
              
              isMnth32 =true;
              break;
            }
            isMnth32 =false;
          }
          if(isMnth32==false){
              xData = caseDateRecoveredListTotal[i].month+1/30*caseDateRecoveredListTotal[i].day;
              xDateData.add(xData);
          }          
        }
   }
  catch(e){print('error');
   print(e);
   }
}

String getTitles(value){
  var v = value.toInt();
  if(v>=1 && v< 2){return 'jan';}
  else if(v>=2 && v< 3){return 'feb';}
  else if(v>=3 && v< 4){return 'mar';}
  else if(v>=4 && v< 5){return 'apr';}
  else if(v>=5 && v< 6){return 'may';}
  else if(v>=6 && v< 7){return 'jun';}
  else if(v>=7 && v< 8){return 'jul';}
  else if(v>=8 && v< 9){return 'aug';}
  else if(v>=9 && v< 10){return 'sep';}
  else if(v>=10 && v< 11){return 'oct';}
  else if(v>=11 && v< 12){return 'nov';}
  else {return 'dec';}
}