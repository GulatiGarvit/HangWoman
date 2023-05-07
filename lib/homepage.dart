import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hangwoman/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String word = "";
  String current = "";
  String eliminated = "";
  Characters? options;
  int score = 0;
  var widgetOptions = <Widget>[];
  var noOfHearts = 5;
  var hearts = "❤❤❤❤❤";

  @override
  void initState() {
    super.initState();
    doTheMagic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(26, 0, 26, 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    child: Text(
                      "$score",
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: loadAd,
                    child: Container(
                      child: Image.asset('assets/images/bulb_icon.png'),
                      height: 50,
                      width: 50,
                    ),
                  ),
                ],
              ),
              Image.asset(
                "assets/gifs/Kfde.gif",
                height: 300,
                width: 300,
              ),
              Text(
                hearts,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 36,
              ),
              Text(
                current,
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Column(
                children: widgetOptions,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getOptions() {
    var list = <Widget>[];

    return list;
  }

  void doTheMagic() async {
    noOfHearts = 5;
    hearts = "❤❤❤❤❤";
    word = await generateWord(4 + Random().nextInt(4));
    word = word.toUpperCase();
    current = calculateInitDisplay(word);
    options = generateOptions(word, current, eliminated);
    widgetOptions = generateWidgets(options!, handleOptionSelection);
    setState(() {});
  }

  void handleOptionSelection(String alphabet) {
    print(alphabet);
    if (word.contains(alphabet)) {
      print("Contains");
      current = reveal(word, current, alphabet);
    } else {
      Fluttertoast.showToast(
          msg: "Galat Jawab!", toastLength: Toast.LENGTH_SHORT);
      eliminated += alphabet;
      heartsToShow();
    }
    if (current.replaceAll(" ", "") != word) {
      options = generateOptions(word, current, eliminated);
      widgetOptions = generateWidgets(options!, handleOptionSelection);
    } else {
      wordGuessed();
    }
    setState(() {});
  }

  void wordGuessed() {
    Fluttertoast.showToast(msg: "Yay! The word was: $word");
    score += word.length;
    setState(() {});
    doTheMagic();
  }

  RewardedAd? _rewardedAd;

  // TODO: replace this test ad unit with your own ad unit.
  final adUnitId = 'ca-app-pub-6565607987571439/2269242320';

  /// Loads a rewarded ad.
  void loadAd() {
    RewardedAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _rewardedAd = ad;
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {
                  var toReveal = remaining(word, current);
                  current = reveal(word, current, toReveal);
                },
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedAd failed to load: $error');
          },
        ));
  }

  void heartsToShow() {
    noOfHearts -= 1;
    hearts = hearts.substring(0, noOfHearts);
    print(noOfHearts);
    print(hearts);
    setState(() {});
    if (noOfHearts == 0) {
      Fluttertoast.showToast(msg: "Level lost!");
      doTheMagic();
    }
  }
}
