class DateTimeUtils {
  static bool isNearEnd({required DateTime inputDateTime}) {
    var time = inputDateTime.millisecondsSinceEpoch -
        DateTime.now().millisecondsSinceEpoch;

    if (time <= 86400000)
      return true;
    else
      return false;
  }
}
