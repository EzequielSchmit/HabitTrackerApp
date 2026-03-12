import 'package:flutter/material.dart';
import 'package:habit_tracker_app/enums/greeting.dart';
import 'package:habit_tracker_app/util/styles.dart';

class GreetingTitle extends StatelessWidget {
  
  const GreetingTitle({super.key});


  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    DateTime now = DateTime.now();
    String greetingString = Greeting.getGreetingByHour(now.hour);
    List<String> greetingStringInParts = greetingString.split(" ");
    TextStyle style = Styles.appBarTitle.copyWith(color: colors.onSurface,);
    return Container(
      child: Column(
        children: [
          Container(height: 30,),
          Row(
            children: [
              Text("¡${greetingStringInParts[0]} ", style: style,),
              Text(greetingStringInParts[1], style: style.copyWith(color: colors.primary),),
              Text("!", style: style,)
          ])
        ],
      ),
    );
  }
}