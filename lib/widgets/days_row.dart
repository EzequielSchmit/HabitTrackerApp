import 'package:flutter/material.dart';
import 'package:habit_tracker_app/controllers/daily_habits_controller.dart';
import 'package:habit_tracker_app/enums/month.dart';
import 'package:habit_tracker_app/util/date_time_extension.dart';
import 'package:habit_tracker_app/widgets/days_row_item.dart';

class DaysRow extends StatefulWidget {
  DaysRow({super.key, required this.controller}){
    selectedDate = controller.selectedDate;
  }

  final DailyHabitsController controller;
  late final DateTime selectedDate;

  @override
  State<DaysRow> createState() => _DaysRowState();
}

class _DaysRowState extends State<DaysRow> {

  static const double itemWidth = 65;
  static const double horizontalItemPadding = 8;
  static const double fullItemWidth = itemWidth + 2*horizontalItemPadding;
  static const int centerIndex = 20*365;
  
  late final ScrollController scrollController;
  DateTime today = DateTime.now().normalize();

  DateTime viewedDate = DateTime.now().normalize();
  double? viewportWidth;
  bool initialized = false;

  @override
  void initState(){
    super.initState();

    // controller = ScrollController(
    //   initialScrollOffset: centerIndex*(itemWidth+2*horizontalItemPadding) - 30,
    // );
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _handleItemOnTap(DateTime date, int index) {
    final newOffset = index * fullItemWidth - viewportWidth! / 2 + fullItemWidth / 2;
    scrollController.animateTo(newOffset, duration: Duration(milliseconds: 200), curve: Curves.decelerate);
    widget.controller.setSelectedDay(date);
  }

  // void setSelectedDay(DateTime dateToBeSelected){
  //   if (!dateToBeSelected.isAfter(today)) {
  //     setState(() {
  //       selectedDate = dateToBeSelected;
  //     });
  //   }
  // }
  
  
  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {

        viewportWidth = constraints.maxWidth;
        if (!initialized && viewportWidth! > 0) {
          initialized = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            int diffBetweenSelectedAndToday = widget.selectedDate.differenceInDaysWith(today);
            final initialOffset = (centerIndex + diffBetweenSelectedAndToday) * fullItemWidth - viewportWidth! / 2 + fullItemWidth / 2;
            scrollController.jumpTo(initialOffset);
          });
        }

        /*final viewportWidth = constraints.maxWidth;
        final initialOffset = centerIndex*fullItemWidth - viewportWidth/2 + fullItemWidth/2 ;
        if (controller == null || !controller!.hasClients){
          controller = ScrollController(initialScrollOffset: initialOffset);
          controller!.addListener(_onScroll);
        }*/

        return Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, bottom: 5),
                width: double.infinity,
                alignment: Alignment.centerLeft,
                // color: Colors.blue,
                child: Text(
                  "${viewedDate.year} ${Month.getMonthName(viewedDate.month)}",
                  style: TextStyle(fontStyle: FontStyle.italic, color: colors.onSurface.withAlpha(100)),
                )
              ),
              SizedBox(
                height: 75,
                // color: Colors.blue, // colors.surfaceContainerLowest,
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: centerIndex + 7,
                  scrollDirection: Axis.horizontal,
                  itemExtent: itemWidth + 2*horizontalItemPadding,
                  cacheExtent: fullItemWidth*10,
                  itemBuilder: (context, index){
                    
                    final int diff = index - centerIndex;
                    final DateTime date = today.add(Duration(days: diff));
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: horizontalItemPadding),
                      child: DaysRowItem(date: date, index: index, isSelected: widget.selectedDate.isSameDay(date), onTap: _handleItemOnTap,),
                    );
                  },
                ),
              ),
            ]
          ),
        );
      },
    );
  }

  void _onScroll(){
    double offset = scrollController.offset + scrollController.position.viewportDimension/2;
    int index = offset ~/ fullItemWidth;
    int diffWithToday = index - centerIndex;
    DateTime viewedDate = today.add(Duration(days: diffWithToday));
    viewedDate = viewedDate.copyWith(day: 1);
    if (viewedDate != this.viewedDate){
      setState(() {
        this.viewedDate = viewedDate;
      });
    }
  }
}

// DateTime normalizeDate(DateTime date){
//   return DateTime(date.year, date.month, date.day);
// }