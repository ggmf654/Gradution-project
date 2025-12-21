import 'package:flutter/material.dart';
import 'dashbord_sidebar.dart';
import 'filter_panel.dart';
import 'main_content.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(

        drawer: const DashboardSidebar(),

        body: LayoutBuilder(
          builder: (context, constraints) {
            bool isLargeScreen = constraints.maxWidth > 900;

            if (isLargeScreen) {
              return Row(
                children: [
                  const DashboardSidebar(),
                  Expanded(
                    flex: 4,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20,0,20,20),
                      child: MainContent(),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: FilterPanel(),
                  ),
                ],
              );
            } else {
              return const SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    MainContent(isMobile: true),
                    SizedBox(height: 20),
                    FilterPanel(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
