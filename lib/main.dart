import 'package:blurgs_app/master.dart';
import 'package:blurgs_app/tables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter_test/flutter_test.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Test',
      initialRoute: "/",
      routes: {
        "/": (context) => MasterPage(),
        //"/tables": (context) => TablePage(),
        //"/master": (context) => MasterPage(),
      },
    );
  }
}

void main() {
  runApp(const MyApp());
}
