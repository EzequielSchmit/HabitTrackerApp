import 'package:flutter/material.dart';
import 'package:habit_tracker_app/model/completion_rule.dart';
import 'package:habit_tracker_app/model/habit.dart';
import 'package:habit_tracker_app/model/habit_frequency.dart';
import 'package:habit_tracker_app/util/color_extension.dart';
import 'package:habit_tracker_app/util/styles.dart';
import 'package:habit_tracker_app/widgets/frequency_dropdown.dart';
import 'package:habit_tracker_app/widgets/separating_line.dart';

class CreateHabitPage extends StatefulWidget {
  CreateHabitPage({super.key, required this.screenWidth, required this.screenHeight});

  final double screenWidth, screenHeight;

  @override
  State<CreateHabitPage> createState() => _CreateHabitPageState();
}

class _CreateHabitPageState extends State<CreateHabitPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _frequencyController = TextEditingController();
  
  
  int? id;
  String? name;
  Color? color;
  List<CompletionRule> rules = [];

  int? completionTarget;
  DateTime? startDate;
  CompletionType? type;
  bool _isPositive = true;

  Color? selectedColor = ColorExtension.habitsColors[0];

  FrequencyType _frequencyType = FrequencyType.daily;
  final List<Day> _selectedDays = [];

  void _submit() {

  }

  void _handleTapOnColorSelector(Color color) {
    if (ColorExtension.habitsColors.contains(color)){
      setState(() {
        selectedColor = color;
      });
    }
  }

  Widget _buildTitle() {
    return Text("Crear nuevo hábito", style: Styles.sectionTitle.copyWith(fontSize: 24, fontWeight: FontWeight.w400),);
  }

  Widget _buildContent(ColorScheme colors) {
    List<Color> habitsColors = ColorExtension.habitsColors;
    List<String> options = [];
    options.addAll(Day.values.map( (day)=>day.name ));

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _createSectionTitle("Color principal"),
        _getColorSelectors(habitsColors),
        
        SeparatingLine(topMargin: 30, bottomMargin: 30,),
        // SeparatingLine(bottomMargin: 20,),

        _createSectionTitle("Datos"),
        _getDataSection(colors),
        _getPositiveHabitSwitch(),
        
        SeparatingLine(topMargin: 30, bottomMargin: 30,),
        // SeparatingLine(bottomMargin: 20,),
        _createSectionTitle("Frecuencia"),
        _getFrequencySection(colors),
      ],
    );
  }

  Column _getFrequencySection(ColorScheme colors) {
    return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: MyInput(hintText: "N° de veces", controller: _frequencyController, enabled: _selectedDays.isEmpty,),
            ),
            FrequencyDropdown(frequency: _frequencyType, onChanged: (frequencyType) {
              setState(() {
                _frequencyType = frequencyType;
              });
            },),
            AnimatedSize(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 250),
              child: !(_frequencyType == FrequencyType.weekly && _isPositive) ? SizedBox(height: 0, width: 150,) : Column(
                children: [
                  SizedBox(height: 40,),
                  Text("Selecciona frecuencia semanal"),
                  SizedBox(height: 10,),
                  Column(
                    children: Day.values.map( (day) {
                      final isSelected = _selectedDays.contains(day);
                      return CheckboxListTile(
                        minTileHeight: 30,
                        minVerticalPadding: 10,
                        title: Text(day.name, style: TextStyle(fontSize: 14),),
                        value: isSelected,
                        onChanged: (checked){
                          setState(() {
                            if (checked!) {
                              _selectedDays.add(day);
                            } else {
                              _selectedDays.remove(day);
                            }
                          });
                        },
                      );
                    }, ).toList()
                  ),
                ]
              ),
            ),
          ],
        );
  }

  Column _getColorSelectors(List<Color> habitsColors) {
    return Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 5,
              children: habitsColors.map( (c) {
                return ColorSelectorCircle(backgroundColor: c, isSelected: (c == selectedColor), onTap: _handleTapOnColorSelector,);
              }, ).toList().getRange(0, habitsColors.length~/2).toList(),
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 5,
              children: habitsColors.map( (c) {
                return ColorSelectorCircle(backgroundColor: c, isSelected: (c == selectedColor), onTap: _handleTapOnColorSelector,);
              }, ).toList().getRange(habitsColors.length~/2, habitsColors.length).toList(),
            ),
          ],
        );
  }


  Widget _getDataSection(ColorScheme colors){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: MyInput(hintText: "Nombre del hábito", controller: _nameController),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: MyInput(hintText: "Descripción del hábito", controller: _descriptionController),
        )
      ],
    );
  }

  Row _getPositiveHabitSwitch() {
    return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SizedBox(width: 40,),
            Expanded(
              // width: 280,
              // color: Colors.amber,
              // height: 100,
              child: SwitchListTile(
                title: Text("Es un hábito positivo?", textAlign: TextAlign.start,),
                value: _isPositive,
                onChanged: (value) => setState(() { _isPositive = value; }),
                contentPadding: EdgeInsets.all(10),
                horizontalTitleGap: 1,
                
              ),
            ),
            // SizedBox(width: 40,),
          ],
        );
  }

  

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 110,
          child: TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("Cancelar"),
          ),
        ),
        SizedBox(
          width: 110,
          child: ElevatedButton(onPressed: _submit, child: Text("Crear")),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      
          child: Padding(
            
            padding: EdgeInsets.symmetric( vertical: 18, horizontal: 23),
            child: Column(
              children: [
                _buildTitle(),
                SizedBox(
                  height: 16,
                ),  
                Expanded(
                  // constraints: BoxConstraints(
                  //   maxHeight: constraints.maxHeight-150,
                  // ),
                  child: SingleChildScrollView(
                    // padding: EdgeInsets.fromLTRB(15, 30, 15, 30),
                    child: Column(
                      children: [
                        _buildContent(colors),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                _buildActions(),
              ],
                  ),
          ),

    );
  }

  Widget _createSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Text(title, style: Styles.sectionTitle.copyWith(fontSize: 16),)
    );
  }
}

class ColorSelectorCircle extends StatelessWidget {
  const ColorSelectorCircle({super.key, required this.backgroundColor, required this.isSelected, required this.onTap});
  
  final Color backgroundColor;
  final bool isSelected;
  final Function(Color) onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => onTap(backgroundColor),
      child: Stack(
        children: [
          CircleAvatar(backgroundColor: backgroundColor,),
          if (isSelected)
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: colors.onSecondary, width: 2),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ]
      ),
    );
  }
}

class MyInput extends StatefulWidget {
  const MyInput({super.key, required this.hintText, this.enabled = true, required this.controller});

  final String hintText;
  final TextEditingController controller;
  final bool enabled;

  @override
  State<MyInput> createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
  
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return TextField(
      controller: widget.controller,
      enabled: widget.enabled,
      decoration: InputDecoration(
        label: Text(widget.hintText, style: Styles.creationConfigItem.copyWith(color: colors.onSecondary.withAlpha(widget.enabled ? 200 : 100))),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: colors.onSecondary.withAlpha(50)), ),
        contentPadding: EdgeInsets.all(0),
      ),
    );
  }
}