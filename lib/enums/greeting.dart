enum Greeting {
  morning(greetingName: "Buen día", startHour: 6, endHour: 13),
  afternoon(greetingName: "Buenas tardes", startHour: 13, endHour: 20),
  night(greetingName: "Buenas noches", startHour: 20, endHour: 6);

  final String greetingName;
  
  /// <code>startHour</code>: numero entero entre [0-23] que representa la hora (incluyente)<br>
  /// a partir de la cual el saludo es apropiado.
  final int startHour;
  /// <code>endHour</code>: numero entero entre [0-23] que representa la hora (excluyente) <br>
  /// a partir de la cual el saludo ya no es apropiado.
  final int endHour;
  
  const Greeting({required this.greetingName, required this.startHour, required this.endHour});

  static String getGreetingByHour(int hour){
    Exception exception = Exception("Invalid value. \"hour\" must be between 0 and 23.");
    if (hour < 0 || hour > 23) {
      throw exception;
    }
    for (Greeting g in Greeting.values){
      if (g.startHour < g.endHour){
        if (hour >= g.startHour && hour < g.endHour) return g.greetingName;
      } else {
        if (hour >= g.startHour || hour < g.endHour) return g.greetingName;
      }
    }
    throw exception;   
  }
}