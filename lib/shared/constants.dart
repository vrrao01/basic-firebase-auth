import 'package:flutter/material.dart';

InputDecoration formFieldDecoration = InputDecoration(
  fillColor: Colors.blueAccent[100],
  filled : true,
  contentPadding: EdgeInsets.all(10),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color:Colors.blueAccent[100],width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0)
  )
);