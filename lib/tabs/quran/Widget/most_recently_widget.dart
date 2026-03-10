import 'package:flutter/material.dart';
import 'package:islami_app/model/quran_resources.dart';
import 'package:islami_app/providers/most_recent_provider.dart';
import 'package:islami_app/tabs/quran/shared_prefs_utils.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_colors.dart';
import 'package:islami_app/utils/app_styles.dart';
import 'package:islami_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

class MostRecentlyWidget extends StatefulWidget {
  MostRecentlyWidget({super.key});

  @override
  State<MostRecentlyWidget> createState() => _MostRecentlyWidgetState();
}

class _MostRecentlyWidgetState extends State<MostRecentlyWidget> {
  late MostRecentProvider mostRecentProvider;
  @override
  void initState() {
    // TODO: implement initState
    //This block of code will be execute before the build
    super.initState();
    //This block of code will be execute after the build
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mostRecentProvider.getlastSuraIndex();
    });
  }

  @override
  Widget build(BuildContext context) {
    var Width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    //create object from   ((MostRecentProvider class))  by 👇👇 ,,,  note '<MostRecentProvider>' => دا نوع ال provider بتاعي
    mostRecentProvider = Provider.of<MostRecentProvider>(context);
    return Visibility(
      // if list of recent index is on => so show the down details
      visible: mostRecentProvider.mostRecentList.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: height * 0.01,
        children: [
          Text("Most Recently", style: AppStyles.Bold15White),
          SizedBox(
            height: height * 0.16,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => InkWell(
                onTap: () async {
                  saveLastSuraIndex(mostRecentProvider.mostRecentList[index]);
                  await Navigator.of(context).pushNamed(
                    AppRoutes.suraDetailsScreen,
                    arguments: mostRecentProvider.mostRecentList[index],
                  );
                  mostRecentProvider.getlastSuraIndex();
                },
                child: Container(
                  padding: EdgeInsets.all(Width * 0.02),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            QuranResources.surahNamesEnglish[mostRecentProvider
                                .mostRecentList[index]],
                            style: AppStyles.Bold24Black,
                          ),
                          Text(
                            QuranResources.surahNamesArabic[mostRecentProvider
                                .mostRecentList[index]],
                            style: AppStyles.Bold24Black,
                          ),
                          Text(
                            '${QuranResources.surahVersesCount[mostRecentProvider.mostRecentList[index]]} verses',
                            style: AppStyles.Bold14Black,
                          ),
                        ],
                      ),
                      Image.asset(AppAssets.imgMostRecent),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context, index) =>
                  SizedBox(width: Width * 0.04),
              itemCount: mostRecentProvider.mostRecentList.length,
            ),
          ),
        ],
      ),
    );
  }
}
