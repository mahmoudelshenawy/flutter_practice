import 'package:flutter/material.dart';

class OnboardingCard extends StatelessWidget {
  final String imageName, title, description, buttonText;
  final Function onPressed;

  OnboardingCard(
      {super.key,
      required this.imageName,
      required this.title,
      required this.description,
      required this.buttonText,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .80,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Image.asset(
              imageName,
              fit: BoxFit.contain,
            ),
          ),
          Column(
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  description,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey[800]),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          MaterialButton(
            onPressed: () {
              onPressed(context);
            },
            color: Theme.of(context).primaryColor,
            minWidth: 300,
            child: Text(
              buttonText,
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
