import 'package:application/shared/cuibt/cuibt.dart';
import 'package:application/shared/cuibt/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/components/components.dart';
import 'package:intl/intl.dart';

class HomeLayoute extends StatelessWidget {
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit()..createDatabase(),
        child: BlocConsumer<AppCubit, AppState>(
          listener: (BuildContext context, AppState state) {
            if (state is AppInsertDatabaseState) {
              Navigator.pop(context);
            }
          },
          builder: (BuildContext context, AppState state) {
            AppCubit cubit = AppCubit.get(context);

            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                backgroundColor: Colors.amberAccent,
                title: Text(
                  cubit.titles[cubit.currentIndex],
                ),
              ),
              body: state is AppGetDatabaseLoadingState
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : cubit.screen[cubit.currentIndex],
              floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.amberAccent,
                  child: Icon(
                    color: Colors.white,
                    cubit.febIcon,
                  ),
                  onPressed: () {
                    if (cubit.isBottomSheetShone) {
                      if (formKey.currentState!.validate()) {
                        cubit.InsertToDatabase(
                          title: titleController.text,
                          time: timeController.text,
                          date: dateController.text,
                        );
                      } else {
                        scaffoldKey.currentState!
                            .showBottomSheet(
                              (context) => Container(
                                padding: const EdgeInsets.all(20.0),
                                color: Colors.grey[100],
                                child: Form(
                                  key: formKey,
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
                                            timeController.text = value!
                                                .format(context)
                                                .toString();
                                            print(value.format(context));
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 15.0),
                                      TextFormField(
                                        controller: dateController,
                                        decoration: const InputDecoration(
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
                                            //  dateController.text =
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
                          AppCubit.get(context).changeBottomSheetState(
                            isShow: false,
                            icon: Icons.edit,
                          );
                        });

                        AppCubit.get(context).changeBottomSheetState(
                          isShow: true,
                          icon: Icons.add,
                        );
                      }
                    }
                  }),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                elevation: 50.0,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                backgroundColor: Colors.amberAccent,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined),
                    label: "Tasks",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.check_box_outline_blank_outlined,
                    ),
                    label: "Done",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu,
                    ),
                    label: "Archived",
                  ),
                ],
              ),
            );
          },
        ));
  }
}
