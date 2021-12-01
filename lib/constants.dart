import 'package:flutter/material.dart';

const KInputDecoratioon=InputDecoration(
  filled: true,
  labelStyle: TextStyle(color: Colors.black),
  hintText: 'Registernummer eingeben',
  fillColor: Colors.white,
  hintStyle: TextStyle(
    color: Colors.black,
  ),
  contentPadding: EdgeInsets.only(top: 8,left: 10.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
  ),
);