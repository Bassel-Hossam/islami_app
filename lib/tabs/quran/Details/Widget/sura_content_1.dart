import 'package:flutter/material.dart';
import 'package:islami_app/utils/app_colors.dart';
import 'package:islami_app/utils/app_styles.dart';

class SuraContent_1 extends StatelessWidget {
  final String content;
  const SuraContent_1({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;  

    return Text(
      content,
      style: AppStyles.Bold20Primary,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
    );
  }
}
