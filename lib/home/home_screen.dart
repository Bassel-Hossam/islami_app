import 'package:flutter/material.dart';
import 'package:islami_app/tabs/hadeeth/hadeeth_tab.dart';
import 'package:islami_app/tabs/quran/quran_tab.dart';
import 'package:islami_app/tabs/radio/radio_tab.dart';
import 'package:islami_app/tabs/sebha/sebha_tab.dart';
import 'package:islami_app/tabs/time/time_tab.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_colors.dart';
import 'package:islami_app/utils/app_theme.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';
  HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabsList = [
    //the arrange is important due to the index
    QuranTab(), HadeethTab(), SebhaTab(), RadioTab(), TimeTab(),
  ];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Image.asset(
          getBackgroundImage(),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ),
        Scaffold(
          backgroundColor: AppColors.transparentColor,
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.primaryColor,
            currentIndex: selectedIndex,
            items: [
              buildBottomNavBarItem(
                index: 0,
                iconSelectedName: AppAssets.iconQuranSelected,
                iconUnSelectedName: AppAssets.iconQuran,
                label: 'َQruan',
              ),
              buildBottomNavBarItem(
                index: 1,
                iconSelectedName: AppAssets.iconHadeethSelected,
                iconUnSelectedName: AppAssets.iconHadeeth,
                label: 'Hadeeth',
              ),
              buildBottomNavBarItem(
                index: 2,
                iconSelectedName: AppAssets.iconSebhaSelected,
                iconUnSelectedName: AppAssets.iconSebha,
                label: 'Sebha',
              ),
              buildBottomNavBarItem(
                index: 3,
                iconSelectedName: AppAssets.iconRadioSelected,
                iconUnSelectedName: AppAssets.iconRadio,
                label: 'Radio',
              ),
              buildBottomNavBarItem(
                index: 4,
                iconSelectedName: AppAssets.iconTimeSelected,
                iconUnSelectedName: AppAssets.iconTime,
                label: 'Time ',
              ),
            ],
          ),
          body: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.Logo, height: height * 0.16),
              Expanded(child: tabsList[selectedIndex]),
            ],
          ),
        ),
      ],
    );
  }

  BottomNavigationBarItem buildBottomNavBarItem({
    required String iconUnSelectedName,
    required String iconSelectedName,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: selectedIndex == index
          ? Container(
              child: Image.asset(
                selectedIndex == index ? iconSelectedName : iconUnSelectedName,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(66),
                color: AppColors.blackBgColor,
              ),
            )
          : Image.asset(
              selectedIndex == index ? iconSelectedName : iconUnSelectedName,
            ),
      label: label,
    );
  }

  String getBackgroundImage() {
    switch (selectedIndex) {
      case 0:
        return AppAssets.quranBG;
      case 1:
        return AppAssets.hadeethBG;
      case 2:
        return AppAssets.sebhaBG;
      case 3:
        return AppAssets.radioBG;
      case 4:
        return AppAssets.timeBG;
      default:
        return AppAssets.quranBG;
    }
  }
}
