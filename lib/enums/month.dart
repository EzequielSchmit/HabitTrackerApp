enum Month {
  january("Enero"),
  february("Febrero"),
  march("Marzo"),
  april("Abril"),
  may("Mayo"),
  june("Junio"),
  july("Julio"),
  august("Agosto"),
  september("Septiembre"),
  october("Octubre"),
  november("Noviembre"),
  december("Diciembre");

  final String name;
  const Month(this.name);
  

  ///
  /// <br>
  /// <code>monthNumber</code>: the number of the month, from 1 (January) to 12 (December).  
  /// <br>
  /// <hr>
  /// <br>
  /// <b>returns</b> if <code>monthNumber</code> is a valid value, it returns the name of the month, else it returns an empty string.
  ///
  static String getMonthName(int val){
    for (Month month in Month.values){
      if (month.index + 1 == val){
        return month.name;
      }
    }
    return "";
  }
}