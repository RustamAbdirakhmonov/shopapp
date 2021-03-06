import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/helpers/db_helper.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(
    String pickedTitle,
    File pickedImage,
  ) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: null,
    );
    _items.add(newPlace);

    DB_Helper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
    notifyListeners();
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DB_Helper.getDataBase('user_places');
    _items = dataList
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            location: null,
            image: File(item['image'])))
        .toList();
    notifyListeners();
  }
}
