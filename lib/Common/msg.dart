import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showMsg(BuildContext context, String msg, {Color c = Colors.red}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg),
    backgroundColor: c,
  ));
}
