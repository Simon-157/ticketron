  import 'dart:math';

String getMonthName(int month) {
    List<String> monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return monthNames[month - 1];
  }

  String getWeekDayName(int weekday) {
    List<String> weekDayNames = [
      'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
    ];
    return weekDayNames[weekday - 1];
  }

    String getFormattedDate(DateTime date) {
    List<String> monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${monthNames[date.month - 1]} ${date.day}, ${date.year}';
  }


  String generateVerificationCode() {
    final random = Random();
    const letters = 'abcdefghijklmnopqrstuvwxyz';
    String code = '';

    for (int i = 0; i < 10; i++) {
      final randomIndex = random.nextInt(letters.length);
      code += letters[randomIndex];
    }

    return code.toUpperCase();
  }
