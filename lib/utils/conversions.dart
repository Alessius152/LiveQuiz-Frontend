String quizTimeFormatForCard(int totalSecs) {
  if (totalSecs <= 0) return "0 sec";

  int hours = totalSecs ~/ 3600;
  int mins = (totalSecs % 3600) ~/ 60;
  int secs = totalSecs % 60;

  List<String> result = [];

  if (hours > 0) {
    String label = hours == 1 ? "ora" : "ore";
    result.add("$hours $label");
  }

  if (mins > 0) {
    result.add("$mins min");
  }

  if (secs > 0 || result.isEmpty) {
    result.add("$secs sec");
  }

  return result.join(' ');
}