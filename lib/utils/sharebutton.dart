import 'package:flutter/material.dart';
import 'package:share/share.dart';

void share(TextEditingController one, TextEditingController two, TextEditingController three){
  final String line1 = one.text;
  final String line2 = two.text;
  final String line3 = three.text;
  final String text = line1 + "\n\n"+ line2 + "\n\n"+line3;

  Share.share(text);
}