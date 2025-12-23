import 'package:flutter/material.dart';
import '../data/centers_data.dart';

class CentersStatusCard extends StatelessWidget {
  final bool isDesktop;
  const CentersStatusCard({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final listView = ListView.builder(
      itemCount: centersData.length,
      shrinkWrap: !isDesktop,
      physics: isDesktop ? null : const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final center = centersData[index];
        return ListTile(
          title: Text(center['name']),
          subtitle: Text(
            'فرق: ${center['teams']} | منجز: ${center['completed']}',
          ),
          trailing: Icon(
            Icons.circle,
            size: 12,
            color: center['color'],
          ),
        );
      },
    );

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'حالة المراكز',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            if (isDesktop)
              Expanded(child: listView)
            else
              listView,
          ],
        ),
      ),
    );
  }
}
