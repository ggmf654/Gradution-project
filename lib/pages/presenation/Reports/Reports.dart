// ignore_for_file: file_names

import 'package:flutter/material.dart';

void main() {
  runApp(const Reports());
}

class Reports extends StatelessWidget {
  const Reports({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF0F0D0D),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFFFF4040),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.report, color: Colors.white),
                    const SizedBox(width: 12),
                    const Text(
                      "New Emergency Report",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.settings, color: Colors.white),
                  ],
                ),
              ),

              // ======= المحتوى الأبيض =======
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(12),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ======= السطر الأول: Caller + Patient =======
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _callerInfoCard()),
                        const SizedBox(width: 20),
                        Expanded(flex: 2, child: _patientInfoCard()),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // ======= السطر الثاني: Medical + Location =======
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _medicalInfoCard()),
                        const SizedBox(width: 20),
                        Expanded(flex: 2, child: _locationInfoCard()),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // ======= السطر الثالث: Staff =======
                    _staffInfoCard(),

                    const SizedBox(height: 20),

                    // ======= الأزرار =======
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text("Waiting"),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text("Move"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================== Widgets لكل كارد ==================
  Widget _callerInfoCard() {
    return _infoCard("Caller Information", [
      _buildTextField("Caller Name"),
      _buildTextField("Relation to Patient"),
      _buildTextField("Relation Number"),
      _buildTextField("Report Time"),
      _buildTextField("Report Date"),
    ]);
  }

  Widget _patientInfoCard() {
    return _infoCard("Patient Information", [
      _buildTextField("Patient Name"),
      _buildRadioRow("Emergency Code", ["Red", "Yellow", "Green"]),
      Row(
        children: [
          Expanded(child: _buildTextField("Age")),
          const SizedBox(width: 12),
          Expanded(child: _buildTextField("Weight (kg)")),
        ],
      ),
      _buildTextField("Medical History", maxLines: 3),
    ]);
  }

  Widget _medicalInfoCard() {
    return _infoCard("Medical Information", [
      Row(
        children: [
          Expanded(child: _buildTextField("Oxygen Level")),
          const SizedBox(width: 12),
          Expanded(child: _buildTextField("Blood Pressure")),
        ],
      ),
      Row(
        children: [
          Expanded(child: _buildTextField("Blood Sugar")),
        ],
      ),
      _buildTextField("Oxygen Support Level"),
      _buildTextField("Oxygen Level After Support"),
      _buildRadioRow("Is Patient Intubated?", ["Yes", "No"]),
      _buildRadioRow("Is Patient Conscious?", ["Yes", "No"]),
    ]);
  }

  Widget _locationInfoCard() {
    return _infoCard("Location and Destination", [
      _buildTextField("Location"),
      _buildTextField("Supervising Doctor"),
      _buildTextField("Doctor's Phone"),
      _buildTextField("going to"),
      _buildTextField("Supervising Doctor"),
      _buildTextField("Doctor's Phone"),
    ]);
  }

  Widget _staffInfoCard() {
    return _infoCard("Staff Information", [
      _buildTextField("Operations Officer"),
      _buildTextField("Sector Commander"),
    ]);
  }

  // ================== Widgets مساعدة ==================
  Widget _infoCard(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
          const SizedBox(height: 12),
          ...children.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: e,
              )),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  Widget _buildRadioRow(String label, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: Colors.black)),
        Row(
          children: options
              .map((o) => Row(
                    children: [
                      Radio(value: o, groupValue: null, onChanged: (v) {}),
                      Text(o),
                    ],
                  ))
              .toList(),
        )
      ],
    );
  }
}
