import 'package:flutter/material.dart';
import 'package:islami_app/model/hadeeth_details_args.dart';
import 'package:islami_app/model/quran_resources.dart';
import 'package:islami_app/tabs/hadeeth/details/hadeeth_content.dart';
import 'package:islami_app/tabs/quran/Details/Widget/sura_content.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_colors.dart';
import 'package:islami_app/utils/app_styles.dart';
import 'package:islami_app/utils/app_theme.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:islami_app/model/hadeeth.dart';

class HadeethDetailsScreen extends StatelessWidget {
  HadeethDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    HadeethDetailsArgs args =
        ModalRoute.of(context)?.settings.arguments as HadeethDetailsArgs;

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        title: Text("hadeeth ${args.index+1}", style: AppStyles.Bold20Primary),
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
                    args.hadeeth.title,
                    style: AppStyles.Bold24Primary,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: HadeethContent(content: args.hadeeth.content),
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
}
