import 'package:flutter/material.dart';
import '../data/active_tasks_data.dart';
import '../data/status_chip.dart';

class ActiveTasksCard extends StatelessWidget {
  final bool isDesktop;

  const ActiveTasksCard({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final listView = ListView.separated(
      itemCount: activeTasksData.length,
      separatorBuilder: (_, __) => const Divider(),
      shrinkWrap: !isDesktop,
      physics: isDesktop ? null : const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final task = activeTasksData[index];
        return Row(
          children: [
            Expanded(flex: 2, child: Text(task['id']!)),
            Expanded(flex: 2, child: Text(task['center']!)),
            Expanded(flex: 2, child: Text(task['teamLeader']!)),
            Expanded(flex: 2, child: Text(task['caseType']!)),
            if (isDesktop) Expanded(flex: 2, child: Text(task['destination']!)),
            Expanded(flex: 2, child: statusChip(task['status']!, Colors.blue)),
          ],
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
              'المهام النشطة',
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
