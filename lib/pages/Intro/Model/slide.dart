import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/veg11.png',
    title: 'Fresh Veggiesi',
    description:
        'Have fruits & vegetables if you want to lead a fruitful life.',
  ),
  Slide(
    imageUrl: 'assets/s1.png',
    title: 'Hello Spices!',
    description: 'The easiest way to order spices.',
  ),
  Slide(
    imageUrl: 'assets/fast11.png',
    title: 'Fast Delivery',
    description: 'We are as fast as air and as trustworthy as your heart',
  ),
  Slide(
    imageUrl: 'assets/dis1.png',
    title: 'Great Discounts',
    description: 'Best discounts on every single service we offer.',
  ),
];
