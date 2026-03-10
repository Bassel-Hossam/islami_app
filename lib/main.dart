import 'package:flutter/material.dart';
import 'package:islami_app/home/home_screen.dart';
import 'package:islami_app/model/hadeeth.dart';
import 'package:islami_app/providers/most_recent_provider.dart';
import 'package:islami_app/tabs/hadeeth/details/hadeeth_details_screen.dart';
import 'package:islami_app/tabs/quran/Details/sura_details_screen.dart';
import 'package:islami_app/tabs/quran/Details/sura_details_screen_1.dart';
import 'package:islami_app/utils/app_routes.dart';
import 'package:islami_app/utils/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart'; // استدعاء المكتبة

void main() {
  runApp(ChangeNotifierProvider(create: (context) => MostRecentProvider(),child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.tajawalTextTheme(Theme.of(context).textTheme),
      ),

      darkTheme: AppTheme.darktheme.copyWith(
        textTheme: GoogleFonts.tajawalTextTheme(AppTheme.darktheme.textTheme),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeScreenRoute,
      routes: {
        AppRoutes.homeScreenRoute: (context) => HomeScreen(),
        AppRoutes.suraDetailsScreen: (context) => SuraDetailsScreen(),
        AppRoutes.suraDetailsScreen_1: (context) => SuraDetailsScreen1(),
        AppRoutes.hadeethDetailsScreen: (context) => HadeethDetailsScreen(),
      },
      themeMode: ThemeMode.dark,
    );
  }
}
