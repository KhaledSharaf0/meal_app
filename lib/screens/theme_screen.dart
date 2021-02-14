import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class ThemeScreen extends StatelessWidget {
  static const routeName = '/themes';

  Widget buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      value: currentValue,
      title: Text(title),
      subtitle: Text(description),
      onChanged: updateValue,
      inactiveTrackColor: Colors.black,
    );
  }

  Widget buildRadioListTile(
      ThemeMode themeVal, String text, IconData icon, BuildContext ctx) {
    return RadioListTile(
      title: Text(text),
      secondary: Icon(icon , color: Theme.of(ctx).buttonColor,),
        value: themeVal,
        groupValue: Provider.of<ThemeProvider>(ctx , listen: true ).tm,
        onChanged: (newThemeVal){
          Provider.of<ThemeProvider>(ctx , listen: false).themeModeChange(newThemeVal);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Themes"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text("Adjust your themes selection." ,
            style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Text("Choose your Theme Mode" ,
                  style: Theme.of(context).textTheme.headline6,
                )
              ),
              buildRadioListTile(ThemeMode.system, "System Default Theme", null, context),
              buildRadioListTile(ThemeMode.light, "Light Theme", Icons.wb_sunny_outlined, context),
              buildRadioListTile(ThemeMode.dark, "Dark Theme", Icons.nights_stay_outlined, context),
              buildListTile(context , 'primary'),
              buildListTile(context , 'accent')
            ],
          ))
        ],
      ),
      drawer: MainDrawer(),
    );
  }

  ListTile buildListTile(BuildContext context , txt ){
    var primaryColor = Provider.of<ThemeProvider>(context , listen: true).primaryColor;
    var accentColor = Provider.of<ThemeProvider>(context , listen: true).accentColor;

    return ListTile(
      title: Text('Choose your $txt color' ,
      style: Theme.of(context).textTheme.headline6,),
      trailing: CircleAvatar(
        backgroundColor: txt == "primary" ?primaryColor : accentColor,
      ),
      onTap: (){
        showDialog(context: context, builder: (BuildContext ctx ){
          return AlertDialog(
            elevation: 4 ,
            titlePadding: EdgeInsets.all(0),
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: txt == 'primary' ?Provider.of<ThemeProvider>(context , listen: true).primaryColor :
                Provider.of<ThemeProvider>(context , listen: true).accentColor,
                onColorChanged: (newColor){
                  Provider.of<ThemeProvider>(context , listen: false).onChange(newColor, txt == 'primary' ? 1 : 2);
                },
                colorPickerWidth: 300.0,
                pickerAreaHeightPercent: 0.7 ,
                enableAlpha: true,
                displayThumbColor: true,
                showLabel: false,
              ),
            ),
          );
        });
      },
    );
  }
}
