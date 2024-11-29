import 'package:dash/fitness_dashboard/constants/constant.dart';
import 'package:dash/fitness_dashboard/data/side_menu_data.dart';
import 'package:flutter/material.dart';

class SideMenuWidget extends StatefulWidget {
  const SideMenuWidget({super.key});

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  final data = SideMenuData();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: cardBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 10),
      child: ListView.builder(
          itemCount: data.menu.length,
          itemBuilder: (context, index) => sideMenuItem(data, index)),
    );
  }

  Widget sideMenuItem(SideMenuData data, int index) {
    bool isSelected = selectedIndex == index;
    return Container(
      decoration: BoxDecoration(
          color: isSelected ? selectionColor : Colors.transparent,
          borderRadius: BorderRadius.circular(6)),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          child: Row(
            children: [
              Icon(
                data.menu[index].icon,
                color: isSelected ? Colors.black : Colors.grey,
              ),
              Text(
                data.menu[index].title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: isSelected ? Colors.black : Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
