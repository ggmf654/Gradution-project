import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ems_op_room/core/providers/app_providers.dart';

class WaitingTasksCard extends ConsumerWidget {
  final bool isDesktop;
  const WaitingTasksCard({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final waitingTasks = ref.watch(waitingTasksProvider);

    final listView = ListView.builder(
      itemCount: waitingTasks.length,
      shrinkWrap: !isDesktop,
      physics: isDesktop ? null : const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final task = waitingTasks[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: task['priority'] as Color? ?? Colors.grey,
            radius: 6,
          ),
          title: Text(task['type']?.toString() ?? ''),
          subtitle: Text(
            '${task['location'] ?? ''} • ${task['time'] ?? ''}',
          ),
          trailing: Wrap(
            spacing: 8,
            children: [
              Text(task['id']?.toString() ?? ''),
              TextButton(
                onPressed: () {
                  _showTaskDetailsDialog(context, task);
                },
                child: const Text('عرض التفاصيل'),
              ),
              ElevatedButton(
                onPressed: () {
                  _showCenterSelectionSheet(context, ref, task);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: const Text('تحريك مركز'),
              ),
            ],
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

  void _showTaskDetailsDialog(
    BuildContext context,
    Map<String, dynamic> task,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(task['type']?.toString() ?? 'تفاصيل المهمة'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('المعرف: ${task['id'] ?? ''}'),
              const SizedBox(height: 8),
              Text('الموقع: ${task['location'] ?? ''}'),
              const SizedBox(height: 8),
              Text('الوقت: ${task['time'] ?? ''}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('إغلاق'),
            ),
          ],
        );
      },
    );
  }

  void _showCenterSelectionSheet(
    BuildContext context,
    WidgetRef ref,
    Map<String, dynamic> task,
  ) {
    final centers = ['100', '110', '140', '115'];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            const Text(
              'اختر المركز لتحريك المهمة',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ...centers.map(
              (centerCode) => ListTile(
                title: Text('مركز $centerCode', textDirection: TextDirection.rtl),
                onTap: () {
                  final id = task['id']?.toString() ?? '';
                  // إزالة المهمة من قائمة الانتظار
                  ref.read(waitingTasksProvider.notifier).removeTask(id);
                  // إضافتها إلى قائمة المهام النشطة في Lidar
                  ref
                      .read(activeTasksProvider.notifier)
                      .addFromWaiting(task, centerCode);
                  // إضافتها إلى المهام التي تظهر في شاشة الراديو
                  ref
                      .read(radioMissionsProvider.notifier)
                      .addFromWaiting(task, centerCode);

                  Navigator.of(context).pop();
                },
              ),
            ),
            const SizedBox(height: 12),
          ],
        );
      },
    );
  }
}
