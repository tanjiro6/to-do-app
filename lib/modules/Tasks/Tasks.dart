import 'package:application/shared/cuibt/cuibt.dart';
import 'package:application/shared/cuibt/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';

class Taskss extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).tasks;

        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => BuldTaskItem(index),
            separatorBuilder: (context, index) => Container(
              width: double.infinity,
              height: 1,
              color: Colors.amberAccent,
            ),
            itemCount: tasks.length,
          ),
        );
      },
    );
  }
}
