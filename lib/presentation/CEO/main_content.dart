import 'shift_state_card.dart';
import 'package:flutter/material.dart';

import 'active_missions.dart';
import 'center_status_card.dart';
import 'map_placeholder.dart' hide CenterStatusCard;


class MainContent extends StatelessWidget {
  final bool isMobile;
  const MainContent({this.isMobile = false});
  // ... (Data definitions remain the same) ...
  final List<Map<String, dynamic>> centersData = const [
    {'name': 'Center 100', 'activeTasks': 3, 'teams': {'active': 12, 'busy': 8, 'available': 15}},
    {'name': 'Center 115', 'activeTasks': 1, 'teams': {'active': 15, 'busy': 11, 'available': 13}},
  ];
  final List<Map<String, String>> activeMissions = const [
    {'id': '0555', 'type': 'حادث مروري', 'location': 'طريق المطار 102'},
    {'id': '0554', 'type': 'شك اشتباه', 'location': 'الرقة شارع دمشق'},
  ];


  @override
  Widget build(BuildContext context) {
    // ... (Build method logic remains the same) ...
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // أ. المهام النشطة والخريطة
        isMobile
            ? Column(
          children: [
            ActiveMissionsCard(activeMissions: activeMissions),
            const SizedBox(height: 16),
            MapPlaceholder(),
          ],
        )
            : SizedBox(
          height: 300,
          child: Row(
            children: [
              Expanded(child: ActiveMissionsCard(activeMissions: activeMissions)),
              const SizedBox(width: 16),
              Expanded(flex: 2, child: MapPlaceholder()),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // ب. حالة المراكز
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: centersData.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 1 : 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: isMobile ? 3.0 : 2.5,
          ),
          itemBuilder: (context, index) {
            return CenterStatusCard(center: centersData[index]);
          },
        ),
        const SizedBox(height: 20),

        // ت. إحصائيات المناوبات
        const ShiftStatsCard(),
      ],
    );
  }
}
