// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/material.dart';

// شاشة Lidar مصممة لتكون متوافقة مع الوضع الفاتح والداكن
class Lidar extends StatelessWidget {
  const Lidar({super.key});

  @override
  Widget build(BuildContext context) {
    // استخدام Theme.of(context) لضمان التجاوب مع وضع العرض الحالي (Dark/Light)
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    
    // تم تغيير لون شريط التطبيق إلى الأحمر
    const appBarColor = Colors.red;
    
    // ألوان النصوص تعتمد على وضع العرض
    final primaryTextColor = isDarkMode ? Colors.white : Colors.black87;
    final secondaryTextColor = isDarkMode ? Colors.white70 : Colors.grey[600];
    final primaryColor = theme.primaryColor;
    final cardColor = theme.cardColor;

    // تحديد ما إذا كانت الشاشة واسعة (أكثر من 800 بكسل)
    final isLargeScreen = MediaQuery.of(context).size.width > 800;
    
    // الألوان الثابتة المستخدمة للحالة
    const errorColor = Colors.red;
    const warningColor = Colors.orange;
    const infoColor = Colors.blue;


    // البيانات الوهمية للمهام المنتظرة (تم زيادة عددها وإضافة التمرير العمودي)
    final waitingTasks = [
      {'id': '#1001', 'type': 'حادث سير', 'location': 'المزرعة', 'time': 'منذ 5 د', 'priority': errorColor},
      {'id': '#1002', 'type': 'احتشاء عضلة قلبية', 'location': 'حي السلام ', 'time': 'منذ 15 د', 'priority': errorColor}, // تم تغيير الأولوية
      {'id': '#1003', 'type': 'حريق محدود', 'location': 'الصناعة', 'time': 'منذ 25 د', 'priority': warningColor},
      {'id': '#1004', 'type': 'إصابة عمل', 'location': 'المهاجرين', 'time': 'منذ 30 د', 'priority': warningColor},
      {'id': '#1005', 'type': 'إغماء', 'location': 'سوق البالة', 'time': 'منذ 40 د', 'priority': infoColor},
      {'id': '#1006', 'type': 'حادث دهس', 'location': ' شارع29ايار', 'time': 'منذ 50 د', 'priority': errorColor},
      {'id': '#1007', 'type': 'نوبة صرع', 'location': 'ضاحية قدسيا دوار العلم', 'time': 'منذ 60 د', 'priority': infoColor},
    ];

    return Scaffold(
      appBar: AppBar(
        // تعيين لون البار العلوي باللون الأحمر
        backgroundColor: appBarColor,
        title: Text(
          'غرفة عمليات Lidar',
          // استخدام الأبيض للنص على خلفية حمراء
          style: const TextStyle(color: Colors.white), 
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // لوغو (Image Box) غير تفاعلي
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Image.asset('assets/images/png-clipart-syrian-arab-red-crescent-american-red-cross-damascus-international-red-cross-and-red-crescent-movement-international-committee-of-the-red-cross-others-text-tradema.png'), // Placeholder. يمكن استبدالها بـ Image.asset('path/to/logo.png')
                
          ),
        ],
      ),
      // تم إزالة SingleChildScrollView لتأخذ الصفحة حجم الشاشة دون تمرير عامودي خارجي
      body: Padding( 
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. بطاقة المهام النشطة (Active Tasks) - تأخذ كامل العرض
            // تم تغليفها بـ Expanded داخل هذا Column لضمان وجود مساحة محددة لتطبيق التمرير الداخلي في حالة isLargeScreen
            Expanded(
              flex: isLargeScreen ? 2 : 0, // إعطاء مساحة نسبية أكبر في الشاشات الكبيرة
              child: _buildActiveTasksCard(
                cardColor,
                primaryTextColor,
                secondaryTextColor!,
                primaryColor,
                isLargeScreen,
              ),
            ),
            const SizedBox(height: 20),

            // 2. المحتوى المرن (Tasks, Team, Centers)
            // استخدام Expanded لتوزيع المساحة المتبقية
            Expanded(
              flex: isLargeScreen ? 3 : 1, // إعطاء مساحة نسبية أكبر لبقية المحتوى
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // ترتيب أفقي على الشاشات الكبيرة
                  if (isLargeScreen) {
                    return IntrinsicHeight( // لجعل جميع العناصر بنفس الطول
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // المهام المنتظرة (Waiting Tasks) - flex: 7 لملء المساحة المتبقية
                          // تم التعديل عليها لإضافة التمرير وحل مشكلة الـ overflow
                          Expanded(flex: 7, child: _buildWaitingTasksCard(cardColor, primaryTextColor, secondaryTextColor, primaryColor, waitingTasks)),
                          const SizedBox(width: 16),
                          // حالة الفريق والمراكز - flex: 3
                          Expanded(
                            flex: 3, 
                            child: Column(
                              children: [
                                // حالة المناوبين (تحتوي على التمرير العمودي)
                                Expanded(flex: 1, child: _buildTeamStatusCard(cardColor, primaryTextColor, secondaryTextColor)),
                                const SizedBox(height: 16),
                                // المراكز (تحتوي على التمرير العمودي)
                                Expanded(flex: 1, child: _buildCentersStatusCard(cardColor, primaryTextColor, secondaryTextColor)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    // ترتيب عمودي على الشاشات الصغيرة
                    // SingleChildScrollView الخارجي لتمكين التمرير للصفحة بأكملها في وضع الشاشات الصغيرة
                    return SingleChildScrollView( 
                      child: Column(
                        children: [
                          // المهام المنتظرة (لم تعد بحاجة لـ Expanded هنا لأنها داخل SingleChildScrollView)
                          _buildWaitingTasksCard(cardColor, primaryTextColor, secondaryTextColor, primaryColor, waitingTasks, isSmallScreen: true),
                          const SizedBox(height: 16),
                          _buildTeamStatusCard(cardColor, primaryTextColor, secondaryTextColor, isSmallScreen: true),
                          const SizedBox(height: 16),
                          _buildCentersStatusCard(cardColor, primaryTextColor, secondaryTextColor, isSmallScreen: true),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // ====================================================================
  // دوال المساعدة (تم جعلها static لحل مشاكل النطاق)
  // ====================================================================

  static Widget _buildActiveTasksCard(
    Color cardColor,
    Color primaryTextColor,
    Color secondaryTextColor,
    Color primaryColor,
    bool isLargeScreen,
  ) {
    // بيانات المهام النشطة الجديدة: تم فصل حقل المسار إلى 'departure' و 'destination'
    final activeTasks = [
      {'id': '#0555', 'center': 'Center 100', 'status': 'في المنزل', 'time': '12:30', 'teamLeader': 'مازن علي', 'caseType': 'حادث سير', 'departure': 'المزة', 'destination': 'مشفى المهايني'},
      {'id': '#0554', 'center': 'Center 115', 'status': 'الى المستشفى', 'time': '12:20', 'teamLeader': 'فهد يوسف', 'caseType': 'احتشاء عضلة قلبية', 'departure': 'حي السلام', 'destination': 'مشفى العربي'},
      {'id': '#0553', 'center': 'Center 100', 'status': 'الى المنزل', 'time': '12:35', 'teamLeader': 'ناصر سامي', 'caseType': 'حريق محدود', 'departure': 'المستودع 3', 'destination': 'عيادة متخصصة'},
      {'id': '#0552', 'center': 'Center 120', 'status': ' مركز وصول', 'time': '12:10', 'teamLeader': 'هالة كمال', 'caseType': 'إصابة عمل', 'departure': 'منطقة صناعية A', 'destination': 'مشفى الأمل'},
      {'id': '#0551', 'center': 'Center 115', 'status': 'عودة', 'time': '12:00', 'teamLeader': 'ياسر خالد', 'caseType': 'إغماء', 'departure': 'سوق البالة', 'destination': 'قاعدة'},
    ];

    // تحديد العرض للجدول بناءً على حجم الشاشة
    if (isLargeScreen) {
      return Card(
        color: cardColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'المهام النشطة (Active Tasks) - ${activeTasks.length} مهمة',
                style: TextStyle(color: primaryTextColor, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // عرض جدول (DataTable) للمهام النشطة داخل شريط تمرير عمودي وأفقي
              Expanded( // يضمن أن الجدول يأخذ مساحة مرنة
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical, // التمرير العمودي
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal, // التمرير الأفقي
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('رقم المهمة', style: TextStyle(color: primaryTextColor, fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('مركز الاستجابة', style: TextStyle(color: primaryTextColor, fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('قائد الفريق', style: TextStyle(color: primaryTextColor, fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('نوع الحالة', style: TextStyle(color: primaryTextColor, fontWeight: FontWeight.bold))),
                        // تم تقسيم عمود المسار إلى عمودين
                        DataColumn(label: Text('من (انطلاق)', style: TextStyle(color: primaryTextColor, fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('إلى (وجهة)', style: TextStyle(color: primaryTextColor, fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('وجهة السيارة', style: TextStyle(color: primaryTextColor, fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('وقت التحديث', style: TextStyle(color: primaryTextColor, fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('إجراء', style: TextStyle(color: primaryTextColor, fontWeight: FontWeight.bold))),
                      ],
                      rows: activeTasks.map((task) {
                        return DataRow(cells: [
                          DataCell(Text(task['id']!, style: TextStyle(color: primaryTextColor))),
                          DataCell(Text(task['center']!, style: TextStyle(color: primaryTextColor))),
                          DataCell(Text(task['teamLeader']!, style: TextStyle(color: primaryTextColor))),
                          DataCell(Text(task['caseType']!, style: TextStyle(color: secondaryTextColor))),
                          // عرض الانطلاق
                          DataCell(Text(task['departure']!, style: TextStyle(color: secondaryTextColor))),
                          // عرض الوجهة
                          DataCell(Text(task['destination']!, style: TextStyle(color: secondaryTextColor))),
                          DataCell(_buildStatusChip(task['status']!, secondaryTextColor)),
                          DataCell(Text(task['time']!, style: TextStyle(color: secondaryTextColor))),
                          DataCell(
                            InkWell(
                              onTap: () {
                                print('View details for active task ${task['id']}');
                              },
                              child: Text(
                                'View',
                                style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // عرض قائمة (ListView) للمهام النشطة على الشاشات الصغيرة
      return Card(
        color: cardColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'المهام النشطة (Active Tasks) - ${activeTasks.length} مهمة',
                style: TextStyle(color: primaryTextColor, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // إضافة SingleChildScrollView لجعل قائمة البطاقات قابلة للتمرير عمودياً
              SizedBox( 
                height: 350, 
                child: SingleChildScrollView(
                  child: Column(
                    children: activeTasks.map((task) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text('${task['id']} - ${task['caseType']}', style: TextStyle(color: primaryTextColor, fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('قائد: ${task['teamLeader']}', style: TextStyle(color: secondaryTextColor)),
                              // عرض الانطلاق والوجهة بشكل منفصل
                              Text('من: ${task['departure']}', style: TextStyle(color: secondaryTextColor)),
                              Text('إلى: ${task['destination']}', style: TextStyle(color: secondaryTextColor)),
                              _buildStatusChip(task['status']!, secondaryTextColor),
                            ],
                          ),
                          trailing: InkWell(
                            onTap: () {
                              print('View details for active task ${task['id']}');
                            },
                            child: Text(
                              'View',
                              style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  // تم تنقيح هذه الدالة لحل مشكلة الـ Overflow التي ظهرت في الصورة
  static Widget _buildWaitingTasksCard(
    Color cardColor,
    Color primaryTextColor,
    Color secondaryTextColor,
    Color primaryColor,
    List<Map<String, dynamic>> waitingTasks,
    {bool isSmallScreen = false}
  ) {
    return Card(
      color: cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'المهام المنتظرة (Waiting Tasks) - ${waitingTasks.length} مهمة',
              style: TextStyle(color: primaryTextColor, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            // استخدام Expanded فقط عندما لا تكون الشاشة صغيرة، لتجنب الـ Overflow
            if (!isSmallScreen)
              Expanded(
                child: SingleChildScrollView(
                  child: _buildWaitingTaskList(waitingTasks, primaryTextColor, secondaryTextColor, primaryColor)
                ),
              ),
            // في حالة الشاشات الصغيرة، نستخدم SingleChildScrollView مباشرة
            if (isSmallScreen)
              SingleChildScrollView(
                child: _buildWaitingTaskList(waitingTasks, primaryTextColor, secondaryTextColor, primaryColor)
              ),
          ],
        ),
      ),
    );
  }

  static Widget _buildWaitingTaskList(List<Map<String, dynamic>> waitingTasks, Color primaryTextColor, Color secondaryTextColor, Color primaryColor) {
    return Column(
      children: waitingTasks.map((task) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.warning_amber_rounded, color: task['priority'] as Color, size: 24),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${task['id']} - ${task['type']}',
                      style: TextStyle(color: primaryTextColor, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      task['location']!,
                      style: TextStyle(color: secondaryTextColor, fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      task['time']!,
                      style: TextStyle(color: task['priority'] as Color, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // أزرار الإجراءات (View Details + Assign Center)
              _buildTaskActionButtons(primaryColor, primaryTextColor, secondaryTextColor, task['id'] as String),
            ],
          ),
        );
      }).toList(),
    );
  }

  static Widget _buildTaskActionButtons(
    Color primaryColor,
    Color primaryTextColor,
    Color secondaryTextColor,
    String taskId,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // زر عرض التفاصيل
        OutlinedButton(
          onPressed: () {
            print('View Details for task $taskId');
            // TODO: تنفيذ منطق فتح شاشة التفاصيل
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryTextColor,
            side: BorderSide(color: secondaryTextColor),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          child: const Text('View Details', style: TextStyle(fontSize: 12)),
        ),
        const SizedBox(width: 8),
        // زر تخصيص المركز
        ElevatedButton(
          onPressed: () {
            print('Assign Center for task $taskId');
      //TODO: تنفيذ منطق فتح نافذة الحوار للتخصيص
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          child: const Text('Assign Center', style: TextStyle(color: Colors.white, fontSize: 12)),
        ),
      ],
    );
  }

  // تم تعديل هذه الدالة لإضافة تمرير عمودي وزيادة عدد المناوبين وتغيير الحالات
  static Widget _buildTeamStatusCard(
    Color cardColor,
    Color primaryTextColor,
    Color secondaryTextColor,
    {bool isSmallScreen = false}
  ) {
    // بيانات المناوبين في غرفة العمليات (تم زيادة العدد وتغيير الحالات)
    final teamMembers = [
      {'name': 'خالد محمد', 'status': 'محطة', 'color': Colors.blue.shade400},
      {'name': 'فاطمة أحمد', 'status': 'جدول', 'color': Colors.orange.shade400},
      {'name': 'علي سعيد', 'status': 'حالات', 'color': Colors.green.shade400},
      {'name': 'نورة يوسف', 'status': 'حالات', 'color': Colors.green.shade400},
      {'name': 'سعد إبراهيم', 'status': 'محطة', 'color': Colors.blue.shade400},
      {'name': 'ليلى فهد', 'status': 'جدول', 'color': Colors.orange.shade400},
      {'name': 'ياسر خالد', 'status': 'حالات', 'color': Colors.green.shade400},
      {'name': 'مريم ناصر', 'status': 'محطة', 'color': Colors.blue.shade400},
      {'name': 'أحمد صلاح', 'status': 'حالات', 'color': Colors.green.shade400},
      {'name': 'هند ماجد', 'status': 'جدول', 'color': Colors.orange.shade400},
      {'name': 'تركي سلمان', 'status': 'محطة', 'color': Colors.blue.shade400},
      {'name': 'سارة فيصل', 'status': 'حالات', 'color': Colors.green.shade400},
      {'name': 'ماجد نواف', 'status': 'جدول', 'color': Colors.orange.shade400},
    ];

    final content = Column(
      children: teamMembers.map((member) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 7.0),
          child: Row(
            children: [
              Icon(Icons.circle, size: 10, color: member['color'] as Color),
              const SizedBox(width: 8),
              Expanded( // استخدام Expanded لمنع الفيضان في أسماء المناوبين الطويلة
                child: Text(member['name'] as String, style: TextStyle(color: primaryTextColor)),
              ),
              Text(
                member['status'] as String, 
                style: TextStyle(
                  color: member['color'] as Color, // استخدام لون يعبر عن المهمة
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                )
              ),
            ],
          ),
        );
      }).toList(),
    );

    return Card(
      color: cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'حالة مناوبي العمليات',
              style: TextStyle(color: primaryTextColor, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // إضافة Expanded و SingleChildScrollView لإضافة شريط التمرير العمودي
            Expanded(
              child: SingleChildScrollView(
                child: content,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // تم تعديل هذه الدالة لإضافة تمرير عمودي (SingleChildScrollView) وعدد مراكز أكبر
  static Widget _buildCentersStatusCard(
    Color cardColor,
    Color primaryTextColor,
    Color secondaryTextColor,
    {bool isSmallScreen = false}
  ) {
    // بيانات مراكز الإسعاف (تم إضافة مراكز عشوائية لتجربة شريط التمرير)
    final centers = [
      {'name': 'Center 100', 'teams': 3, 'completed': 12, 'active': 2, 'color': Colors.blue},
      {'name': 'Center 115', 'teams': 2, 'completed': 8, 'active': 1, 'color': Colors.orange},
      {'name': 'Center 120', 'teams': 1, 'completed': 4, 'active': 0, 'color': Colors.green},
      // مراكز إضافية للتجربة
      {'name': 'Center 130', 'teams': 4, 'completed': 20, 'active': 3, 'color': Colors.red},
      {'name': 'Center 140', 'teams': 1, 'completed': 5, 'active': 0, 'color': Colors.green},
      {'name': 'Center 150', 'teams': 3, 'completed': 15, 'active': 2, 'color': Colors.blueGrey},
      {'name': 'Center 160', 'teams': 2, 'completed': 9, 'active': 1, 'color': Colors.deepOrange},
      {'name': 'Center 170', 'teams': 1, 'completed': 3, 'active': 0, 'color': Colors.purple},
    ];

    final content = Column(
      children: centers.map((center) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: center['color'] as Color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(center['name'] as String, style: TextStyle(color: primaryTextColor, fontWeight: FontWeight.w600)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('الفرق: ${center['teams']}', style: TextStyle(color: secondaryTextColor, fontSize: 12)),
                  Text('استجاب: ${center['completed']}', style: TextStyle(color: secondaryTextColor, fontSize: 12)),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );

    return Card(
      color: cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'حالة مراكز الإسعاف',
              style: TextStyle(color: primaryTextColor, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // إضافة Expanded و SingleChildScrollView لجعل محتوى المراكز قابلاً للتمرير عمودياً
            Expanded(
              child: SingleChildScrollView(
                child: content,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildStatusChip(String status, Color secondaryTextColor) {
    Color color;
    Color textColor;
    switch (status) {
      case 'في الطريق':
        color = Colors.blue.withOpacity(0.1);
        textColor = Colors.blue;
        break;
      case 'وصول':
        color = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        break;
      case 'عودة':
        color = Colors.yellow.withOpacity(0.1);
        textColor = Colors.amber.shade800;
        break;
      default:
        color = secondaryTextColor.withOpacity(0.1);
        textColor = secondaryTextColor;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
