import 'package:flutter/material.dart';
import 'package:islami_app/model/quran_resources.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_styles.dart';
import 'package:islami_app/tabs/quran/Widget/sura_Item_widget.dart';

class SuraItemWidget extends StatelessWidget {
  final int index;
  const SuraItemWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Row(
      spacing: width * 0.06,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(AppAssets.imgSuraNumber_bg),
            Text("${index + 1}", style: AppStyles.Bold15White),
          ],
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              QuranResources.surahNamesEnglish[index],
              style: AppStyles.Bold20White,
            ),
            Text(
              "${QuranResources.surahVersesCount[index]} Verses",
              style: AppStyles.Bold14White,
            ),
          ],
        ),
        Spacer(),
        Text(
          QuranResources.surahNamesArabic[index],
          style: AppStyles.Bold20White,
        ),
      ],
    );
  }
}
