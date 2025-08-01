import 'package:flutter/material.dart';

class CategoryModel {
  String id;
  String name;
  String imageName;
  IconData icon;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageName,
    required this.icon,
  });
  static List<CategoryModel> categories = [
    CategoryModel(
      id: '1',
      name: 'Sport',
      icon: Icons.sports_basketball,
      imageName: 'sport',
    ),
    CategoryModel(
      id: '2',
      name: 'Birthday',
      icon: Icons.cake_outlined,
      imageName: 'birthday',
    ),
    CategoryModel(
      id: '3',
      name: 'Meeting',
      icon: Icons.people,
      imageName: 'meeting',
    ),
    CategoryModel(
      id: '4',
      name: 'Gaming',
      icon: Icons.videogame_asset,
      imageName: 'gaming',
    ),
    CategoryModel(
      id: '5',
      name: 'Eating',
      icon: Icons.local_dining,
      imageName: 'eating',
    ),
    CategoryModel(
      id: '6',
      name: 'Holiday',
      icon: Icons.beach_access,
      imageName: 'holiday',
    ),
    CategoryModel(
      id: '8',
      name: 'Exihibtion',
      icon: Icons.image,
      imageName: 'exhibition',
    ),
    CategoryModel(
      id: '7',
      name: 'WorkShop',
      icon: Icons.handyman,
      imageName: 'workshop',
    ),
    CategoryModel(
      id: '9',
      name: 'BookClub',
      icon: Icons.library_books,
      imageName: 'bookclub',
    ),
  ];
}
