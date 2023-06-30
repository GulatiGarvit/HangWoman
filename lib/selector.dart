import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hangwoman/about.dart';
import 'package:hangwoman/constants.dart';
import 'package:hangwoman/homepage.dart';

class SelectorPage extends StatelessWidget {
  const SelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                    return HomePage(Difficulty.easy);
                  }));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color.fromARGB(255, 191, 171, 225),
                  ),
                  width: MediaQuery.of(context).size.width / 1.5,
                  padding: const EdgeInsets.all(16),
                  child: const Center(
                    child: Text(
                      "Easy",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                    return HomePage(Difficulty.medium);
                  }));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color.fromARGB(255, 219, 141, 193),
                  ),
                  width: MediaQuery.of(context).size.width / 1.5,
                  padding: const EdgeInsets.all(16),
                  child: const Center(
                    child: Text(
                      "Medium",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                    return HomePage(Difficulty.hard);
                  }));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color.fromARGB(255, 227, 93, 98),
                  ),
                  width: MediaQuery.of(context).size.width / 1.5,
                  padding: const EdgeInsets.all(16),
                  child: const Center(
                    child: Text(
                      "Advanced",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "Escape Character ",
                        style: TextStyle(fontFamily: 'Rockwell', fontSize: 20),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return AboutPage();
                          }));
                        },
                        child: Icon(Icons.info_sharp)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
