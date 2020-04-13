import 'package:covid19/screens/countrywise.dart';
import 'package:covid19/screens/globalScreen.dart';
import 'package:covid19/screens/information.dart';
import 'package:covid19/services/searchCountries.dart';
import 'package:covid19/style.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreens extends StatefulWidget {
  @override
  _HomeScreensState createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  int _selectedIndex = 1 ;

  Widget screenSelector(index){
  if(index==0) return CountryWise();
  else if (index==1) return  GlobalScreen() ;
  else if (index==2) return InfoSysmtomps() ;
  else 
  return GlobalScreen();
  }

  @override
  Widget build(BuildContext context) {
    final screenDimention = MediaQuery.of(context).size;
    UiElements.screenHeight = screenDimention.height;
    UiElements.screenWidth = screenDimention.width;

    return Scaffold(
      appBar: MyCustomAppBar(height:60,), //appbar is already build
      backgroundColor: Colors.black87,
      body: screenSelector(_selectedIndex),

      bottomNavigationBar:ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(UiElements.padding*1.5),
        topRight: Radius.circular(UiElements.padding*1.5),),
          child: CurvedNavigationBar(
          items: <Widget>[
             Icon(FontAwesomeIcons.flagCheckered,color: Colors.white,semanticLabel: 'Global',),
             Icon(FontAwesomeIcons.globeAsia,color: Colors.white),
             Icon(FontAwesomeIcons.info,color: Colors.white)
          ],
          onTap: (index){
            setState(() {
              print(UiElements.screenWidth);
              _selectedIndex=index;
            });
          },
        animationCurve: Curves.linear,
        animationDuration: const Duration(milliseconds: 300),
        index: _selectedIndex, 
        height: 55,
        backgroundColor: UiElements.primaryColor,
        buttonBackgroundColor:Colors.transparent,
        color: UiElements.cardViewColor3,
        ),
      )
    );
  }
}


class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const MyCustomAppBar({
    Key key,
    @required this.height,
   
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: UiElements.backgroundcolor,
      elevation: 0,
      title :Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(UiElements.padding*.1, UiElements.padding, UiElements.padding*.1, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Covid 19 ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: UiElements.primaryFontSize,
                      fontWeight: FontWeight.bold,
                      // letterSpacing: 1.5,
                      ),
                    ),
                  GestureDetector(
                    onTap: (){
                      print('search button pressed');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SearchListView()));       
                        },
                    child: Icon(FontAwesomeIcons.search,color: Colors.white,)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(UiElements.padding*.1, 0, 0, 0),
              child: Text('Global Corona Data',
                style: TextStyle(
                  color:UiElements.primaryColor,
                  fontSize: 15,
                  fontWeight:FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
    );
  }
 @override
  Size get preferredSize => Size.fromHeight(height);
}


