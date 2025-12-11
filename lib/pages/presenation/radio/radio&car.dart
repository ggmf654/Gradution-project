// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers, deprecated_member_use, prefer_interpolation_to_compose_strings, use_build_context_synchronously, unused_element_parameter, file_names, unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'dart:math';
// استدعاء ملف الثوابت الجديد
import 'package:ems_op_room/core/app_themes.dart';
import 'package:ems_op_room/core/app_colors.dart';
// ====================================================================
// نقطة إدخال التطبيق (تمت إضافتها لتشغيل الكود)
// ====================================================================

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    // نعتمد هنا على الثيمات المدمجة في Flutter لكن نستخدم primarySwatch
    return MaterialApp(
      title: 'Radiocar Dashboard',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        // يمكن تخصيص الثيم باستخدام الألوان من lightThemeData إذا لزم الأمر
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        // يمكن تخصيص الثيم باستخدام الألوان من darkThemeData إذا لزم الأمر
        primarySwatch: Colors.blue,
      ),
      // مُغَلِّف لإضافة زر تبديل الثيم
      home: RadiocarWrapper(
        themeMode: _themeMode,
        onThemeChanged: _toggleTheme,
      ),
    );
  }
}

// مُغَلِّف لإضافة زر تبديل الثيم
class RadiocarWrapper extends StatelessWidget {
  final ThemeMode themeMode;
  final Function(ThemeMode) onThemeChanged;

  const RadiocarWrapper({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // المكون الرئيسي للوحة التحكم
        Radiocar(themeMode: themeMode),
        
        // زر تبديل الثيم في الزاوية العلوية اليسرى (للتجربة)
        Positioned(
          top: 50,
          left: 20,
          child: FloatingActionButton(
            heroTag: 'theme_toggle',
            backgroundColor: Colors.white,
            onPressed: () {
              final newMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
              onThemeChanged(newMode);
            },
            child: Icon(
              themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}

// ====================================================================
// 2. Radiocar Class 
// ====================================================================
class Radiocar extends StatefulWidget {
  final ThemeMode? themeMode; 

  const Radiocar({
    super.key, 
    this.themeMode, 
  });

  @override
  State<Radiocar> createState() => _RadiocarState();
}

class _RadiocarState extends State<Radiocar> {
  late ThemeMode _currentThemeMode;
  late List<Map<String, dynamic>> _missions;
  late final AppThemeData _lightAppThemeData;
  late final AppThemeData _darkAppThemeData;
  final Random _random = Random(); // Initialize Random once

  // ====================================================================
  // 3. Initialization and Theme Update Logic
  // ====================================================================
  @override
  void initState() {
    super.initState();
    _currentThemeMode = widget.themeMode ?? ThemeMode.light;
    _missions = _generateRandomMissions(20);

    _lightAppThemeData = const AppThemeData(
      primaryTextColor: Colors.black87,
      secondaryTextColor: Colors.grey,
      primaryColor: Colors.blue,
      cardColor: Colors.white,
      backgroundColor: Color(0xFFF5F5F5),
      headerColor: Colors.blue,
      inputFillColor: Colors.white,
    );

    _darkAppThemeData = const AppThemeData(
      primaryTextColor: Colors.white,
      secondaryTextColor: Colors.white70,
      primaryColor: Colors.blue,
      cardColor: Color(0xFF424242),
      backgroundColor: Color(0xFF303030),
      headerColor: Color(0xFF212121),
      inputFillColor: Color(0xFF616161),
    );
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // الطريقة الأفضل والأكثر موثوقية للحصول على الثيم الحالي للتطبيق
    _currentThemeMode = Theme.of(context).brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
  }


  @override
  void didUpdateWidget(covariant Radiocar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.themeMode != widget.themeMode && widget.themeMode != null) {
      setState(() {
        _currentThemeMode = widget.themeMode!;
      });
    } else {
      // If themeMode is null or hasn't changed, rely on didChangeDependencies for system theme changes
      didChangeDependencies();
    }
  }

  // ====================================================================
  // 4. Logic: Random Mission Generation 
  // ====================================================================
  String _randomTime() {
    if (_random.nextDouble() < 0.2) return ''; 
    final h = _random.nextInt(15) + 8; 
    final m = _random.nextInt(60);
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
  }

  List<Map<String, dynamic>> _generateRandomMissions(int count) {
    final names = ['خالد المحمد', 'فاطمة العلي', 'محمد السعيد', 'نورة اليوسف', 'علياء حسين', 'باسم زكي'];
    final statuses = ['Red', 'Yellow', 'Green'];
    final teamLeaders = ['خالد', 'فاطمة', 'علي', 'نورة'];
    final hospital = ['مشفى الشام', 'الرازي', 'الأمل', 'الجامعي'];
    final reasons = ['رفض المريض التام للانتقال', 'تم تأكيد الوفاة في الموقع', 'عدم توفر سرير'];
    
    return List.generate(count, (index) {
      final didTransfer = _random.nextBool(); 
      final status = statuses[_random.nextInt(statuses.length)];
      
      String transferStatus = didTransfer ? 'تم النقل' : 'لم يتم النقل';
      String hospitalName = didTransfer ? hospital[_random.nextInt(hospital.length)] : '';
      String reason = !didTransfer ? reasons[_random.nextInt(reasons.length)] : '';

      return {
        'id': 'M${100 + index}',
        'name': names[_random.nextInt(names.length)] + ' (${index + 1})', 
        'status': status, 
        'center': (100 + _random.nextInt(30)).toString(), 
        'code': (100 + _random.nextInt(99)).toString(),
        'teamLeader': teamLeaders[_random.nextInt(teamLeaders.length)],
        'toPatientTime': _randomTime(),
        'atPatientTime': _randomTime(),
        'toHospitalTime': didTransfer ? _randomTime() : '',
        'atHospitalTime': didTransfer ? _randomTime() : '',
        'toCenterTime': _randomTime(),
        'atCenterTime': _randomTime(),
        'hospital': hospitalName, 
        'reasonForNoTransfer': reason, 
        'transferStatus': transferStatus, 
      };
    });
  }

  // ====================================================================
  // 5. Main Build Method
  // ====================================================================

  @override
  Widget build(BuildContext context) {
    // تحديد الألوان والثيم بالاعتماد على _currentThemeMode
    final isDarkMode = _currentThemeMode == ThemeMode.dark;
    
    // استدعاء الثيم المخصص من الملف الخارجي
    final AppThemeData themeData = isDarkMode ? _darkAppThemeData : _lightAppThemeData;

    final primaryTextColor = themeData.primaryTextColor;
    final cardColor = themeData.cardColor;
    final backgroundColor = themeData.backgroundColor;

    final missionCounts = _calculateMissionCounts();
    final isLargeScreen = MediaQuery.of(context).size.width > 1200;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          // شريط العنوان العلوي
          _HeaderBar(
            themeData: themeData,
            missionCounts: missionCounts,
            isLargeScreen: isLargeScreen,
          ),
          
          // المحتوى الرئيسي القابل للتمرير
          Expanded( 
            child: SingleChildScrollView( 
              padding: const EdgeInsets.all(20.0),
              child: Center( // استخدام Center لتركيز المحتوى في الشاشات الكبيرة
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1600), // تحديد أقصى عرض
                  child: Column(
                    children: [
                      // بطاقة المهام
                      Card(
                        color: cardColor,
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: _missions.map((mission) {
                              return _MissionRow(
                                mission: mission,
                                primaryTextColor: primaryTextColor,
                                primaryColor: themeData.primaryColor,
                                inputFillColor: themeData.inputFillColor,
                                themeData: themeData, // تمرير بيانات الثيم المخصصة
                                // دالة تحديث البيانات 
                                onUpdate: (missionId, key, value) {
                                  final missionIndex = _missions.indexWhere((m) => m['id'] == missionId);
                                  if (missionIndex != -1) {
                                    setState(() {
                                      _missions[missionIndex][key] = value;
                                    });
                                  }
                                }
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      // زر عرض جميع المهام
                      SizedBox(
                        width: isLargeScreen ? 600 : double.infinity,
                        child: ElevatedButton(
                          onPressed: () => print('View All Missions'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: themeData.headerColor, // استخدام لون الهيدر من الثيم
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text(
                            'عرض جميع المهام',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ====================================================================
  // 6. Logic Helper 
  // ====================================================================
  Map<String, int> _calculateMissionCounts() {
    return _missions.fold({'Red': 0, 'Yellow': 0, 'Green': 0}, (Map<String, int> acc, mission) {
      final status = mission['status'] as String;
      if (acc.containsKey(status)) {
        acc[status] = acc[status]! + 1;
      }
      return acc;
    });
  }
}

// ====================================================================
// 7. Component: Header Bar 
// ====================================================================
class _HeaderBar extends StatelessWidget {
  // استخدام AppThemeData مباشرة
  final AppThemeData themeData; 
  final Map<String, int> missionCounts;
  final bool isLargeScreen;

  const _HeaderBar({
    required this.themeData,
    required this.missionCounts,
    required this.isLargeScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeData.headerColor,
        boxShadow: [
          // تحديث لون الظل ليتناسب مع الثيم
          BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 10),
        ],
      ),
      child: SafeArea( // إضافة SafeArea للتعامل مع النوتش وشريط الحالة
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // شعار وعنوان
            Row(
              children: [
                const Icon(Icons.medical_information), 
                const SizedBox(width: 8),
                const Text(
                  'Car traffic', // تم تعديل العنوان ليكون باللغة العربية
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            
            // إحصائيات المهام
            if (isLargeScreen)
              Row(
                children: [
                  _buildMissionCountChip('Red', missionCounts['Red']!, Colors.red),
                  const SizedBox(width: 15),
                  _buildMissionCountChip('Yellow', missionCounts['Yellow']!, Colors.amber),
                  const SizedBox(width: 15),
                  _buildMissionCountChip('Green', missionCounts['Green']!, Colors.green),
                ],
              ),

            // الإجراءات
            ElevatedButton(
              onPressed: () => print('Add New Mission'),
              style: ElevatedButton.styleFrom(
                backgroundColor: themeData.primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              child: const Text('إضافة مهمة جديدة', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  // بناء شريحة عداد المهام
  Widget _buildMissionCountChip(String status, int count, Color color) {
    return Row(
      children: [
        Text(
          status,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 4),
        Icon(Icons.circle, color: color, size: 10),
        const SizedBox(width: 4),
        Text(
          '$count',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

// ====================================================================
// 8. Component: Mission Row 
// ====================================================================
class _MissionRow extends StatelessWidget {
  final Map<String, dynamic> mission;
  final Color primaryTextColor;
  final Color primaryColor;
  final Color inputFillColor; 
  final Function(String missionId, String key, String value) onUpdate;
  final AppThemeData themeData; // تم تغييرها لاستقبال بيانات الثيم المخصصة

  const _MissionRow({
    required this.mission,
    required this.primaryTextColor,
    required this.primaryColor,
    required this.inputFillColor,
    required this.onUpdate,
    required this.themeData, // تم تغييرها
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Red': return Colors.red;
      case 'Yellow': return Colors.amber;
      case 'Green': return Colors.green;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(mission['status'] as String);
    // الآن يمكننا الوصول إلى secondaryTextColor مباشرة من themeData
    final secondaryTextColor = themeData.secondaryTextColor; 
    
    // تصميم الرأس (اسم المريض والحالة)
    final header = Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          // اسم المريض
          Expanded(
            child: Text(
              mission['name'] as String,
              style: TextStyle(color: primaryTextColor, fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right, // لغة عربية
            ),
          ),
          const SizedBox(width: 20),
          // زر الإنهاء
          SizedBox(
            width: 80,
            child: ElevatedButton(
              onPressed: () => print('End mission ${mission['id']}'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700, 
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              child: const Text('إنهاء', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );

    // قائمة حقول التفاصيل والأوقات
    final List<Widget> details = [
      // الحالة
      _DetailColumn(label: 'حالة المهمة', value: mission['status'] as String, primaryTextColor: primaryTextColor, secondaryTextColor: secondaryTextColor, valueColor: statusColor, width: 100),
      
      // المركز 
      _DetailColumn(label: 'مركز الاستجابة', value: mission['center'] as String, primaryTextColor: primaryTextColor, secondaryTextColor: secondaryTextColor, width: 100),
      
      // رمز الإسعاف (قابل للتعديل)
      _EditableDetailColumn(
        label: 'رمز الإسعاف',
        keyName: 'code',
        initialValue: mission['code'] as String,
        missionId: mission['id'] as String,
        onUpdate: onUpdate,
        primaryTextColor: primaryTextColor,
        secondaryTextColor: secondaryTextColor,
        inputFillColor: inputFillColor,
        width: 100,
      ),
      
      // قائد الفريق (قابل للتعديل)
      _EditableDetailColumn(
        label: 'قائد الفريق',
        keyName: 'teamLeader',
        initialValue: mission['teamLeader'] as String,
        missionId: mission['id'] as String,
        onUpdate: onUpdate,
        primaryTextColor: primaryTextColor,
        secondaryTextColor: secondaryTextColor,
        inputFillColor: inputFillColor,
        width: 110,
      ),
      
      // ================== حقول تسجيل الأوقات (Time Input Columns) ==================
      // 1. انطلاق إلى المريض
      _TimeInputColumn(
        label: 'انطلاق (مريض)',
        timeKey: 'toPatientTime',
        initialValue: mission['toPatientTime'] as String,
        missionId: mission['id'] as String,
        onTimeUpdate: onUpdate,
        primaryTextColor: primaryTextColor,
        secondaryTextColor: secondaryTextColor,
        inputFillColor: inputFillColor,
        width: 110,
      ),
      // 2. وصول للمريض
      _TimeInputColumn(
        label: 'وصول (مريض)',
        timeKey: 'atPatientTime',
        initialValue: mission['atPatientTime'] as String,
        missionId: mission['id'] as String,
        onTimeUpdate: onUpdate,
        primaryTextColor: primaryTextColor,
        secondaryTextColor: secondaryTextColor,
        inputFillColor: inputFillColor,
        width: 110,
      ),
      // 3. انطلاق إلى المشفى
      _TimeInputColumn(
        label: 'انطلاق (مشفى)',
        timeKey: 'toHospitalTime',
        initialValue: mission['toHospitalTime'] as String,
        missionId: mission['id'] as String,
        onTimeUpdate: onUpdate,
        primaryTextColor: primaryTextColor,
        secondaryTextColor: secondaryTextColor,
        inputFillColor: inputFillColor,
        width: 110,
      ),
      // 4. وصول مشفى
      _TimeInputColumn(
        label: 'وصول (مشفى)',
        timeKey: 'atHospitalTime',
        initialValue: mission['atHospitalTime'] as String,
        missionId: mission['id'] as String,
        onTimeUpdate: onUpdate,
        primaryTextColor: primaryTextColor,
        secondaryTextColor: secondaryTextColor,
        inputFillColor: inputFillColor,
        width: 110,
      ),
      // 5. عودة باتجاه المركز
      _TimeInputColumn(
        label: 'انطلاق (مركز)',
        timeKey: 'toCenterTime',
        initialValue: mission['toCenterTime'] as String,
        missionId: mission['id'] as String,
        onTimeUpdate: onUpdate,
        primaryTextColor: primaryTextColor,
        secondaryTextColor: secondaryTextColor,
        inputFillColor: inputFillColor,
        width: 110,
      ),
      // 6. وصول مركز
      _TimeInputColumn(
        label: 'وصول (مركز)',
        timeKey: 'atCenterTime',
        initialValue: mission['atCenterTime'] as String,
        missionId: mission['id'] as String,
        onTimeUpdate: onUpdate,
        primaryTextColor: primaryTextColor,
        secondaryTextColor: secondaryTextColor,
        inputFillColor: inputFillColor,
        width: 110,
      ),
      // =======================================================================
      
      // ** حقول النقل والمشفى **

      // 7. حالة النقل (Selectable)
      _SelectableDetailColumn(
        label: 'حالة النقل',
        keyName: 'transferStatus',
        initialValue: mission['transferStatus'] as String,
        missionId: mission['id'] as String,
        onUpdate: onUpdate,
        primaryTextColor: primaryTextColor,
        secondaryTextColor: secondaryTextColor,
        inputFillColor: inputFillColor,
        options: const ['تم النقل', 'لم يتم النقل'], 
        width: 120, 
      ),

  
      
      // 9. سبب عدم النقل (Editable)
      // شرط العرض
      mission['transferStatus'] == 'لم يتم النقل' ?    _EditableDetailColumn(
          label: 'سبب عدم النقل',
          keyName: 'reasonForNoTransfer', 
          initialValue: mission['reasonForNoTransfer'] as String,
          missionId: mission['id'] as String,
          onUpdate: onUpdate,
          primaryTextColor: primaryTextColor,
          secondaryTextColor: secondaryTextColor,
          inputFillColor: inputFillColor,
          width: 200, 
        )
      :    // 8. المشفى (Editable)
      _EditableDetailColumn(
        label: 'المشفى',
        keyName: 'hospital',
        initialValue: mission['hospital'] as String,
        missionId: mission['id'] as String,
        onUpdate: onUpdate,
        primaryTextColor: primaryTextColor,
        secondaryTextColor: secondaryTextColor,
        inputFillColor: inputFillColor,
        width: 120, 
      )];// استخدام ...[ ] لإضافة عناصر متعددة بشكل شرطي
    
    

    return Container(
      margin: const EdgeInsets.only(bottom: 25, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end, // لغة عربية
        children: [
          header,
          // استخدام LayoutBuilder لجعل صفوف المهام تتكيف مع حجم الشاشة
          LayoutBuilder(
            builder: (context, constraints) {
              
              if (constraints.maxWidth < 1300) {
                return Wrap(
                  spacing: 15.0, 
                  runSpacing: 15.0, 
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.end, // لغة عربية
                  textDirection: TextDirection.rtl, // لغة عربية
                  children: details,
                );
              }
              
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // لغة عربية
                crossAxisAlignment: CrossAxisAlignment.start,
                children: details,
              );
            },
          ),
          Divider(color: secondaryTextColor.withOpacity(0.3)),
        ],
      ),
    );
  }
}

// ====================================================================
// 9. Sub-Components (Detailed Widgets)
// ====================================================================

// بناء عمود تفاصيل قياسي (للقراءة فقط)
class _DetailColumn extends StatelessWidget {
  final String label;
  final String value;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color? valueColor;
  final double width; 
  
  const _DetailColumn({
    super.key,
    required this.label, 
    required this.value, 
    required this.primaryTextColor, 
    required this.secondaryTextColor,
    this.valueColor,
    this.width = 150, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, 
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end, // لغة عربية
        children: [
          Text(
            label,
            style: TextStyle(color: secondaryTextColor, fontSize: 12),
          ),
          const SizedBox(height: 5),
          Text(
            value.isEmpty ? '-' : value,
            style: TextStyle(color: valueColor ?? primaryTextColor, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

// ====================================================================
// 10. Time Input Column (تم اختصار الكود هنا لتجنب التكرار في الملف الأصلي)
// ====================================================================
// بناء عمود إدخال الوقت (مكون جديد لإكمال متطلبات الكود الأصلي)
class _TimeInputColumn extends StatelessWidget {
  final String label;
  final String timeKey;
  final String initialValue;
  final String missionId;
  final Function(String missionId, String key, String value) onTimeUpdate;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color inputFillColor;
  final double width; 

  const _TimeInputColumn({
    super.key,
    required this.label,
    required this.timeKey,
    required this.initialValue,
    required this.missionId,
    required this.onTimeUpdate,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.inputFillColor,
    this.width = 150,
  });

  // دالة لاختيار الوقت باستخدام واجهة Flutter المدمجة
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialValue.isNotEmpty
          ? TimeOfDay(
              hour: int.parse(initialValue.split(':')[0]),
              minute: int.parse(initialValue.split(':')[1]),
            )
          : TimeOfDay.now(),
      builder: (context, child) {
        // يمكنك تخصيص ثيم TimePicker هنا
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
    );
    if (picked != null) {
      final String formattedTime = 
          '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      onTimeUpdate(missionId, timeKey, formattedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            label,
            style: TextStyle(color: secondaryTextColor, fontSize: 12),
          ),
          const SizedBox(height: 5),
          InkWell(
            onTap: () => _selectTime(context),
            child: Container(
              height: 40,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: inputFillColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                initialValue.isEmpty ? 'تحديد الوقت' : initialValue,
                style: TextStyle(
                  color: initialValue.isEmpty ? secondaryTextColor.withOpacity(0.7) : primaryTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// بناء عمود إدخال قابل للتعديل (حقل نص)
class _EditableDetailColumn extends StatefulWidget {
  final String label;
  final String keyName; 
  final String initialValue;
  final String missionId;
  final Function(String missionId, String key, String value) onUpdate;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color inputFillColor;
  final double width; 

  const _EditableDetailColumn({
    super.key,
    required this.label, 
    required this.keyName,
    required this.initialValue,
    required this.missionId,
    required this.onUpdate,
    required this.primaryTextColor, 
    required this.secondaryTextColor,
    required this.inputFillColor,
    this.width = 150, 
  });

  @override
  State<_EditableDetailColumn> createState() => _EditableDetailColumnState();
}

class _EditableDetailColumnState extends State<_EditableDetailColumn> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant _EditableDetailColumn oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      // تحديث قيمة المتحكم فقط إذا لم يكن المستخدم يكتب حاليًا
      if (_controller.text != widget.initialValue && !FocusScope.of(context).hasFocus) {
          _controller.text = widget.initialValue;
      }
    }
  }

  @override
  void dispose() {
    // تحديث القيمة عند إزالة الـ widget (قد لا يكون هذا السلوك هو الأفضل دائماً، لكنه يحافظ على التغييرات)
    // نعتمد على onSubmitted/onEditingComplete لتحديث الحالة
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width, 
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end, // لغة عربية
        children: [
          Text(
            widget.label,
            style: TextStyle(color: widget.secondaryTextColor, fontSize: 12),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 40,
            child: Directionality( // لغة عربية
              textDirection: TextDirection.rtl,
              child: TextField(
                controller: _controller,
                style: TextStyle(color: widget.primaryTextColor, fontWeight: FontWeight.bold, fontSize: 14),
                textAlign: TextAlign.right, // لغة عربية
                decoration: InputDecoration(
                  hintText: 'أدخل القيمة', // لغة عربية
                  hintStyle: TextStyle(color: widget.secondaryTextColor.withOpacity(0.5), fontSize: 14),
                  filled: true,
                  fillColor: widget.inputFillColor,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                  isDense: true,
                ),
                // يتم استدعاء دالة التحديث عند الانتهاء من الإدخال
                onSubmitted: (value) {
                  widget.onUpdate(widget.missionId, widget.keyName, value.trim());
                },
                onEditingComplete: () {
                  // تحديث القيمة عند الضغط على "تم" أو "التالي"
                  widget.onUpdate(widget.missionId, widget.keyName, _controller.text.trim());
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// بناء عمود قابل للاختيار (قائمة منسدلة)
class _SelectableDetailColumn extends StatelessWidget {
  final String label;
  final String keyName; 
  final String initialValue;
  final String missionId;
  final Function(String missionId, String key, String value) onUpdate;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color inputFillColor;
  final double width; 
  final List<String> options;

  const _SelectableDetailColumn({
    super.key,
    required this.label, 
    required this.keyName,
    required this.initialValue,
    required this.missionId,
    required this.onUpdate,
    required this.primaryTextColor, 
    required this.secondaryTextColor,
    required this.inputFillColor,
    required this.options,
    this.width = 150, 
  });

  @override
  Widget build(BuildContext context) {
    String? currentValue = options.contains(initialValue) ? initialValue : options.first;

    return Container(
      width: width, 
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end, // لغة عربية
        children: [
          Text(
            label,
            style: TextStyle(color: secondaryTextColor, fontSize: 12),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 40,
            child: Directionality( // لغة عربية
              textDirection: TextDirection.rtl,
              child: DropdownButtonFormField<String>(
                value: currentValue,
                isExpanded: true,
                // يجب تحديد لون نص DropdownMenuItem بشكل صريح للعمل مع الثيمات
                style: TextStyle(color: primaryTextColor, fontWeight: FontWeight.bold, fontSize: 14),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: inputFillColor,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                  isDense: true,
                ),
                // لون خلفية القائمة المنسدلة
                dropdownColor: inputFillColor, 
                items: options.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value, 
                      // تحديد لون النص داخل العناصر بشكل صريح لضمان الرؤية
                      style: TextStyle(color: primaryTextColor, fontWeight: FontWeight.bold, fontSize: 14) 
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    onUpdate(missionId, keyName, newValue);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
