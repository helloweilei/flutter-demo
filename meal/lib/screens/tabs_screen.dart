import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal/providers/favorite_provider.dart';
import 'package:meal/providers/meals_provider.dart';
import 'package:meal/screens/category_screen.dart';
import 'package:meal/screens/filters_screen.dart';
import 'package:meal/screens/meals_screen.dart';
import 'package:meal/widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

final eventBus = EventBus();
final kInitFilters = <Filter, bool>{
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class _TabsScreenState extends ConsumerState<TabsScreen> {
  var _selectedIndex = 0;
  final _titles = [
    'Categories',
    'Favorites',
  ];

  var _selectedFilters = kInitFilters;

  StreamSubscription? subscription;

  Widget get currentScreen {
    final meals = ref.watch(mealsProvider);
    final favoriteMeals = ref.watch(favoritesProvider);
    if (_selectedIndex == 0) {
      var availableMeals = meals.where((element) {
        if (_selectedFilters[Filter.glutenFree]! && !element.isGlutenFree) {
          return false;
        }
        if (_selectedFilters[Filter.lactoseFree]! && !element.isLactoseFree) {
          return false;
        }
        if (_selectedFilters[Filter.lactoseFree]! && !element.isLactoseFree) {
          return false;
        }
        if (_selectedFilters[Filter.vegetarian]! && !element.isVegetarian) {
          return false;
        }
        if (_selectedFilters[Filter.vegan]! && !element.isVegan) {
          return false;
        }
        return true;
      }).toList();
      return CategoryScreen(
        availableMeals: availableMeals,
      );
    }
    return MealsScreen(
      meals: favoriteMeals,
    );
  }

  @override
  void initState() {
    // subscription = eventBus.on<ToggleFavoriteEvent>().listen((event) {
    //   _toggleFavoriteMeal(event.meal);
    // });
    super.initState();
  }

  @override
  void dispose() {
    // subscription?.cancel();
    super.dispose();
  }

  String get currentLabel => _titles[_selectedIndex];

  void _selectScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            filters: _selectedFilters,
          ),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(currentLabel)),
      body: currentScreen,
      drawer: MainDrawer(
        onSelectScreen: _selectScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.set_meal,
            ),
            label: _titles[0],
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.star,
            ),
            label: _titles[1],
          ),
        ],
      ),
    );
  }
}
