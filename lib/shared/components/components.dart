import 'package:flutter/material.dart';

import '../cuibt/cuibt.dart';

//button
Widget defaultButton({
  //par default et peut changer
  double width = double.infinity,
  Color background = Colors.blue,
  //obliger de remplire
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      color: background,
      child: MaterialButton(
        onPressed: function(),
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
//TextFormeFIeld
var tasks = AppCubit.get(BuildContext).tasks;

Widget defaultFormField({
  TextEditingController? controller,
  required TextInputType type,
  Function? onSubmit,
  required Function onChange,
  Function? validate,
  required dynamic text,
  required IconData prefix,
  required Function ontap,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onChanged: onChange(),
      onTap: (() => ontap),
      decoration: InputDecoration(
        labelText: text,
        prefixIcon: Icon(
          prefix,
        ),
        border: OutlineInputBorder(),
      ),
    );
Widget BuldTaskItem(int index) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.amberAccent,
            radius: 40,
            child: Text(
              tasks[index]['date'],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tasks[index]['title'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                tasks[index]['time'],
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          )
        ],
      ),
    );
