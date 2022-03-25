import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'models/data.dart';

class SeeAll extends StatefulWidget {
  final Data item;
   SeeAll({Key key,this.item}) : super(key: key);

  @override
  _SeeAllState createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        color: Colors.red,
      )
    );
  }
}
