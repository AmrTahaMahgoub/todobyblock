import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todobyblock/bloc_cubic/cubit.dart';
import 'package:todobyblock/bloc_cubic/states.dart';
import 'package:todobyblock/essentialmodelforall.dart';

class TaskLayouts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Todocubit, Todostates>(
      listener: ((context, state) {}),
      builder: ((context, state) {
        Todocubit cubit = BlocProvider.of(context);
        return ConditionalBuilder(
          builder: (BuildContext context) {
            return Text(' DATA HAS BEEN DELETED');
          },
          condition: cubit.newtasks.length > 0,
          fallback: (BuildContext context) {
            return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Essentialmodel(cubit.newtasks[index]),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemCount: cubit.newtasks.length);
          },
        );
      }),
    );
  }
}
