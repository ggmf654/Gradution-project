// ignore_for_file: avoid_function_literals_in_foreach_calls, override_on_non_overriding_member

import 'dart:async';
import 'package:flutter/material.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  final List<NotificationItem> _notifications = [];
  final StreamController<List<NotificationItem>> _streamController = 
      StreamController<List<NotificationItem>>.broadcast();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  Stream<List<NotificationItem>> get notificationsStream => _streamController.stream;

  List<NotificationItem> get notifications => _notifications;

  void addNotification({
    required String title,
    required String message,
    required NotificationType type,
    String? icon,
    Duration? duration,
  }) {
    final notification = NotificationItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      message: message,
      type: type,
      icon: icon,
      timestamp: DateTime.now(),
      isRead: false,
    );

    _notifications.insert(0, notification);
    _streamController.add(_notifications);

    // Auto-remove notification after duration
    if (duration != null) {
      Future.delayed(duration, () {
        removeNotification(notification.id);
      });
    }
  }

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index].isRead = true;
      _streamController.add(_notifications);
    }
  }

  void markAllAsRead() {
    _notifications.forEach((n) => n.isRead = true);
    _streamController.add(_notifications);
  }

  void removeNotification(String id) {
    _notifications.removeWhere((n) => n.id == id);
    _streamController.add(_notifications);
  }

  void clearAll() {
    _notifications.clear();
    _streamController.add(_notifications);
  }

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  @override
  void dispose() {
    _streamController.close();
  }
}

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final String? icon;
  final DateTime timestamp;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    this.icon,
    required this.timestamp,
    this.isRead = false,
  });

  Color get color {
    switch (type) {
      case NotificationType.success:
        return Colors.green;
      case NotificationType.warning:
        return Colors.orange;
      case NotificationType.error:
        return Colors.red;
      case NotificationType.info:
        return Colors.blue;
      case NotificationType.emergency:
        return Colors.redAccent;
    }
  }

  IconData get iconData {
    if (icon != null) {
      return IconData(
        int.parse(icon!.replaceAll('0x', ''), radix: 16),
        fontFamily: 'MaterialIcons',
      );
    }
    switch (type) {
      case NotificationType.success:
        return Icons.check_circle;
      case NotificationType.warning:
        return Icons.warning;
      case NotificationType.error:
        return Icons.error;
      case NotificationType.info:
        return Icons.info;
      case NotificationType.emergency:
        return Icons.sos;
    }
  }
}

enum NotificationType {
  success,
  warning,
  error,
  info,
  emergency,
}

class NotificationManager {
  static final NotificationService _service = NotificationService();

  static void showMissionAssigned(String missionId, String centerName) {
    _service.addNotification(
      title: 'مهمة جديدة',
      message: 'تم تعيين المهمة $missionId إلى مركز $centerName',
      type: NotificationType.info,
      duration: const Duration(seconds: 5),
    );
  }

  static void showEmergencyAlert(String location) {
    _service.addNotification(
      title: 'تنبيه طوارئ',
      message: 'حالة طوارئ في $location',
      type: NotificationType.emergency,
      duration: const Duration(seconds: 10),
    );
  }

  static void showTeamStatus(String teamName, String status) {
    _service.addNotification(
      title: 'تحديث حالة الفريق',
      message: 'الفريق $teamName: $status',
      type: NotificationType.info,
      duration: const Duration(seconds: 3),
    );
  }

  static void showSystemUpdate(String message) {
    _service.addNotification(
      title: 'تحديث النظام',
      message: message,
      type: NotificationType.info,
      duration: const Duration(seconds: 4),
    );
  }

  static void showSuccess(String message) {
    _service.addNotification(
      title: 'نجاح',
      message: message,
      type: NotificationType.success,
      duration: const Duration(seconds: 3),
    );
  }

  static void showError(String message) {
    _service.addNotification(
      title: 'خطأ',
      message: message,
      type: NotificationType.error,
      duration: const Duration(seconds: 5),
    );
  }

  static void showWarning(String message) {
    _service.addNotification(
      title: 'تحذير',
      message: message,
      type: NotificationType.warning,
      duration: const Duration(seconds: 4),
    );
  }
}

class NotificationBadge extends StatelessWidget {
  final int count;
  final VoidCallback onTap;

  const NotificationBadge({
    super.key,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: onTap,
        ),
        if (count > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withValues(alpha: 0.5),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Center(
                child: Text(
                  count > 99 ? '99+' : count.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<NotificationItem>>(
      stream: NotificationService().notificationsStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_off,
                  size: 64,
                  color: Theme.of(context).hintColor,
                ),
                const SizedBox(height: 16),
                Text(
                  'لا توجد إشعارات',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final notification = snapshot.data![index];
            return NotificationItemWidget(notification: notification);
          },
        );
      },
    );
  }
}

class NotificationItemWidget extends StatelessWidget {
  final NotificationItem notification;

  const NotificationItemWidget({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        notification.iconData,
        color: notification.color,
        size: 28,
      ),
      title: Text(
        notification.title,
        style: TextStyle(
          fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
          color: notification.isRead ? null : Theme.of(context).textTheme.titleLarge?.color,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(notification.message),
          const SizedBox(height: 4),
          Text(
            _formatTime(notification.timestamp),
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
      trailing: notification.isRead
          ? null
          : Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: notification.color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
      onTap: () {
        NotificationService().markAsRead(notification.id);
      },
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return 'الآن';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} دقيقة';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ساعة';
    } else {
      return '${difference.inDays} يوم';
    }
  }
}