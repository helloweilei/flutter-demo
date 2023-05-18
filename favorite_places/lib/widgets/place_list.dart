import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/place_detail_screen.dart';
import 'package:flutter/material.dart';

class PlaceList extends StatelessWidget {
  const PlaceList({
    super.key,
    required this.places,
  });
  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
        );
    return places.isEmpty
        ? Center(
            child: Text('No places added yet.', style: titleStyle),
          )
        : ListView.builder(
            itemCount: places.length,
            itemBuilder: (ctx, index) => ListTile(
              title: Text(
                places[index].title,
                style: titleStyle,
              ),
              leading: CircleAvatar(
                radius: 26,
                backgroundImage: FileImage(places[index].image),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => PlaceDetailScreen(
                      place: places[index],
                    ),
                  ),
                );
              },
            ),
          );
  }
}
