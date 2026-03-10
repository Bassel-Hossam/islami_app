import 'package:flutter/material.dart';
import 'package:islami_app/model/quran_resources.dart';
import 'package:islami_app/providers/most_recent_provider.dart';
import 'package:islami_app/tabs/quran/Details/Widget/sura_content.dart';
import 'package:islami_app/tabs/quran/Details/Widget/sura_content_1.dart';
import 'package:islami_app/tabs/quran/shared_prefs_utils.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_colors.dart';
import 'package:islami_app/utils/app_styles.dart';
import 'package:islami_app/utils/app_theme.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';

class SuraDetailsScreen1 extends StatefulWidget {
  const SuraDetailsScreen1({super.key});

  @override
  State<SuraDetailsScreen1> createState() => _SuraDetailsScreen1State();
}

class _SuraDetailsScreen1State extends State<SuraDetailsScreen1> {
  String fullSuraText = '';
  late MostRecentProvider mostRecentProvider;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    int index = ModalRoute.of(context)?.settings.arguments as int;
    mostRecentProvider = Provider.of<MostRecentProvider>(context);
    if (fullSuraText.isEmpty) {
      loadSuraFile(index);
    }
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        title: Text(
          QuranResources.surahNamesEnglish[index],
          style: AppStyles.Bold20Primary,
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
            // centerSlice: Rect.fromLTWH(40, 20, 200, 10), // اضبط القيم بعد معرفة حجم الصورة
            AppAssets.suraDetailsCorners,
            // alignment: Alignment.topRight,
          ),

          Padding(
            padding: EdgeInsets.only(
              top: height * 0.05,
              left: width * 0.05,
              right: width * 0.06,
            ),

            child: Column(
              children: [
                Transform.translate(
                  offset: Offset(0, -height * 0.020),
                  child: Text(
                    QuranResources.surahNamesArabic[index],
                    style: AppStyles.Bold24Primary,
                  ),
                ),
                Expanded(
                  child: fullSuraText.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : SingleChildScrollView(
                          child: SuraContent_1(content: fullSuraText),
                        ),
                ),
                SizedBox(height: height * 0.12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //read last suraIndex From shared preference from shared preference
    mostRecentProvider.getlastSuraIndex();
  }

  /// Assumes the given path is a text-file-asset.
  void loadSuraFile(int index) async {
    String fileContent = await rootBundle.loadString(
      'assets/files/quran/${index + 1}.txt',
    );
    //split the big string into (verses) (by index)
    List<String> lines = fileContent.split('\n');
    // loop to make (each verce with it's number)
    for (int i = 0; i < lines.length; i++) {
      lines[i] += ' [${i + 1}] ';
    }
    // (join all verses) اللي احنا قطعناهم
    fullSuraText = lines.join();
    setState(() {});
  }
}
