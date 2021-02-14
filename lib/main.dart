import 'package:flutter/material.dart';
import 'package:meal_app/providers/myprovider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/screens/theme_screen.dart';
import 'package:provider/provider.dart';

import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/filters_screen.dart';


void main() {
  runApp(
    MultiProvider(
     providers: [
      ChangeNotifierProvider<MyProvider>(
        create: (ctx) => MyProvider(),
      ),
       ChangeNotifierProvider<ThemeProvider>(
         create: (ctx) => ThemeProvider(),
       ),
     ],
      child:  MyApp(),
    ),
  );
  //       ChangeNotifierProvider<MyProvider>(
  //   create: (ctx) => MyProvider(),
  //   child: MyApp(),
  // ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var primaryColor = Provider.of<ThemeProvider>(context , listen: true).primaryColor;
    var accentColor = Provider.of<ThemeProvider>(context , listen: true).accentColor;
    var tm = Provider.of<ThemeProvider>(context , listen: true).tm;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      themeMode: tm,
      theme: ThemeData(
        primarySwatch: primaryColor,
        accentColor: accentColor,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        buttonColor: Colors.black87,
        cardColor: Colors.white,
        shadowColor: Colors.black87,
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
            ),
            headline6: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      darkTheme: ThemeData(
        primarySwatch: primaryColor,
        accentColor:accentColor,
        canvasColor: Color.fromRGBO(14, 22, 33, 1),
        fontFamily: 'Raleway',
        buttonColor: Colors.white70,
        cardColor: Color.fromRGBO(35, 34, 39, 1),
        shadowColor: Colors.white60,
        unselectedWidgetColor: Colors.white70,
        textTheme: ThemeData.dark().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Colors.white60
            ),
            headline6: TextStyle(
              color: Colors.white60,
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/', // default is '/'
      routes: {
        '/': (ctx) => TabsScreen(),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
        FiltersScreen.routeName: (ctx) => FiltersScreen(),
        ThemeScreen.routeName: (ctx) => ThemeScreen(),
      },
    );
  }
}
