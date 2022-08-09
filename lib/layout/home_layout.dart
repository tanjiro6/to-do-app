import 'package:application/layout/home_layout.dart';
import 'package:application/modules/Done/done.dart';
import 'package:application/modules/archived/archived.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sqflite/sqflite.dart';
import '../modules/Tasks/Tasks.dart';
import '../shared/components/components.dart';
import '../shared/network/local/dataBase.dart';
import 'home_layout.dart';
import 'package:intl/intl.dart';

class HomeLayoute extends StatefulWidget {
  const HomeLayoute({Key? key}) : super(key: key);

  @override
  State<HomeLayoute> createState() => _HomeLayouteState();
}

Database? database;
int currentIndex = 0;
List<Widget> screen = [
  Tasks(),
  Done(),
  Archived(),
];
List<String> titles = [
  'New Tasks',
  'Done Tasks',
  'Archived Tasks',
];
var titleController = TextEditingController();
var timeController = TextEditingController();
var dateController = TextEditingController();

bool isBottomSheetShone = false;
IconData febIcon = Icons.edit;

class _HomeLayouteState extends State<HomeLayoute> {
  var ScaffoldKey = GlobalKey<ScaffoldState>();
  var FormKey = GlobalKey<FormState>();
  @override
  void initState() {
    CreateDatabase();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: ScaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text(
          titles[currentIndex],
        ),
      ),
      body: screen[currentIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent,
        onPressed: () {
          if (isBottomSheetShone) {
            if (FormKey.currentState!.validate()) {
              InsertToDatabase(
                title: titleController.text,
                time: timeController.text,
                date: dateController.text,
              ).then((value) {
                Navigator.pop(context);
                isBottomSheetShone = false;
                febIcon = Icons.edit;
                setState(() {});
              });
            }
          } else {
            ScaffoldKey.currentState
                ?.showBottomSheet(
                  (context) => Container(
                    padding: const EdgeInsets.all(20.0),
                    color: Colors.grey[100],
                    child: Form(
                      key: FormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          defaultFormField(
                            prefix: Icons.title_outlined,
                            text: 'Tasks Title',
                            type: TextInputType.text,
                            validate: (dynamic value) {
                              if (value.isEmpty) {
                                return 'Title must not be Empty';
                              }
                            },
                            controller: titleController,
                            onChange: () {},
                            ontap: () {},
                          ),
                          const SizedBox(height: 15.0),
                          TextFormField(
                            controller: timeController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefix: Icon(Icons.watch),
                              hintText: 'Task Time',
                              labelText: 'Time',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'must be not empty';
                              }
                              return null;
                            },
                            onTap: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                timeController.text =
                                    value!.format(context).toString();
                                print(value.format(context));
                              });
                            },
                          ),
                          const SizedBox(height: 15.0),
                          TextFormField(
                            controller: dateController,
                            decoration:const InputDecoration(
                              prefix: Icon(Icons.calendar_month),
                              border: OutlineInputBorder(),
                              hintText: 'Task Date',
                              labelText: 'date',
                            ),
                            keyboardType: TextInputType.text,
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse(
                                    "2023-07-17T03:18:31.177769-04:00"),
                              ).then((value) {
                                dateController.text =
                                    DateFormat.yMMMd().format(value!);
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'must be not empty';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .closed
                .then((value) {
              isBottomSheetShone = true;
              setState(() {});
              febIcon = Icons.add;
            });
            isBottomSheetShone = true;
            setState(() {});
            febIcon = Icons.add;
          }
        },
        child: Icon(
          color: Colors.white,
          febIcon,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 50.0,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
          print(index);
        },
        backgroundColor: Colors.amberAccent,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            label: "Tasks",
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.check_box_outline_blank_outlined,
            ),
            label: "Done",
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
            ),
            label: "Archived",
          ),
        ],
      ),
    );
  }
}
