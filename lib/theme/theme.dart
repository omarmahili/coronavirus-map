import 'package:flutter/material.dart';

var text = {
  'high-emphasis': Colors.black.withOpacity(0.87),
  'medium-emphasis': Colors.black.withOpacity(0.60),
  'disabled': Colors.black.withOpacity(0.38),
};

var createTheme = (context) => ThemeData(
  appBarTheme: AppBarTheme.of(context).copyWith(
    color: Colors.white,
    iconTheme: Theme.of(context).iconTheme.copyWith(
      color: text["high-emphasis"],
    ),
    textTheme: TextTheme(
      title: Theme.of(context).textTheme.title.copyWith(
        color: text["high-emphasis"],
      ),
    ),
  ),
);
