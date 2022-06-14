import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todobyblock/bloc_cubic/cubit.dart';
import 'package:todobyblock/bloc_cubic/states.dart';
import 'package:todobyblock/essentialmodelforall.dart';
import 'constants.dart';

class DoneLayouts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Todocubit, Todostates>(
      listener: ((context, state) {}),
      builder: ((context, state) {
        Todocubit cubit = BlocProvider.of(context);
        return ConditionalBuilder(
          condition: cubit.donetask.length > 0,
          fallback: (BuildContext context) {
            return Text(' DATA HAS BEEN DELETED');
          },
          builder: (BuildContext context) {
            return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Essentialmodel(cubit.donetask[index]),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemCount: cubit.donetask.length);
          },
        );
      }),
    );
  }
}
