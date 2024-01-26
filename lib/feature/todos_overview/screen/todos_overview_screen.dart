import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/feature/todos_overview/bloc/todos_overview_bloc.dart';
import 'package:todo_app/feature/todos_overview/screen/todos_overview_view.dart';
import 'package:todos_repository/todos_repository.dart';

class TodosOverviewScreen extends StatelessWidget {
  const TodosOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosOverviewBloc(
        todosRepository: context.read<TodosRepository>(),
      )..add(const TodosOverviewSubscriptionRequested()),
      child: const TodosOverviewView(),
    );
  }
}
