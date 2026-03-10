import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:islami_app/model/quran_resources.dart';
import 'package:islami_app/providers/most_recent_provider.dart';
import 'package:islami_app/tabs/quran/Details/Widget/sura_content.dart';
import 'package:islami_app/tabs/quran/Details/Widget/sura_content_1.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_colors.dart';
import 'package:islami_app/utils/app_styles.dart';
import 'package:provider/provider.dart';

class SuraDetailsScreen extends StatefulWidget {
  static const String routeName = 'sura_details';
  const SuraDetailsScreen({super.key});

  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen> {
  String fullSuraText = '';
  List<String> versesList = [];
  bool isListMode = false;
  late MostRecentProvider mostRecentProvider;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    int index = ModalRoute.of(context)?.settings.arguments as int;
    mostRecentProvider = Provider.of<MostRecentProvider>(context);
    if (versesList.isEmpty) loadSuraFile(index);

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        iconTheme: IconThemeData(color: AppColors.primaryColor),
        title: Text(
          QuranResources.surahNamesEnglish[index],
          style: AppStyles.Bold20Primary,
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isListMode = !isListMode;
              });
            },
            icon: Icon(
              isListMode ? Icons.menu_book_rounded : Icons.view_list_rounded,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            AppAssets.suraDetailsCorners,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
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
                  child: versesList.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : isListMode
                      ? ListView.separated(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          itemBuilder: (context, index) => SuraContent(
                            content: versesList[index],
                            index: index,
                          ),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10),
                          itemCount: versesList.length,
                        )
                      : SingleChildScrollView(
                          padding: EdgeInsets.symmetric(vertical: 20),
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
    //read last suraIndex From shared preference from shared preference
    mostRecentProvider.getlastSuraIndex();
    // TODO: implement dispose
    super.dispose();
  }

  void loadSuraFile(int index) async {
    String fileContent = await rootBundle.loadString(
      'assets/files/quran/${index + 1}.txt',
    );
    List<String> lines = fileContent.trim().split('\n');
    versesList = lines;

    for (int i = 0; i < lines.length; i++) {
      lines[i] += ' [${i + 1}] ';
    }
    fullSuraText = lines.join();
    setState(() {});
  }
}
