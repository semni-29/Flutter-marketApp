import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobService {
  static String get interstitialAdUnitId => 'ca-app-pub-6988072973986440/9869087864'; // 전면광고단위_ID
  static String get bannerAdUnitId => 'ca-app-pub-6988072973986440/7038926305';       // 배너광고단위_ID
  static String get rewardAdUnitId => 'ca-app-pub-6988072973986440/4817213379';       // 보상형광고단위_ID

  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  BannerAd? _bannerAd;

  void createInterstitialAd() { // 전면 광고 만들기
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitialAd = ad,
        onAdFailedToLoad: (error) => print('InterstitialAd failed to load: $error'),
      ),
    );
  }

  void createRewardAd() { //보상형 광고 만들기
    RewardedAd.load(
      adUnitId: rewardAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
        },
        onAdFailedToLoad: (error) => print('RewardedVideoAd failed to load: $error'),
      ),
    );
  }

  void showRewardAd(VoidCallback callback){
    if(_rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (ad,reward) {
              callback.call();
        },
      );
    }
  }

  void showAd() {
    if (_interstitialAd == null) return;
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) => ad.dispose(),
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        print('Admob error: $error');
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  Widget showAdBanner() {
    _bannerAd = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) => print('Admob banner loaded.'),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('Admob banner failed to load: $error');
        },
      ),
    )..load();
    return Container(
      alignment: Alignment.center,
      child: AdWidget(ad: _bannerAd!),
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
    );
  }
}