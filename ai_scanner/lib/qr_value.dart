
import 'package:flutter/material.dart';

class QrValue extends StatelessWidget {
   QrValue({super.key, required this.scannedResult});
  String scannedResult ;
  @override
  Widget build(BuildContext context) {
    return Scaffold( body: Column(mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
     children: [
      SizedBox(width: double.infinity),
      Text(scannedResult,style: TextStyle(fontSize: 24),)
    ],),);
  }
}