import 'package:flutter/material.dart';
import 'package:forms_app/presentation/blocs/counter_cubit/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitCounterScreen extends StatelessWidget {
  const CubitCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CounterCubit(), child: const _CubitCounterView());
  }
}

class _CubitCounterView extends StatelessWidget {
  const _CubitCounterView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //watch = solo observa, no hace cambios
    final counterState = context.watch<CounterCubit>().state;

    //read = puede leer y hacer cambios
    void increaseBy(BuildContext context, value) {
      context.read<CounterCubit>().increaseBy(value);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cubit Counter: ${counterState.transactionCount}'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<CounterCubit>().reset();
              },
              icon: const Icon(Icons.refresh_outlined))
        ],
      ),
      body: Center(
        child: BlocBuilder<CounterCubit, CounterState>(
          buildWhen: (previous, current) => current.counter != previous.counter,
          builder: (context, state) {
            return Text('Counter value: ${state.counter}');
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              heroTag: '1',
              child: const Text('+3'),
              onPressed: () => increaseBy(context, 3)),
          const SizedBox(height: 15),
          FloatingActionButton(
              heroTag: '1',
              child: const Text('+2'),
              onPressed: () => increaseBy(context, 2)),
          const SizedBox(height: 15),
          FloatingActionButton(
              heroTag: '1',
              child: const Text('+1'),
              onPressed: () => increaseBy(context, 1)),
        ],
      ),
    );
  }
}
