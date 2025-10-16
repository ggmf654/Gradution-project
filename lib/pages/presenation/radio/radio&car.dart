// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Radiocar extends StatelessWidget {
  const Radiocar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(children: [
          GeneratedDesign(),
        ]),
      ),
    );
  }
}

class GeneratedDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 1273.60,
          height: 878.50,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: -12,
                top: -10,
                child: Container(
                  width: 1297,
                  height: 919,
                  decoration: BoxDecoration(color: const Color(0xFF111111)),
                ),
              ),
              Positioned(
                left: 36,
                top: 17,
                child: Container(
                  width: 1200,
                  height: 84,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFF4040),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 60,
                top: 41,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/36x36"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 122,
                top: 38,
                child: Text(
                  'Ambulance Missions Dashboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 36,
                top: 181,
                child: Container(
                  width: 1200,
                  height: 607,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFFBFB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x00000000),
                        blurRadius: 0,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      ),BoxShadow(
                        color: Color(0x00000000),
                        blurRadius: 0,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      ),BoxShadow(
                        color: Color(0x00000000),
                        blurRadius: 0,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      ),BoxShadow(
                        color: Color(0x00000000),
                        blurRadius: 0,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      ),BoxShadow(
                        color: Color(0x33000000),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 60,
                top: 221,
                child: Text(
                  'mahmod alzagaba',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w600,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 60,
                top: 259,
                child: Text(
                  'Responding Center',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 60,
                top: 288,
                child: Opacity(
                  opacity: 0.10,
                  child: Container(
                    width: 124,
                    height: 43,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF333333),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF444444),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 204,
                top: 259,
                child: Text(
                  'Ambulance Code',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 204,
                top: 288,
                child: Opacity(
                  opacity: 0.10,
                  child: Container(
                    width: 111,
                    height: 43,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF333333),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF444444),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 337,
                top: 259,
                child: Text(
                  'Team Leader',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 337,
                top: 288,
                child: Opacity(
                  opacity: 0.11,
                  child: Container(
                    width: 84,
                    height: 43,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF333333),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF444444),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 443,
                top: 259,
                child: Text(
                  'Departure Time',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 567,
                top: 259,
                child: Text(
                  'Arrival Time',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 565,
                top: 288,
                child: Opacity(
                  opacity: 0.10,
                  child: Container(
                    width: 81,
                    height: 43,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF333333),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF444444),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 801,
                top: 259,
                child: Text(
                  'Hospital Transfer?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 1008,
                top: 259,
                child: Text(
                  'Reason for No Transfer',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 1005,
                top: 288,
                child: Opacity(
                  opacity: 0.10,
                  child: Container(
                    width: 208,
                    height: 43,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF333333),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF444444),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 660,
                top: 259,
                child: Text(
                  'Mission End Time',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 660,
                top: 288,
                child: Opacity(
                  opacity: 0.10,
                  child: Container(
                    width: 121,
                    height: 43,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF333333),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF444444),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 607,
                top: 818,
                child: Text(
                  'See All Missions',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 1175.59,
                top: 44,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.black.withValues(alpha: 0),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 1175.59,
                top: 44,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.black.withValues(alpha: 0),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 36,
                top: 211,
                child: Container(
                  width: 1200,
                  height: 141,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFE5E5E5),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 60,
                top: 378,
                child: SizedBox(
                  width: 160,
                  child: Text(
                    'samera mahmod',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w600,
                      height: 1.50,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 60,
                top: 416,
                child: SizedBox(
                  width: 124,
                  child: Text(
                    'Responding Center',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 60,
                top: 445,
                child: Opacity(
                  opacity: 0.11,
                  child: Container(
                    width: 124,
                    height: 43,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF333333),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF444444),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 204,
                top: 416,
                child: SizedBox(
                  width: 111,
                  child: Text(
                    'Ambulance Code',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 204,
                top: 445,
                child: Opacity(
                  opacity: 0.10,
                  child: Container(
                    width: 111,
                    height: 43,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF333333),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF444444),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 337,
                top: 416,
                child: SizedBox(
                  width: 84,
                  child: Text(
                    'Team Leader',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 337,
                top: 445,
                child: Opacity(
                  opacity: 0.10,
                  child: Container(
                    width: 84,
                    height: 43,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF333333),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF444444),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 443,
                top: 416,
                child: SizedBox(
                  width: 102,
                  child: Text(
                    'Departure Time',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 443,
                top: 445,
                child: Opacity(
                  opacity: 0.11,
                  child: Container(
                    width: 102,
                    height: 43,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF333333),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF444444),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 567,
                top: 416,
                child: SizedBox(
                  width: 79,
                  child: Text(
                    'Arrival Time',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 565,
                top: 445,
                child: Opacity(
                  opacity: 0.10,
                  child: Container(
                    width: 81,
                    height: 43,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF333333),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF444444),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 801,
                top: 416,
                child: SizedBox(
                  width: 118,
                  child: Text(
                    'Hospital Transfer?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 1008,
                top: 416,
                child: SizedBox(
                  width: 149,
                  child: Text(
                    'Reason for No Transfer',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 1005,
                top: 445,
                child: Opacity(
                  opacity: 0.10,
                  child: Container(
                    width: 208,
                    height: 43,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF333333),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF444444),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 668,
                top: 416,
                child: SizedBox(
                  width: 113,
                  child: Text(
                    'Mission End Time',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 660,
                top: 445,
                child: Opacity(
                  opacity: 0.10,
                  child: Container(
                    width: 121,
                    height: 43,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF333333),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF444444),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 36,
                top: 368,
                child: Container(
                  width: 1200,
                  height: 141,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFE5E5E5),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 60,
                top: 541,
                child: SizedBox(
                  width: 160,
                  child: Text(
                    'tamam saleh',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w600,
                      height: 1.50,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 60,
                top: 579,
                child: SizedBox(
                  width: 124,
                  child: Text(
                    'Responding Center',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 60,
                top: 608,
                child: Opacity(
                  opacity: 0.11,
                  child: Container(
                    width: 124,
                    height: 43,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF333333),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF444444),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 204,
                top: 579,
                child: SizedBox(
                  width: 111,
                  child: Text(
                    'Ambulance Code',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 204,
                top: 608,
                child: Opacity(
                  opacity: 0.10,
                  child: Container(
                    width: 111,
                    height: 43,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF333333),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF444444),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 337,
                top: 579,
                child: SizedBox(
                  width: 84,
                  child: Text(
                    'Team Leader',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 337,
                top: 608,
                child: Opacity(
                  opacity: 0.10,
                  child: Container(
                    width: 84,
                    height: 43,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF333333),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF444444),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 443,
                top: 579,
                child: SizedBox(
                  width: 102,
                  child: Text(
                    'Departure Time',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 443,
                top: 608,
                child: Opacity(
                  opacity: 0.11,
                  child: Container(
                    width: 102,
                    height: 43,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF333333),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF444444),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 567,
                top: 579,
                child: SizedBox(
                  width: 79,
                  child: Text(
                    'Arrival Time',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 565,
                top: 608,
                child: Opacity(
                  opacity: 0.10,
                  child: Container(
                    width: 81,
                    height: 43,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF333333),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF444444),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 801,
                top: 579,
                child: SizedBox(
                  width: 118,
                  child: Text(
                    'Hospital Transfer?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 1008,
                top: 579,
                child: SizedBox(
                  width: 149,
                  child: Text(
                    'Reason for No Transfer',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 1005,
                top: 608,
                child: Opacity(
                  opacity: 0.10,
                  child: Container(
                    width: 208,
                    height: 43,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF333333),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF444444),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 668,
                top: 579,
                child: SizedBox(
                  width: 113,
                  child: Text(
                    'Mission End Time',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 660,
                top: 608,
                child: Opacity(
                  opacity: 0.10,
                  child: Container(
                    width: 121,
                    height: 43,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF333333),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF444444),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 36,
                top: 531,
                child: Container(
                  width: 1200,
                  height: 141,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFE5E5E5),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 1181,
                top: 218,
                child: Text(
                  'end',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 1182,
                top: 377,
                child: Text(
                  'end',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 1181,
                top: 540,
                child: Text(
                  'end',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 270,
                top: 228,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFF4040),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: const Color(0xFFFF4040),
                      ),
                      borderRadius: BorderRadius.circular(26843500),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 270,
                top: 385,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF00FF0C),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: const Color(0xFF00FF0C),
                      ),
                      borderRadius: BorderRadius.circular(26843500),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 270,
                top: 548,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFB940),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: const Color(0xFFFFB940),
                      ),
                      borderRadius: BorderRadius.circular(26843500),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 36,
                top: 109,
                child: Container(
                  width: 1200,
                  height: 61,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFFBFB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x00000000),
                        blurRadius: 0,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      ),BoxShadow(
                        color: Color(0x00000000),
                        blurRadius: 0,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      ),BoxShadow(
                        color: Color(0x00000000),
                        blurRadius: 0,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      ),BoxShadow(
                        color: Color(0x00000000),
                        blurRadius: 0,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      ),BoxShadow(
                        color: Color(0x33000000),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 228,
                top: 127,
                child: Text(
                  '7',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0.67,
                  ),
                ),
              ),
              Positioned(
                left: 833,
                top: 128,
                child: Text(
                  '5',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0.67,
                  ),
                ),
              ),
              Positioned(
                left: 149,
                top: 135,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFF4040),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: const Color(0xFFFF4040),
                      ),
                      borderRadius: BorderRadius.circular(26843500),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 69,
                top: 130,
                child: SizedBox(
                  width: 70,
                  height: 28,
                  child: Text(
                    'Red',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 36,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0.67,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 1077,
                top: 127,
                child: Text(
                  'Add New Mission',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFFEFBFB),
                    fontSize: 16,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 50,
                top: 115,
                child: Container(
                  width: 247,
                  height: 50,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFE5E5E5),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 477,
                top: 131,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFB940),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: const Color(0xFFFFB940),
                      ),
                      borderRadius: BorderRadius.circular(26843500),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 359,
                top: 125,
                child: SizedBox(
                  width: 205,
                  height: 28,
                  child: Text(
                    'Yellow',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 36,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0.67,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 534,
                top: 127,
                child: Text(
                  '2',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0.67,
                  ),
                ),
              ),
              Positioned(
                left: 341,
                top: 114,
                child: Container(
                  width: 247,
                  height: 50,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFE5E5E5),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 773,
                top: 131,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF00FF0C),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: const Color(0xFF00FF0C),
                      ),
                      borderRadius: BorderRadius.circular(26843500),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 650,
                top: 125,
                child: SizedBox(
                  width: 126,
                  height: 28,
                  child: Text(
                    'Green',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 36,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0.67,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 636,
                top: 115,
                child: Container(
                  width: 247,
                  height: 50,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFE5E5E5),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
  