import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/MovieList.dart';


// Main method starts execution
void main() {
  runApp(
      new MaterialApp(
          home: new Scaffold(
            // App toolbar code
              appBar: new AppBar(
                title: new Text('Movie List'),
              ),
              body: new MovieList()
          )
      )
  );
}
