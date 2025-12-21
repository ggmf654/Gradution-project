import 'welcome_body.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red,centerTitle: true,
      title: Text("SARC EMS OP ROOM"),),
    body: WelcomeBody(),
    );
    
  }

}