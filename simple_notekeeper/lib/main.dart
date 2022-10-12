import 'package:flutter/material.dart';


import 'package:simple_notekeeper/Screens/DbTester.dart';

import 'package:simple_notekeeper/Screens/simple_note_list.dart';
import 'package:simple_notekeeper/Screens/simple_note_add.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note Keeper',
      debugShowCheckedModeBanner: false,

     //  home:Notelist(),
   //home:  dbtest(),
   home: simple_list(),
      routes: {"addnote":(context)=>add_note()},
    );
  }
}
