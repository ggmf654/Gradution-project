import 'dart:async';
import 'package:ems_op_room/pages/presenation/login/login.dart';
import 'package:flutter/material.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    // تحديث التقدم تدريجياً على مدار 3 ثواني
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        progress += 0.033; 
        if (progress >= 1.0) {
          progress = 1.0;
          timer.cancel();
          // هنا يمكنك الانتقال إلى الصفحة التالية
         Navigator.pushReplacement(context,
  MaterialPageRoute(builder: (context) => Login()),);
          
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/car2.jpg',
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.height * 0.8,
            ),
            const SizedBox(height: 20),
            const Text(
              'WELCOME TO SARC OP ROOM',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 7),
            SizedBox(
              width: 200,
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
