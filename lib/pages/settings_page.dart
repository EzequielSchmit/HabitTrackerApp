import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      child: Column(
        children: [
          Text("Home page"),
          Row(
            children: [
              get(colors.primary, "primary"),
              get(colors.onPrimary, "onPrimary"),
              get(colors.primaryContainer, "primaryContainer"),
              get(colors.onPrimaryContainer, "onPrimaryContainer"),
              
              
            ],
          ),
          Row(
            children: [
              get(colors.primaryFixed, "primaryFixed"),
              get(colors.onPrimaryFixed, "onPrimaryFixed"),
              get(colors.primaryFixedDim, "primaryFixedDim"),
              get(colors.onPrimaryFixedVariant, "onPrimaryFixedVariant"),
            ],
          ),
          Row(
            children: [
              get(colors.inversePrimary, "inversePrimary"),
            ],
          ),
          Row(
            children: [
              get(colors.secondary, "secondary"),
              get(colors.onSecondary, "onSecondary"),
              get(colors.secondaryContainer, "secondaryContainer"),
              get(colors.onSecondaryContainer, "onSecondaryContainer"),
            ],
          ),

          Row(
            children: [
              get(colors.secondaryFixed, "secondaryFixed"),
              get(colors.onSecondaryFixed, "onSecondaryFixed"),
              get(colors.secondaryFixedDim, "secondaryFixedDim"),
              get(colors.onSecondaryFixedVariant, "onSecondaryFixedVariant"),
            ],
          ),
        ],
      ),
    );
  }
}

Widget get(Color color, String name){
  return Container(
    color: color,
    width: 96,
    height: 50,
    child: Text(name, style: TextStyle(color: getColor(color)),),
  );
}

Color getColor(Color color){
  return ( (color.r + color.g + color.b)/3 * 255.0).round().clamp(0, 255) <=100 ? Colors.white : Colors.black;
}