import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  var primaryColor = Colors.pink;
  var accentColor = Colors.amber;

  var tm = ThemeMode.system;
  String themeText = 's';

  onChange(newcolor, n) async {
    n == 1
        ? primaryColor = _setMaterialColor(newcolor.hashCode)
        : accentColor = _setMaterialColor(newcolor.hashCode);

    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("primaryColor", primaryColor.value);
    prefs.setInt("accentColor", accentColor.value);
  }

  getThemeColor()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //to convert to colors
    primaryColor = _setMaterialColor(prefs.getInt("primaryColor") ?? 0xFFE91E63);
    accentColor =  _setMaterialColor(prefs.getInt("accentColor") ?? 0xFFFFC107);
    notifyListeners();
  }

  _getThemeText(ThemeMode tm ){
    if(tm == ThemeMode.dark){
      themeText = 'd';
    }else if(tm == ThemeMode.light){
      themeText = 'l';
    }else if(tm == ThemeMode.system){
      themeText = 's';
    }

  }


  //to convert any color in material color
  MaterialColor _setMaterialColor(colorVal) {
    return MaterialColor(
      colorVal,
      <int, Color>{
        50: Color(0xFFF3E5F5),
        100: Color(0xFFE1BEE7),
        200: Color(0xFFCE93D8),
        300: Color(0xFFBA68C8),
        400: Color(0xFFAB47BC),
        500: Color(colorVal),
        600: Color(0xFF8E24AA),
        700: Color(0xFF7B1FA2),
        800: Color(0xFF6A1B9A),
        900: Color(0xFF4A148C),
      },
    );
  }

  void themeModeChange(newThemeVal) async {
    tm = newThemeVal;
    _getThemeText(tm);
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("themeText", themeText);
  }


  getThemeMode ()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeText = prefs.getString("themeText") ?? "s";
    if(themeText == 'd'){
      tm = ThemeMode.dark;
    }else if(themeText == 'l'){
      tm = ThemeMode.light;
    }else if(themeText == 's'){
      tm = ThemeMode.system;
    }
    notifyListeners();
  }
}
