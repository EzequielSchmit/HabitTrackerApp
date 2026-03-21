extension DateTimeExtension on DateTime {

  DateTime normalize() => new DateTime(year, month, day);

  ///<code>differenceInDaysWith</code>: Devuelve la diferencia nominal de dias entre dos fechas. Es decir, considera que si dos fechas tienen una diferencia de un día con solo estar en distintos días, aún si la diferencia en horas entre ellas es menor a 24 hs.<br>
  ///El valor retornado será negativo si <code>otherDate</code> ocurre despues de este [DateTime].
  int differenceInDaysWith(DateTime otherDate){
    return normalize().difference(otherDate.normalize()).inDays;
  }

  bool isSameDay(DateTime otherDate){
    return differenceInDaysWith(otherDate) == 0;
  }

  String getSimpleDateString({String separator = "/"}) {
    if (separator.isEmpty) separator = "/";
    return "$day$separator$month$separator$year";
  }

}