

import 'package:flutter/material.dart';

class EnterPNR extends StatelessWidget {
  const EnterPNR({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
       children: [
        SizedBox(width: double.infinity),
        Text("Enter PNR")
      ],),
    );
  }
}