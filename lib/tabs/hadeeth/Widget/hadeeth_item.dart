import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/model/hadeeth.dart';
import 'package:islami_app/model/hadeeth_details_args.dart';
import 'package:islami_app/utils/app_assets.dart';
import 'package:islami_app/utils/app_colors.dart';
import 'package:islami_app/utils/app_routes.dart';
import 'package:islami_app/utils/app_styles.dart';

class HadeethItem extends StatefulWidget {
  final int index;

  HadeethItem({super.key, required this.index});

  @override
  State<HadeethItem> createState() => _HadeethItemState();
}

class _HadeethItemState extends State<HadeethItem> {
  Hadeeth? hadeeth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadHadeethFile(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.HadithCardBackGround),
        ),
        borderRadius: BorderRadius.circular(20),
        color: AppColors.primaryColor,
      ),
      child: hadeeth == null
          ? Center(
              child: CircularProgressIndicator(color: AppColors.blackColor),
            )
          : InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.hadeethDetailsScreen,
                  arguments: HadeethDetailsArgs(
                    hadeeth: hadeeth!,
                    index: widget.index,
                  ),
                );
              },
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04,
                      vertical: height * 0.02,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(AppAssets.left_corner_hadeeth),
                        Expanded(
                          child: Text(
                            hadeeth?.title ?? '',
                            style: AppStyles.Bold24Black,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Image.asset(AppAssets.right_corner_hadeeth),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                        child: Text(
                          hadeeth?.content ?? "",
                          textAlign: TextAlign.center,
                          style: AppStyles.Bold16Black,
                        ),
                      ),
                    ),
                  ),
                  Image.asset(
                    AppAssets.Mosque_hadeeth,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
    );
  }

  void loadHadeethFile(int index) async {
    String fileContent = await rootBundle.loadString(
      "assets/files/hadeeth/h$index.txt",
    );
    String title = fileContent.substring(0, fileContent.indexOf('\n'));
    String content = fileContent.substring(fileContent.indexOf('\n'));
    hadeeth = Hadeeth(title: title, content: content);
    setState(() {});
  }
}
