import 'package:flutter/material.dart';
import 'package:meal_app/providers/myprovider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  // bool _glutenFree = false;
  // bool _vegetarian = false;
  // bool _vegan = false;
  // bool _lactoseFree = false;

  // @override
  // initState() {
  //   final Map<String, bool> currentFilters = Provider.of<MyProvider>(context , listen: false).filters;
  //
  //   _glutenFree = currentFilters['gluten'];
  //   _lactoseFree = currentFilters['lactose'];
  //   _vegetarian = currentFilters['vegetarian'];
  //   _vegan = currentFilters['vegan'];
  //   super.initState();
  // }

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(
        description,
      ),
      onChanged: updateValue,
      inactiveTrackColor:
          Provider.of<ThemeProvider>(context).tm == ThemeMode.light
              ? null
              : Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> currentFilters =
        Provider.of<MyProvider>(context, listen: true).filters;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.save),
        //     onPressed: () {
        //       final selectedFilters = {
        //         'gluten': _glutenFree,
        //         'lactose': _lactoseFree,
        //         'vegan': _vegan,
        //         'vegetarian': _vegetarian,
        //       };
        //      Provider.of<MyProvider>(context , listen: false).setFilters(selectedFilters);
        //     },
        //   )
        // ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  'Gluten-free',
                  'Only include gluten-free meals.',
                  currentFilters['gluten'],
                  (newValue) {
                    setState(
                      () {
                        currentFilters['gluten'] = newValue;
                      },
                    );
                    Provider.of<MyProvider>(context, listen: false)
                        .setFilters();
                  },
                ),
                _buildSwitchListTile(
                  'Lactose-free',
                  'Only include lactose-free meals.',
                  currentFilters['lactose'],
                  (newValue) {
                    setState(
                      () {
                        currentFilters['lactose'] = newValue;
                      },
                    );
                    Provider.of<MyProvider>(context, listen: false)
                        .setFilters();
                  },
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only include vegetarian meals.',
                  currentFilters['vegetarian'],
                  (newValue) {
                    setState(
                      () {
                        currentFilters['vegetarian'] = newValue;
                      },
                    );
                    Provider.of<MyProvider>(context, listen: false)
                        .setFilters();
                  },
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only include vegan meals.',
                  currentFilters['vegan'],
                  (newValue) {
                    setState(
                      () {
                        currentFilters['vegan'] = newValue;
                      },
                    );
                    Provider.of<MyProvider>(context, listen: false)
                        .setFilters();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
