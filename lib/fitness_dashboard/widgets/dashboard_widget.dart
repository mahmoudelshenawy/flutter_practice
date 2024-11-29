import 'package:dash/fitness_dashboard/widgets/activity_details_card.dart';
import 'package:dash/fitness_dashboard/widgets/bar_graph_card_widget.dart';
import 'package:dash/fitness_dashboard/widgets/header_widget.dart';
import 'package:dash/fitness_dashboard/widgets/line_chart_widget.dart';
import 'package:dash/fitness_dashboard/widgets/summary_widget.dart';
import 'package:dash/utils/responseive.dart';
import 'package:flutter/material.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isTable = Responsive.isTablet(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 18,
          ),
          const HeaderWidget(),
          const SizedBox(
            height: 18,
          ),
          ActivityDetailsCard(),
          const SizedBox(
            height: 18,
          ),
          const LineChartWidget(),
          const SizedBox(
            height: 18,
          ),
          const BarGraphCardWidget(),
          const SizedBox(
            height: 18,
          ),
          if (isTable) const SummaryWidget(),
        ],
      ),
    );
  }
}
