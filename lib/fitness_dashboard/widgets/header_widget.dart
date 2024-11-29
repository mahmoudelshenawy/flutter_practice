import 'package:dash/fitness_dashboard/constants/constant.dart';
import 'package:dash/utils/responseive.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = Responsive.isDesktop(context);
    bool isMobile = Responsive.isMobile(context);
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!isDesktop)
            InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: const Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Icon(
                  Icons.menu,
                  size: 25,
                  color: Colors.grey,
                ),
              ),
            ),
          if (!isMobile)
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: cardBackgroundColor,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 6),
                    hintText: "Search",
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 21,
                    )),
              ),
            ),
          if (isMobile)
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    size: 25,
                    color: Colors.grey,
                  ),
                ),
                InkWell(
                  onTap: () => Scaffold.of(context).openEndDrawer(),
                  child: CircleAvatar(
                    child: Image.asset(
                      "images/logo2.png",
                      width: 30,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
