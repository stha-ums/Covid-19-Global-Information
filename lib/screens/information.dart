import 'package:covid19/style.dart';
import 'package:flutter/material.dart';

class InfoSysmtomps extends StatefulWidget {
  @override
  _InfoSysmtompsState createState() => _InfoSysmtompsState();
}

class _InfoSysmtompsState extends State<InfoSysmtomps> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(UiElements.padding*1.5, UiElements.padding, UiElements.padding*1.5, UiElements.padding),
      child: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Symtomps : ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height:5),
            Text("‣ Fever, cough, shortness of breath ",
            style: TextStyle(
              color: UiElements.primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height:10),
            Text("Complications: ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height:5),
            Text("‣ Pneumonia, Acute respiratory distress syndrome (ARDS), kidney failure. ",
            style: TextStyle(
              color: UiElements.primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height:10),
            Text("Risk Factors: ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height:5),
            Text("‣ Age, serious underlying medical conditions (e.g. heart disease, diabetes, lung disease, etc). ",
            style: TextStyle(
              color: UiElements.primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              ),

            ),

            SizedBox(height:10),
            Text("Tips: ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height:5),
            Text("‣ Wash your hands frequently.",
            style: TextStyle(
              color: UiElements.primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              ),
            ),
                        SizedBox(height:5),
            Text("‣ Avoid touching your face.",
            style: TextStyle(
              color: UiElements.primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              ),
            ),
                        SizedBox(height:5),
            Text("‣ Sneeze and cough into a tissue or your elbow.",
            style: TextStyle(
              color: UiElements.primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              ),
            ),
                        SizedBox(height:5),
            Text("‣ Avoid crowds and standing near others..",
            style: TextStyle(
              color: UiElements.primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              ),
            ),
                        SizedBox(height:5),
            Text("‣ Stay home if you think you might be sick.",
            style: TextStyle(
              color: UiElements.primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              ),
            ),
          SizedBox(height:5),        
        ],
      ),
    );
  }
}