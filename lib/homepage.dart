import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hangwoman/utils.dart';

class HomePage extends StatefulWidget {
  int length;
  HomePage(this.length) {}
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isToastVisible = false;
  final totalHearts = 5;
  String word = "";
  String meaning = "";
  String current = "Loading...";
  String eliminated = "";
  Characters? options;
  int score = 0;
  var widgetOptions = <Widget>[];
  var noOfHearts;
  var hearts = "";

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
                    //onTap: loadAd,
                    onTap: () =>
                        showLevelEndDialog(context, score, word, meaning, () {
                      Navigator.pop(context);
                    }, () {
                      doTheMagic();
                    }, won: true),
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
                textAlign: TextAlign.center,
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
    word = await generateWord(widget.length);
    meaning = await getMeaning(word);
    word = word.toUpperCase();
    current = calculateInitDisplay(word);
    eliminated = "";
    options = generateOptions(word, current, eliminated);
    noOfHearts = totalHearts;
    hearts = getHearts(noOfHearts);
    widgetOptions = generateWidgets(options!, handleOptionSelection);
    setState(() {});
  }

  void handleOptionSelection(String alphabet) {
    print(alphabet);
    if (word.contains(alphabet)) {
      print("Contains");
      current = reveal(word, current, alphabet);
    } else {
      if (!isToastVisible) {
        isToastVisible = true;
        Fluttertoast.showToast(msg: "Wrong guess!")
            .then((value) => isToastVisible = false);
      }

      eliminated += alphabet;
      decreaseHearts();
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
    setState(() {
      widgetOptions = <Widget>[];
      widgetOptions.add(
        Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
    doTheMagic();
  }

  RewardedAd? _rewardedAd;

  // TODO: replace this test ad unit with your own ad unit.
  final adUnitId = 'ca-app-pub-6565607987571439/2269242320';

  /// Loads a rewarded ad.
  void loadAd() {
    showLoaderDialog(context);
    bool rewardEarned = false;
    RewardedAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            Navigator.pop(context);
            _rewardedAd = ad;
            ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdWillDismissFullScreenContent: (ad) {
                  Fluttertoast.showToast(
                      msg: "onAdWillDismissFullScreenContent");
                },
                onAdShowedFullScreenContent: (ad) {},
                onAdImpression: (ad) {},
                onAdFailedToShowFullScreenContent: (ad, err) {
                  ad.dispose();
                },
                onAdDismissedFullScreenContent: (ad) {
                  if (rewardEarned) {
                    rewardEarned = false;
                    var toReveal = remaining(word, current);
                    current = reveal(word, current, toReveal);
                    if (current.replaceAll(" ", "") == word) {
                      wordGuessed();
                    } else {
                      options = generateOptions(word, current, eliminated);
                      widgetOptions =
                          generateWidgets(options!, handleOptionSelection);
                      Fluttertoast.showToast(msg: "Revealed: $toReveal");
                    }
                    setState(() {});
                  }
                  ad.dispose();
                },
                onAdClicked: (ad) {});
            _rewardedAd!.setImmersiveMode(true);
            _rewardedAd!.show(
              onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
                rewardEarned = true;
                print(
                    '$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
              },
            );
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedAd failed to load: $error');
          },
        ));
  }

  void decreaseHearts() {
    noOfHearts -= 1;
    hearts = getHearts(noOfHearts);
    print(noOfHearts);
    print(hearts);
    setState(() {});
    if (noOfHearts == 0) {
      Fluttertoast.showToast(msg: "Level lost!");
      score = 0;
      setState(() {
        widgetOptions = <Widget>[];
        widgetOptions.add(
          Center(
            child: CircularProgressIndicator(),
          ),
        );
      });
      doTheMagic();
    }
  }

  String getHearts(int n) {
    String s = "";
    for (int i = 0; i < n; i++) {
      s += "❤";
    }
    return s;
  }
}
