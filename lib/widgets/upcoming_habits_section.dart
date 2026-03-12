import 'package:flutter/material.dart';
import 'package:habit_tracker_app/util/styles.dart';

class UpcomingHabitsSection extends StatelessWidget {
  const UpcomingHabitsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Container(
      // color: colors.secondary,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      height: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Próximos hábitos", style: Styles.sectionTitle.copyWith(backgroundColor: Colors.white),),
          SizedBox(height: 20,),
          Expanded(
            child: ListView(
              children: [
                for (int i = 1; i < 10; i++)
                  Text("Habito $i"),
              ],
            ),
          )
        ],
      ),
    );
  }
}