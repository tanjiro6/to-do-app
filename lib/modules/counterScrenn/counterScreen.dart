import 'package:application/modules/counterScrenn/cuibt.dart';
import 'package:application/modules/counterScrenn/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CounterCuibt(),
        child: BlocConsumer<CounterCuibt, CounterState>(
          listener: (context, state) {
            if (state is CounterInitialState) {
              print("inital State");
            }
            if (state is CounterMinusState) {
              print("Munis State  ${state.Counter}");
            }

            if (state is CounterPlassState) {
              print("Plass State   ${state.Counter}");
            }
          },
          builder: (context, state) {
            print('build was called');
            return Scaffold(
              body: SafeArea(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          CounterCuibt.get(context).minus();
                        },
                        child: Container(
                          child: const Text(
                            "---",
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Text("${CounterCuibt.get(context).counter}",
                          style: const TextStyle(
                            fontSize: 40,
                          )),
                      const SizedBox(
                        width: 40,
                      ),
                      GestureDetector(
                        onTap: () {
                          CounterCuibt.get(context).plass();
                        },
                        child: const Text(
                          "+++",
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
