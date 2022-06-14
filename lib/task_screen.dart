import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todobyblock/bloc_cubic/cubit.dart';
import 'Textformmoadel.dart';
import 'bloc_cubic/states.dart';

class TaskScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var Scaffoldkey = GlobalKey<ScaffoldState>();
//  bool isPressed = false;
  var newtitleController = TextEditingController();
  var newtimeController = TextEditingController();
  var newdateController = TextEditingController();
  String? newtextform;
  String? text2;

  @override
  Widget build(BuildContext context) {
    //try later;
    //cubit.createdatabase(); created also but in main was the best;

    return BlocProvider(
      create: (BuildContext context) => Todocubit()..createdatabase(),
      child: BlocConsumer<Todocubit, Todostates>(
        listener: ((context, state) {
          if (state is Inserttododatabase) {
            Navigator.pop(context);
          }
        }),
        builder: ((context, state) {
          Todocubit cubit = BlocProvider.of<Todocubit>(context);
          return Scaffold(
            key: Scaffoldkey,
            body: ConditionalBuilder(
                condition: true,
                builder: (context) => cubit.layouts[cubit.Currentindex],
                fallback: (context) =>
                    Center(child: CircularProgressIndicator())),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.Currentindex,
                elevation: 200,
                onTap: (index) {
                  cubit.changecurrentstate(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    label: 'TASK',
                    icon: Icon(Icons.menu),
                  ),
                  BottomNavigationBarItem(
                    label: 'DONE',
                    icon: Icon(Icons.today_outlined),
                  ),
                  BottomNavigationBarItem(
                    label: 'ARCHIEVE',
                    icon: Icon(Icons.archive_outlined),
                  ),
                ]),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  cubit.toggleIspressed(cubit.isPressed);
                  if (cubit.isPressed) {
                    Scaffoldkey.currentState
                        ?.showBottomSheet(
                          (context) => Container(
                            padding: EdgeInsets.all(15.0),
                            color: Colors.grey[500],
                            width: double.infinity,
                            child: SingleChildScrollView(
                              child: Form(
                                key: formkey,
                                child: Column(
                                  children: [
                                    TextFormModel(
                                        data: 'YOUR TASK PLEASE',
                                        label: 'TASK',
                                        keybordtype: TextInputType.text,
                                        onchange: (String value) {
                                          newtextform = value;
                                        },
                                        titlecontroller: newtitleController,
                                        validation: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'please enter task';
                                          }
                                          return null;
                                        }),
                                    TextFormModel(
                                      data: ' THE TIME YOU WANT',
                                      label: 'TIME',
                                      titlecontroller: newtimeController,
                                      ontapped: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then(
                                          (TimeOfDay? value) =>
                                              newtimeController.text =
                                                  value!.format(context),
                                        );
                                      },
                                      keybordtype: TextInputType.datetime,
                                      validation: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'please enter  time';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormModel(
                                      data: ' THE DATE YOU WANT',
                                      label: 'DATE',
                                      titlecontroller: newdateController,
                                      keybordtype: TextInputType.datetime,
                                      ontapped: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.parse(
                                                    '2022-08-02'))
                                            .then(
                                          (DateTime? value) =>
                                              newdateController.text =
                                                  DateFormat()
                                                      .add_yMMMEd()
                                                      .format(value!),
                                        );
                                      },
                                      validation: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'enter the date';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .closed
                        .then((value) => {
                              cubit.toggleIspressed(cubit.isPressed),
                            });
                  } else {
                    if (formkey.currentState!.validate()) {
                      cubit.insertDataBase(
                          task: newtitleController.text,
                          time: newtimeController.text,
                          date: newdateController.text);
                    }
                  }
                },
                child: cubit.isPressed ? Icon(Icons.add) : Icon(Icons.edit)),
            appBar: AppBar(
              title: Center(
                child: Text('${cubit.titles[cubit.Currentindex]}'),
              ),
            ),
          );
        }),
      ),
    );
  }
}
