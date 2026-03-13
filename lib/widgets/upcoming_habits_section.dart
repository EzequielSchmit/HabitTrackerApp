import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habit_tracker_app/model/habit.dart';
import 'package:habit_tracker_app/util/my_colors.dart';
import 'package:habit_tracker_app/util/styles.dart';
import 'package:habit_tracker_app/widgets/upcoming_habits_card.dart';

class UpcomingHabitsSection extends StatefulWidget {
  const UpcomingHabitsSection({super.key});
  
  static final double verticalCardMargin = 8;
  static final double cardHeight = 70;
  
  static final double fullCardHeight = verticalCardMargin*2 + cardHeight;
  

  @override
  State<UpcomingHabitsSection> createState() => _UpcomingHabitsSectionState();
}

class _UpcomingHabitsSectionState extends State<UpcomingHabitsSection> {

  ScrollController? controller;
  final List<Habit> habits = [];
  bool isThereMoreElementsToShow = true;

  @override
  void initState(){
    super.initState();
    controller = ScrollController();
    controller!.addListener(() {
      double actualOffset = controller!.offset;
      double maxOffset = controller!.position.maxScrollExtent;
      final bool canScroll = maxOffset > 0;
      final bool atBottom = actualOffset >= (maxOffset - 0.01);
      final bool shouldShowShadow = canScroll && !atBottom;
      if (isThereMoreElementsToShow != shouldShowShadow){
        setState(() {
          isThereMoreElementsToShow = shouldShowShadow;
        });
      }  
    },);

    List<Color> colors = MyColors.colors;
    Random random = Random();
    for (int i = 1; i < 11; i++){
      Color randomColor = colors[random.nextInt(colors.length)];
      habits.add(Habit(name: "Habito $i", backgroundColor: randomColor));
    }

  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Próximos hábitos", style: Styles.sectionTitle.copyWith(backgroundColor: Colors.white),),
              SizedBox(height: 10,),
              SizedBox(
                height: 3*UpcomingHabitsSection.fullCardHeight,
                child: ListView.builder(
                  controller: controller,

                  itemCount: habits.length,
                  itemExtent: UpcomingHabitsSection.fullCardHeight,
                  itemBuilder: (context, index) {
                    
                    return UpcomingHabitsCard(
                      habit: habits[index],
                      height: UpcomingHabitsSection.cardHeight,
                      verticalMargin: UpcomingHabitsSection.verticalCardMargin,
                    );
                  },
                ),
              ),
            ],
          ),
          if (isThereMoreElementsToShow)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: AlignmentGeometry.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      colors.surfaceContainerLowest.withAlpha(0),
                      colors.surfaceContainerLowest.withAlpha(180),
                    ],
                    // stops: [0.5, 1.0]
                  )
                )
              )
            )
        ]
      ),
    );
  }
}