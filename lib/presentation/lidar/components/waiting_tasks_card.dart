import 'package:flutter/material.dart';
import '../data/waiting_tasks_data.dart';

class WaitingTasksCard extends StatelessWidget {
  final bool isDesktop;
  const WaitingTasksCard({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final listView = ListView.builder(
      itemCount: waitingTasksData.length,
      shrinkWrap: !isDesktop,
      physics: isDesktop ? null : const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final task = waitingTasksData[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: task['priority'],
            radius: 6,
          ),
          title: Text(task['type']),
          subtitle: Text('${task['location']} • ${task['time']}'),
          trailing: Text(task['id']),
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
              'المهام المنتظرة',
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
