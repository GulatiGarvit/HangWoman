import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                "MEET THE TEAM",
                style: TextStyle(fontFamily: 'Rockwell', fontSize: 30),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/garvit.png'),
                  radius: MediaQuery.of(context).size.width / 8,
                ),
              ),
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Garvit Gulati",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: () {
                            launchUrl(
                                Uri.parse(
                                    'https://www.linkedin.com/in/garvit-gulati-5790a7213/'),
                                mode: LaunchMode.externalNonBrowserApplication);
                          },
                          child: Image.asset(
                            'assets/images/linkedin_icon.png',
                            height: 15,
                            width: 15,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          launchUrl(
                              Uri.parse(
                                  'https://www.linkedin.com/in/ishita-g-34b1b925a/'),
                              mode: LaunchMode.externalNonBrowserApplication);
                        },
                        child: Image.asset(
                          'assets/images/linkedin_icon.png',
                          height: 15,
                          width: 15,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Ishita",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/ishita.jpg'),
                  radius: MediaQuery.of(context).size.width / 8,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Contact us: ',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse('mailto:teamescapecharacter@gmail.com'),
                      mode: LaunchMode.externalNonBrowserApplication);
                },
                child: Text(
                  'teamescapecharacter@gmail.com',
                  style: TextStyle(fontSize: 15, color: Colors.blueAccent),
                ),
              )
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  launchUrl(
                      Uri.parse(
                          'https://hangwoman.escapecharacter.co/privacy-policy.html'),
                      mode: LaunchMode.externalNonBrowserApplication);
                },
                child: Text(
                  "Privacy Policy",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
              Text(" | "),
              GestureDetector(
                onTap: () {
                  launchUrl(
                      Uri.parse(
                          'https://hangwoman.escapecharacter.co/tnc.html'),
                      mode: LaunchMode.externalNonBrowserApplication);
                },
                child: Text(
                  "Terms and Conditions",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
        ],
      )),
    );
  }
}
