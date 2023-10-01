// ignore_for_file: file_names
import 'package:flutter/material.dart';

class QuoteVariable {
  String quotes;
  String author;
  Color? c;
  int count;

  QuoteVariable(
      {required this.quotes, required this.author, this.c, this.count = 0});
}
