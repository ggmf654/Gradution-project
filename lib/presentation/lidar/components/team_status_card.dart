import 'package:flutter/material.dart';
import '../data/team_members_data.dart';

class TeamStatusCard extends StatelessWidget {
  final bool isDesktop;
  const TeamStatusCard({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final listView = ListView.builder(
      itemCount: teamMembersData.length,
      shrinkWrap: !isDesktop,
      physics: isDesktop ? null : const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final member = teamMembersData[index];

        return ListTile(
          dense: true,
          title: Text(member['name']),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: member['color'].withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              member['status'],
              style: TextStyle(
                color: member['color'],
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
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
              'حالة الفرق',
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
