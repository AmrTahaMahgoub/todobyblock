import 'package:flutter/material.dart';
import 'bloc_cubic/cubit.dart';

class Essentialmodel extends StatelessWidget {
  Essentialmodel(this.task);
  Map task = {};

  @override
  Widget build(BuildContext context) {
    Todocubit cubit = Todocubit.get(context);

    return Dismissible(
      key: Key(task['id'].toString()),
      child: Container(
        color: Colors.grey,
        padding: EdgeInsets.all(18.0),
        child: Row(
// crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40.0,
              backgroundColor: Colors.lightBlueAccent,
              child: Text('${task['time']}'),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${task['title']}'),
                  Text('${task['date']}'),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  cubit.updatetasks(status: 'done', id: task['id']);
                },
                icon: Icon(
                  Icons.done,
                  color: Colors.tealAccent,
                )),
            SizedBox(
              width: 15,
            ),
            IconButton(
                onPressed: () {
                  cubit.updatetasks(status: 'archived', id: task['id']);
                },
                icon: Icon(
                  Icons.archive_outlined,
                  color: Colors.black54,
                )),
          ],
        ),
      ),
      onDismissed: (direction) {
        cubit.deletetasks(id: task['id']);
      },
    );
  }
}
