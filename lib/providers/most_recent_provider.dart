import 'package:flutter/material.dart';
import 'package:islami_app/tabs/quran/shared_prefs_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MostRecentProvider extends ChangeNotifier {
  List<int> mostRecentList = [];
  Future<void> getlastSuraIndex() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> MostRecentIndiciesAsStrings =
        prefs.getStringList(SharedPrefsKeys.mostRecentKey) ?? [];
    mostRecentList = MostRecentIndiciesAsStrings.reversed.map((newSuraIndex) => int.parse(newSuraIndex)).toList();
    notifyListeners();
  }
}
