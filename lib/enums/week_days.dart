enum WeekDay {
  monday("Lunes"),
  tuesday("Martes"),
  wednesday("Miércoles"),
  thursday("Jueves"),
  friday("Viernes"),
  saturday("Sábado"),
  sunday("Domingo");

  final String name;
  const WeekDay(this.name);
  

  ///
  /// <br>
  /// <code>dayNumber</code>: the number of the day of the week, from 1 (Monday) to 7 (Sunday).  
  /// <br>
  /// <hr>
  /// <br>
  /// <b>returns</b> if <code>dayNumber</code> is a valid value, it returns the name of the day, else it returns an empty string.
  ///
  static String getDayName(int val){
    for (WeekDay day in WeekDay.values){
      if (day.index + 1 == val){
        return day.name;
      }
    }
    return "";
  }
}