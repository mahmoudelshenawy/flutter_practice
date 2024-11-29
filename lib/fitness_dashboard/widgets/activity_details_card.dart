import 'package:dash/fitness_dashboard/constants/constant.dart';
import 'package:dash/fitness_dashboard/data/health_details.dart';
import 'package:dash/utils/responseive.dart';
import 'package:flutter/material.dart';

class ActivityDetailsCard extends StatelessWidget {
  ActivityDetailsCard({super.key});

  final healthDetails = HealthDetails();
  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: GridView.builder(
          itemCount: healthDetails.healthData.length,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : 4,
              crossAxisSpacing: isMobile ? 12 : 15,
              mainAxisSpacing: 12),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  color: cardBackgroundColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    healthDetails.healthData[index].icon,
                    height: 30,
                    width: 30,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    healthDetails.healthData[index].title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    healthDetails.healthData[index].value,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 13),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
