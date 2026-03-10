import 'package:flutter/material.dart';
import 'package:islami_app/model/quran_resources.dart';
import 'package:islami_app/providers/most_recent_provider.dart';
import 'package:islami_app/tabs/quran/Widget/most_recently_widget.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_colors.dart';
import 'package:islami_app/utils/app_routes.dart';
import 'package:islami_app/utils/app_styles.dart';
import 'package:islami_app/tabs/quran/Widget/sura_Item_widget.dart';
import 'package:islami_app/tabs/quran/shared_prefs_utils.dart';
import 'package:provider/provider.dart';

class QuranTab extends StatefulWidget {
  QuranTab({super.key});

  @override
  State<QuranTab> createState() => _QuranTabState();
}

class _QuranTabState extends State<QuranTab> {
  //we will make list of type int that will carry the index
  List<int> filterList = List.generate(114, (index) => index);

  @override
  Widget build(BuildContext context) {
    var Width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: height * 0.01,
        children: [
          TextField(
            onChanged: (newText) {
              searchByNewText(newText);
            },
            cursorColor: AppColors.primaryColor,
            decoration: InputDecoration(
              enabledBorder: builtDecorationBorder(),
              focusedBorder: builtDecorationBorder(),
              prefixIcon: Image.asset(AppAssets.iconSearch),
              hintText: 'Sura Name',
              hintStyle: AppStyles.Bold15White,
            ),
          ),
          MostRecentlyWidget(),
          Text("Sura's List", style: AppStyles.Bold15White),
          Expanded(
            child: filterList.isEmpty
                ? Center(
                    child: Text(
                      "Sura's Name is not Founded",
                      style: AppStyles.Bold18White,
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) => InkWell(
                      onTap: () async {
                        //todo: save last sura index
                        saveLastSuraIndex(filterList[index]);
                        //todo: Navigate to sura details screen
                        await Navigator.of(context).pushNamed(
                          AppRoutes.suraDetailsScreen,
                          arguments: filterList[index],
                        );
                      },
                      child: SuraItemWidget(index: filterList[index]),
                    ),
                    separatorBuilder: (context, index) => Divider(
                      color: AppColors.whiteColor,
                      thickness: 2,
                      indent: Width * 0.09,
                      endIndent: Width * 0.09,
                    ),
                    // عشان الليست هتتغير مش هتبقا ثابته لو حصل سيرش هنعرض بعض النتائج فقط من خلال index الخاص بكل نتيجة
                    itemCount: filterList.length,
                  ),
          ),
        ],
      ),
    );
  }

  //we will make a function to summaraize the code in enabledBorder , focusedBorder
  OutlineInputBorder builtDecorationBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
    );
  }

  void searchByNewText(String newText) {
    List<int> filterSeachListByIndex = [];
    for (int i = 0; i < QuranResources.surahNamesArabic.length; i++) {
      if (QuranResources.surahNamesArabic[i].contains(newText)) {
        filterSeachListByIndex.add(i);
      }
    }
    for (int i = 0; i < QuranResources.surahNamesEnglish.length; i++) {
      if (QuranResources.surahNamesEnglish[i].toLowerCase().contains(
        newText.toLowerCase(),
      )) {
        filterSeachListByIndex.add(i);
      }
    }
    filterList = filterSeachListByIndex;
    setState(() {});
  }
}
