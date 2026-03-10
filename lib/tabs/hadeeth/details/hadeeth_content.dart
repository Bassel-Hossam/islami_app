import 'package:flutter/material.dart';
import 'package:islami_app/utils/app_colors.dart';
import 'package:islami_app/utils/app_styles.dart';

class HadeethContent extends StatelessWidget {
  final String content;
  const HadeethContent({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: AppStyles.Bold20Primary,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
    );
  }
}
