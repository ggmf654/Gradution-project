// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Reports extends StatelessWidget {
  const Reports({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = theme.cardColor;
    final isDarkMode = theme.brightness == Brightness.dark;

    final primaryTextColor = isDarkMode ? Colors.white : Colors.black87;
    final secondaryTextColor =
    isDarkMode ? Colors.white70 : Colors.grey[600]!;

    return Scaffold(
        backgroundColor: cardColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // ======= Header =======
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
                    const Icon(Icons.settings, color: Colors.white),
                  ],
                ),
              ),

              // ======= Main White Content =======
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(12),
                  ),
                  boxShadow: const [
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
                    // ===== Row #1 =====
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: _callerInfoCard(
                                primaryTextColor, secondaryTextColor)),
                        const SizedBox(width: 20),
                        Expanded(
                            flex: 2,
                            child: _patientInfoCard(
                                primaryTextColor, secondaryTextColor)),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // ===== Row #2 =====
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: _medicalInfoCard(
                                primaryTextColor, secondaryTextColor)),
                        const SizedBox(width: 20),
                        Expanded(
                            flex: 2,
                            child: _locationInfoCard(
                                primaryTextColor, secondaryTextColor)),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // ===== Row #3 =====
                    _staffInfoCard(primaryTextColor, secondaryTextColor),
                    const SizedBox(height: 20),

                    // ===== Buttons =====
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

    );
  }

  // ================== Cards ==================

  Widget _callerInfoCard(Color primary, Color secondary) {
    return _infoCard(
      "Caller Information",
      [
        _buildTextField(
            "Caller Name", primaryTextColor: primary, secondaryTextColor: secondary),
        _buildTextField("Relation to Patient",
            primaryTextColor: primary, secondaryTextColor: secondary),
        _buildTextField("Relation Number",
            primaryTextColor: primary, secondaryTextColor: secondary),
        _buildTextField("Report Time",
            primaryTextColor: primary, secondaryTextColor: secondary),
        _buildTextField("Report Date",
            primaryTextColor: primary, secondaryTextColor: secondary),
      ],
      primary,
      secondary,
    );
  }

  Widget _patientInfoCard(Color primary, Color secondary) {
    return _infoCard(
      "Patient Information",
      [
        _buildTextField("Patient Name",
            primaryTextColor: primary, secondaryTextColor: secondary),
        _buildRadioRow("Emergency Code", ["Red", "Yellow", "Green"], primary, secondary),
        Row(
          children: [
            Expanded(
              child: _buildTextField("Age",
                  primaryTextColor: primary, secondaryTextColor: secondary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField("Weight (kg)",
                  primaryTextColor: primary, secondaryTextColor: secondary),
            ),
          ],
        ),
        _buildTextField("Medical History",
            maxLines: 3, primaryTextColor: primary, secondaryTextColor: secondary),
      ],
      primary,
      secondary,
    );
  }

  Widget _medicalInfoCard(Color primary, Color secondary) {
    return _infoCard(
      "Medical Information",
      [
        Row(
          children: [
            Expanded(
              child: _buildTextField("Oxygen Level",
                  primaryTextColor: primary, secondaryTextColor: secondary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField("Blood Pressure",
                  primaryTextColor: primary, secondaryTextColor: secondary),
            ),
          ],
        ),
        _buildTextField("Blood Sugar",
            primaryTextColor: primary, secondaryTextColor: secondary),
        _buildTextField("Oxygen Support Level",
            primaryTextColor: primary, secondaryTextColor: secondary),
        _buildTextField("Oxygen Level After Support",
            primaryTextColor: primary, secondaryTextColor: secondary),
        _buildRadioRow("Is Patient Intubated?", ["Yes", "No"], primary, secondary),
        _buildRadioRow("Is Patient Conscious?", ["Yes", "No"], primary, secondary),
      ],
      primary,
      secondary,
    );
  }

  Widget _locationInfoCard(Color primary, Color secondary) {
    return _infoCard(
      "Location and Destination",
      [
        _buildTextField("Location",
            primaryTextColor: primary, secondaryTextColor: secondary),
        _buildTextField("Supervising Doctor",
            primaryTextColor: primary, secondaryTextColor: secondary),
        _buildTextField("Doctor's Phone",
            primaryTextColor: primary, secondaryTextColor: secondary),
        _buildTextField("going to",
            primaryTextColor: primary, secondaryTextColor: secondary),
        _buildTextField("Supervising Doctor",
            primaryTextColor: primary, secondaryTextColor: secondary),
        _buildTextField("Doctor's Phone",
            primaryTextColor: primary, secondaryTextColor: secondary),
      ],
      primary,
      secondary,
    );
  }

  Widget _staffInfoCard(Color primary, Color secondary) {
    return _infoCard(
      "Staff Information",
      [
        _buildTextField("Operations Officer",
            primaryTextColor: primary, secondaryTextColor: secondary),
        _buildTextField("Sector Commander",
            primaryTextColor: primary, secondaryTextColor: secondary),
      ],
      primary,
      secondary,
    );
  }

  // ================== Shared Widgets ==================

  Widget _infoCard(
      String title,
      List<Widget> children,
      Color primaryTextColor,
      Color secondaryTextColor,
      ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryTextColor,
            ),
          ),
          const SizedBox(height: 12),
          ...children.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: e,
          )),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label, {
        int maxLines = 1,
        required Color primaryTextColor,
        required Color secondaryTextColor,
      }) {
    return TextField(
      maxLines: maxLines,
      style: TextStyle(color: primaryTextColor),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: secondaryTextColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  Widget _buildRadioRow(
      String label,
      List<String> options,
      Color primaryTextColor,
      Color secondaryTextColor,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: primaryTextColor,
          ),
        ),
        Row(
          children: options
              .map(
                (o) => Row(
              children: [
                Radio(
                  value: o,
                  groupValue: null,
                  onChanged: (v) {},
                  fillColor: MaterialStateProperty.all(primaryTextColor),
                ),
                Text(
                  o,
                  style: TextStyle(color: secondaryTextColor),
                ),
              ],
            ),
          )
              .toList(),
        ),
      ],
    );
  }
}
