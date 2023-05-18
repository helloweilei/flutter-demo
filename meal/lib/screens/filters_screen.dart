import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.filters});
  final Map<Filter, bool> filters;
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class _FiltersScreenState extends State<FiltersScreen> {
  Map<Filter, bool> filters = {};

  @override
  void initState() {
    super.initState();
    filters = widget.filters;
  }

  Widget _createSwitch(Filter filter, String title, String subtitle) {
    filters.putIfAbsent(filter, () => false);
    return SwitchListTile(
      value: filters[filter]!,
      onChanged: (isChecked) {
        setState(() {
          filters.update(filter, (value) => isChecked);
        });
      },
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(filters);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your filters'),
        ),
        body: Column(
          children: [
            _createSwitch(
              Filter.glutenFree,
              'Gluten-free',
              'Only includes Gluten-free meals.',
            ),
            _createSwitch(
              Filter.lactoseFree,
              'Lactose-Free',
              'Only includes Lactose-free meals.',
            ),
            _createSwitch(
              Filter.vegetarian,
              'Vegetarian',
              'Only includes Vegetarian meals.',
            ),
            _createSwitch(
              Filter.vegan,
              'Vegan-tree',
              'Only includes Vegan meals.',
            ),
          ],
        ),
      ),
    );
  }
}
