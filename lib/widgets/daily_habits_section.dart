import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habit_tracker_app/controllers/daily_habits_controller.dart';
import 'package:habit_tracker_app/model/habit_entry.dart';
import 'package:habit_tracker_app/util/styles.dart';
import 'package:habit_tracker_app/widgets/daily_habits_card.dart';

class DailyHabitsSection extends StatefulWidget {
  const DailyHabitsSection({super.key, required this.title, this.cardBackgroundColor, this.cardColor, required this.entries, required this.messageWhenEmpty, required this.controller});

  final DailyHabitsController controller;  
  static final double verticalCardMargin = 8;
  static final double cardHeight = 70;
  static final double fullCardHeight = verticalCardMargin*2 + cardHeight;
  
  final String title;
  final List<HabitEntry> entries;
  final String messageWhenEmpty;
  ///<code>cardbackgroundColor</code> The color this sections' cards will use for background. If null or not specified, each card will use its associated habit color. 
  final Color? cardBackgroundColor;
  ///<code>cardColor</code> The color this sections' cards will use for text. If null or not specified, each card will use this context's colorScheme "onPrimary" color. 
  final Color? cardColor;
  

  @override
  State<DailyHabitsSection> createState() => _DailyHabitsSectionState();
}

class _DailyHabitsSectionState extends State<DailyHabitsSection> {

  ScrollController? controller;
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

  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool thereAreEntries = widget.entries.isNotEmpty;
    final int maxVisibleEntries = 3;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(widget.title, style: Styles.sectionTitle.copyWith(backgroundColor: Colors.white),),
              SizedBox(height: 10,),
              AnimatedSize(
                alignment: Alignment.topCenter,
                duration: Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                child: SizedBox(
                  height: (thereAreEntries ? min(maxVisibleEntries, widget.entries.length) : 1)*DailyHabitsSection.fullCardHeight,
                  child: thereAreEntries ? ListView.builder(
                    controller: controller,
                    
                    itemCount: widget.entries.length,
                    itemExtent: DailyHabitsSection.fullCardHeight,
                    itemBuilder: (context, index) {
                      HabitEntry entry = widget.entries[index];
                      return DailyHabitsCard(
                        key: ValueKey(entry.id),
                        entry: entry, 
                        cardBackgroundColor: widget.cardBackgroundColor ?? entry.habit.color,
                        cardColor: widget.cardColor ?? colors.onPrimary,
                        height: DailyHabitsSection.cardHeight,
                        verticalMargin: DailyHabitsSection.verticalCardMargin,
                        controller: widget.controller,
                      );
                    },
                  ) : Container(
                    height: DailyHabitsSection.fullCardHeight,
                    margin: EdgeInsets.symmetric(vertical: DailyHabitsSection.verticalCardMargin),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: colors.secondary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.messageWhenEmpty,
                      style: TextStyle(color: colors.onSecondary),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isThereMoreElementsToShow && widget.entries.length > maxVisibleEntries)
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