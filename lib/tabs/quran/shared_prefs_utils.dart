import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsKeys {
  static const String mostRecentKey = 'Most_recent';
}

void saveLastSuraIndex(int newSuraIndex) async {
  // Obtain shared preferences.
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Try reading data from the 'items' key.
  final List<String> mostRecentList =
      prefs.getStringList(SharedPrefsKeys.mostRecentKey) ?? [];

  //to prevent Diblicate ,,, check index => exist =>remove => then insert it again
  if (mostRecentList.contains('$newSuraIndex')) {
    mostRecentList.remove("$newSuraIndex");
    mostRecentList.add('$newSuraIndex');
    // list.reversed كده المفروض يتحط في الاخر ولكننا عاملين تحت
  } else {
    //if is not Diblicate => insert / add
    mostRecentList.add('$newSuraIndex');
  }
  // make a limit
  if (mostRecentList.length > 5) {
    mostRecentList.removeAt(0);
  }
  // Save an list of strings to 'mostRecentKey'.
  await prefs.setStringList(SharedPrefsKeys.mostRecentKey, mostRecentList);
}
