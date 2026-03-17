import 'dart:math';

class CompletionRule {

  CompletionRule({required this.completionTarget, required DateTime startDate, this.type = CompletionType.atLeast}){
    this.startDate = DateTime(startDate.year, startDate.month, startDate.day);
  }
  final CompletionType type;

  ///<code>completionTarget</code>: Es el valor objetivo del hábito.
  final int completionTarget;

  ///<code>startDate</code>: Es la fecha a partir de la cual es válida esta regla, siempre y cuando no exista otra regla con fecha de inicio posterior a ésta.
  late final DateTime startDate;

  ///<code>isCompleted</code>: Devuelve si el habito se ha completado en base al tipo de regla que es y a su objetivo.
  bool isCompleted(int progress){
    return type == CompletionType.atLeast? progress >= completionTarget : (type == CompletionType.atMost ? progress <= completionTarget : progress == completionTarget);
  }
  
  ///<code>getProgressPercentage</code>: Devuelve el desempeño respecto a <code>completionTarget</code> según el valor pasado por parámetro y el tipo de regla.<br>
  ///Si el tipo de regla es CompletionType.exactly, se devuelve cien o cero, si está o no completado.<br>
  ///Si el tipo de regla es CompletionType.atLeast, se devuelve el resultado de multiplicar por cien la división entre <code>progress</code> y <code>completionTarget</code>.<br>
  ///Si el tipo de regla es CompletionType.atMost, se devuelve el complemento del caso donde la regla es de tipo CompletionType.atLeast. Es decir, se devuelve un numero cada vez menor (hasta llegar a cero) a medida que <code>progress</code> aumenta y llega a <code>completionTarget</code>.<br>
  ///Se asume <code>progress</code> mayor o igual a cero.
  int getProgressPercentage(int progress){
    
    if (completionTarget == 0 || type == CompletionType.exactly) {
      return isCompleted(progress) ? 100 : 0;
    } else {
      int target = completionTarget;
      int realProgress = type == CompletionType.atLeast? min(progress, target) : max(target - progress, 0);
      return (100 * realProgress / target).floor();
    } 

    

  }

  ///<code>trivial</code>: devuelve verdadero si el hábito solo requiere un punto de progreso para cumplirse.
  bool get trivial => completionTarget == 1;

  ///<code>emptyRule</code>: Regla dummy, imposible de cumplir e inmutable durante la ejecución.
  static final CompletionRule emptyRule = CompletionRule(completionTarget: -1, type: CompletionType.exactly, startDate: DateTime.fromMillisecondsSinceEpoch(0));
}

enum CompletionType {
  ///<code>atLeast</code>: Si el hábito se cumple con un progreso igual o mayor al objetivo.
  atLeast,
  ///<code>atMost</code>: Si el hábito se cumple con un progreso igual o menor al objetivo.
  atMost,
  ///<code>exactly</code>: Si el hábito se cumple con un progreso exactamente igual al objetivo.
  exactly
}