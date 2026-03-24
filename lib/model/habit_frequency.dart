class HabitFrequency {
  HabitFrequency({required this.frequencyType, required this.timesInFrequency, this.namesOfTimes});
  
  final FrequencyType frequencyType;
  final int timesInFrequency;
  List<String>? namesOfTimes;




}

enum FrequencyType {
  daily(name: "Diaria"),
  weekly(name: "Semanal"),
  monthly(name: "Mensual");

  final String name;
  const FrequencyType({required this.name});
}

enum Day {
  monday(name: "Lunes"),
  tuesday(name: "Martes"),
  wednesday(name: "Miércoles"),
  thursday(name: "Jueves"),
  friday(name: "Viernes"),
  saturday(name: "Sábado"),
  sunday(name: "Domingo");

  final String name;
  
  const Day({required this.name});
}