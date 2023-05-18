import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAdMob {
  // 배너 광고 인스턴스를 생성하고 로딩하기 위한 함수
  static BannerAd loadBannerAd() {
    // 배너 광고
    BannerAd myBanner = BannerAd(
      // Test 광고 ID, 광고 승인받은 후 생성한 광고 unit ID 로 바꾸기
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111' // Android ad unit ID
          : 'ca-app-pub-3940256099942544/2934735716', // iOS ad unit ID
      /*
      크기(폭x높이)        설명               AdSize 상수
      -----------------------------------------------------------------------
      320x50	            표준 배너	          banner
      320x100	            대형 배너	          largeBanner
      320x250	            중간 직사각형	      mediumRectangle
      468x60	            전체 크기 배너	    fullBanner
      728x90	            리더보드	          leaderboard
      화면 폭x32|50|90	  스마트 배너	        getSmartBanner(Orientation) 사용
      */
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        // 광고가 성공적으로 수신된 경우
        onAdLoaded: (Ad ad) => print('Ad loaded.'),
        // 광고 요청이 실패한 경우
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // 광고 요청 오류 시 광고를 삭제하여 리소스 확보
          ad.dispose();
          print('Ad failed to load: $error');
        },
        // 광고가 화면을 덮는 오버레이를 열었을 때 호출
        // 사용자가 광고를 클릭하거나 특정 조건이 충족되어 광고가 표시 될 때 발생
        onAdOpened: (Ad ad) => print('Ad opened.'),
        // 광고가 화면을 덮는 오버레이를 닫았을 때 호출
        // 사용자가 광고를 닫거나 자동으로 닫힐 때 발생
        onAdClosed: (Ad ad) => print('Ad closed.'),
        // 광고가 노출 될 때 호출
        // 광고가 사용자에게 보여질 때 발생
        onAdImpression: (Ad ad) => print('Ad impression.'),
      ),
    );
    return myBanner;
  }

  // 배너 광고를 화면에 보여주기 위한 함수, 파라미터로 로드된 배너 인스턴스 필요
  static Container showBannerAd(BannerAd myBanner) {
    // 광고 디스플레이
    // 배너 광고를 위젯으로 표시하기 위해 지원되는 광고를 사용하여 AdWidget 인스턴스화
    final Container adContainer = Container(
      alignment: Alignment.center,
      width: myBanner.size.width.toDouble(),
      height: myBanner.size.height.toDouble(),
      child: AdWidget(ad: myBanner),
    );

    return adContainer;
  }

  // 전면 광고를 인스턴스를 생성하고 로딩하기 위한 함수
  static void showInterstitialAd() {
    // 전면 광고 로드
    InterstitialAd.load(
      // Test 광고 ID, 광고 승인받은 후 생성한 광고 unit ID 로 바꾸기
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/1033173712' // Android ad unit ID
          : 'ca-app-pub-3940256099942544/4411468910', // iOS ad unit ID
      // ? 'ca-app-pub-3940256099942544/8691691433' // Android ad unit ID (Video)
      // : 'ca-app-pub-3940256099942544/5135589807' // iOS ad unit ID (Video)
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        // 전면 광고 로드 완료
        onAdLoaded: (InterstitialAd ad) {
          // 광고 보여주기
          ad.show();
          // 리소스 해제
          ad.dispose();
        },
        // 전면 광고 로드 실패
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  static void showRewardedAd() async {
    await RewardedInterstitialAd.load(
      // Test 광고 ID, 광고 승인받은 후 생성한 광고 unit ID 로 바꾸기
      adUnitId: Platform.isAndroid
          // ? 'ca-app-pub-3940256099942544/5224354917' // Android ad unit ID
          // : 'ca-app-pub-3940256099942544/1712485313', // iOS ad unit ID
          ? 'ca-app-pub-3940256099942544/5354046379' // Android ad unit ID (Interstitial)
          : 'ca-app-pub-3940256099942544/6978759866', // iOS ad unit ID (Interstitial)
      request: AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        // 보상 광고 로드 완료
        onAdLoaded: (rewardedAd) {
          rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
            // 광고가 표시 될 때 호출
            onAdShowedFullScreenContent: (ad) =>
                print('$ad onAdShowedFullScreenContent.'),
            // 광고가 닫힐 때 호출
            onAdDismissedFullScreenContent: (ad) {
              print('$ad onAdDismissedFullScreenContent.');
              // 광고 리소스 해제
              ad.dispose();
            },
            // 광고가 표시되지 못했을 때의 호출, 오류 정보 제공
            onAdFailedToShowFullScreenContent: (ad, AdError error) {
              print('$ad onAdFailedToShowFullScreenContent: $error');
              ad.dispose();
            },
            // 광고가 노출되었을 때 호출
            onAdImpression: (ad) => print('$ad impression occurred.'),
          );
          // 광고 보여주기
          rewardedAd.show(
            onUserEarnedReward: (ad, reward) {
              // 광고 보상 지급 코드
            },
          );
        },
        // 보상 광고 로드 실패
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
        },
      ),
    );
  }
}
