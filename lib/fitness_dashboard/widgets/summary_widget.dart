import 'package:dash/fitness_dashboard/constants/constant.dart';
import 'package:dash/fitness_dashboard/widgets/pie_chart_widget.dart';
import 'package:dash/fitness_dashboard/widgets/schedule_widget.dart';
import 'package:dash/fitness_dashboard/widgets/summary_details_widget.dart';
import 'package:flutter/material.dart';

class SummaryWidget extends StatelessWidget {
  const SummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: backgroundColor),
      child: const Column(
        children: [
          SizedBox(
            height: 20,
          ),
          PieChartWidget(),
          Text(
            "Summary",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: SummaryDetails(),
          ),
          SizedBox(
            height: 20,
          ),
          ScheduleWidget()
        ],
      ),
    );
  }
}
