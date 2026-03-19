import 'package:flutter/material.dart';
import 'package:habit_tracker_app/controllers/daily_habits_controller.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key, required this.controller});

  final DailyHabitsController controller;

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {

  int progress = 0;

  Future<int?> changeProgress(BuildContext context, int target) async {
    TextEditingController textEditingController = TextEditingController();

    String? result = await showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Editar progreso"),
        content: TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: "Ingrese nuevo valor entre 0 y $target",
            contentPadding: EdgeInsets.all(5),
          ),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, textEditingController.text);
            },
            child: Text("Aceptar"),
          ),
        ],
      );
    },);

    return int.tryParse(result ?? "");
  }

  Future<int?> changeProgressWithValidation(BuildContext context, int target) async {
    final _formKey = GlobalKey<FormState>();
    TextEditingController controller = TextEditingController();

    String? result = await showDialog(context: context,
      builder: (context) {
        return AlertDialog(
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Nuevo valor de progreso",
              ),
              validator: (value) {
                if (value == null || value.isEmpty){
                  return "Campo obligatorio";
                }
                int? n = int.tryParse(value);
                if (n == null){
                  return "Debe ser un número";
                }

                if (n < 0 || n > target){
                  return "El valor debe estar entre 0 y $target";
                }

                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pop(context, controller.text);
                }

              },
              child: Text("Aceptar"),
            ),
          ],
        );
      }
    );

    return int.tryParse(result ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // child: Text("Statistics page!"),
      // child: AboutDialog(
        
      //   children: [
      //   TextField()
      //   ],
      // ),
      child: Column(
        children: [
          TextButton(
            onPressed: () async {
              int? resultado = await changeProgressWithValidation(context, 4);
              if (resultado != null){
                setState(() {
                  progress = resultado;
                });
              }
            },
            child: Text("Abrir dialog")
          ),
          Text("Progreso: $progress"),
          TextButton(
            onPressed: () {
              
              
            },
            child: Text("Probar cosas"),
          )
        ],
      ),

      
    );
  }
}