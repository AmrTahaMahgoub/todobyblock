import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todobyblock/bloc_cubic/cubit.dart';
import 'package:todobyblock/bloc_cubic/states.dart';
import 'package:todobyblock/essentialmodelforall.dart';

class ArchivedLayouts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Todocubit, Todostates>(
      listener: ((context, state) {}),
      builder: ((context, state) {
        Todocubit cubit = BlocProvider.of<Todocubit>(context);
        return ConditionalBuilder(
          fallback: (BuildContext context) {
            return Center(child: Text('DATA HAS BEEN DELETED'));
          },
          condition: cubit.archivedtask.length > 0,
          builder: (BuildContext context) {
            return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Essentialmodel(cubit.archivedtask[index]),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemCount: cubit.archivedtask.length);
          },
        );
      }),
    );
  }
}
