import 'package:flutter/material.dart';
import 'package:habit_tracker_app/enums/month.dart';
import 'package:habit_tracker_app/widgets/days_row_item.dart';

class DaysRow extends StatefulWidget {
  const DaysRow({super.key});

  @override
  State<DaysRow> createState() => _DaysRowState();
}

class _DaysRowState extends State<DaysRow> {

  static const double itemWidth = 65;
  static const double horizontalItemPadding = 8;
  static const double fullItemWidth = itemWidth + 2*horizontalItemPadding;
  static const int centerIndex = 20*365;
  // ScrollController? controller;  
  late final ScrollController controller;
  DateTime today = normalizeDate(DateTime.now());
  DateTime selectedDate = normalizeDate(DateTime.now());
  DateTime viewedDate = normalizeDate(DateTime.now());

  @override
  void initState(){
    super.initState();

    // controller = ScrollController(
    //   initialScrollOffset: centerIndex*(itemWidth+2*horizontalItemPadding) - 30,
    // );
    controller = ScrollController();
    controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void setFechaSeleccionada(DateTime dateToBeSelected){
    setState(() {
      if (!dateToBeSelected.isAfter(today)) {
        selectedDate = dateToBeSelected;
      }
    });
  }
  
  double? viewportWidth;
  bool initialized = false;
  
  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    
    return LayoutBuilder(
      builder: (context, constraints) {
        
        viewportWidth = constraints.maxWidth;

        if (!initialized && viewportWidth! > 0) {
          initialized = true;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            final initialOffset =
                centerIndex * fullItemWidth - viewportWidth! / 2 + fullItemWidth / 2;

            controller.jumpTo(initialOffset);
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
                  controller: controller,
                  itemCount: centerIndex + 7,
                  scrollDirection: Axis.horizontal,
                  itemExtent: itemWidth + 2*horizontalItemPadding,
                  cacheExtent: fullItemWidth*10,
                  itemBuilder: (context, index){
                    
                    final int diff = index - centerIndex;
                    final DateTime date = today.add(Duration(days: diff));
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: horizontalItemPadding),
                      child: DaysRowItem(date: date),
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
    double offset = controller.offset + controller.position.viewportDimension/2;
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

DateTime normalizeDate(DateTime date){
  return DateTime(date.year, date.month, date.day);
}