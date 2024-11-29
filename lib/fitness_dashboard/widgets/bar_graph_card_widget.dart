import 'package:dash/fitness_dashboard/constants/constant.dart';
import 'package:dash/fitness_dashboard/data/bar_graph_data.dart';
import 'package:dash/fitness_dashboard/models/graph_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarGraphCardWidget extends StatelessWidget {
  const BarGraphCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final barGraphData = BarGraphData();
    return Container(
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: barGraphData.data.length,
          physics: ScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 15,
            childAspectRatio: 5 / 4,
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                  color: cardBackgroundColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(barGraphData.data[index].label),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Expanded(
                      child: BarChart(
                        BarChartData(
                            barGroups: _barChartGroups(
                              points: barGraphData.data[index].graph,
                              color: barGraphData.data[index].color,
                            ),
                            borderData: FlBorderData(
                              border: const Border(),
                            ),
                            gridData: const FlGridData(show: false),
                            titlesData: FlTitlesData(
                                topTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                rightTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                leftTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    return Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text(
                                        barGraphData.label[value.toInt()],
                                        style: const TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    );
                                  },
                                )))),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  List<BarChartGroupData> _barChartGroups(
      {required List<GraphModel> points, required Color color}) {
    return points
        .map((point) => BarChartGroupData(x: point.x.toInt(), barRods: [
              BarChartRodData(
                toY: point.y,
                width: 12,
                color: color.withOpacity(point.y > 4 ? 1 : 0.5),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(3),
                  topLeft: Radius.circular(3),
                ),
              )
            ]))
        .toList();
  }
}
