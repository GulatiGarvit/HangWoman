import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SelectorPage extends StatelessWidget {
  const SelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Color.fromARGB(255, 251, 252, 250),
                ),
                width: MediaQuery.of(context).size.width / 1.5,
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    "Easy",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 36,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Color.fromARGB(255, 251, 252, 250),
                ),
                width: MediaQuery.of(context).size.width / 1.5,
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    "Medium",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 36,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Color.fromARGB(255, 251, 252, 250),
                ),
                width: MediaQuery.of(context).size.width / 1.5,
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    "Advanced",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
