import 'package:dash/fitness_dashboard/widgets/dashboard_widget.dart';
import 'package:dash/fitness_dashboard/widgets/side_menu_widget.dart';
import 'package:dash/fitness_dashboard/widgets/summary_widget.dart';
import 'package:dash/utils/responseive.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = Responsive.isDesktop(context);
    bool isMobile = Responsive.isMobile(context);
    return Scaffold(
        drawer: !isDesktop
            ? const Drawer(
                child: SideMenuWidget(),
              )
            : null,
        endDrawer: isMobile
            ? SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: const SummaryWidget(),
              )
            : null,
        body: SafeArea(
            child: Row(
          children: [
            if (isDesktop)
              const Expanded(
                  flex: 2,
                  child: SizedBox(
                    child: SideMenuWidget(),
                  )),
            const Expanded(flex: 7, child: DashboardWidget()),
            if (isDesktop) const Expanded(flex: 3, child: SummaryWidget()),
          ],
        )));
  }
}
