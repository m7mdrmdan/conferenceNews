import 'package:flutter/material.dart';

class Newsmodal {
  final String id;
  final String title;
  final String description;
  final String details;
  final String image;


  Newsmodal(
      {
      @required this.id,
      @required this.title,
      @required this.description,
      @required this.details,
      @required this.image
      });
}