// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/feature/todos_overview/bloc/todos_overview_bloc.dart';
import 'package:todo_app/feature/todos_overview/widgets/todo_list_tile.dart';
import 'package:todo_app/feature/todos_overview/widgets/todos_overview_filter_button.dart';
import 'package:todo_app/feature/todos_overview/widgets/todos_overview_option_button.dart';
import 'package:todo_app/l10n/l10n.dart';

class TodosOverviewView extends StatelessWidget {
  const TodosOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.todosOverviewAppBarTitle),
        actions: const [
          TodosOverviewFilterButton(),
          TodosOverviewOptionsButton(),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TodosOverviewBloc, TodosOverviewState>(
            listenWhen: (previous, current) => previous.status != current.status,
            listener: (context, state) {
              if (state.status == TodosOverviewStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(l10n.todosOverviewErrorSnackbarText),
                    ),
                  );
              }
            },
          ),
          BlocListener<TodosOverviewBloc, TodosOverviewState>(
            listenWhen: (previous, current) => previous.lastDeletedTodo != current.lastDeletedTodo && current.lastDeletedTodo != null,
            listener: (context, state) {
              final deletedTodo = state.lastDeletedTodo!;
              final messenger = ScaffoldMessenger.of(context);
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      l10n.todosOverviewTodoDeletedSnackbarText(
                        deletedTodo.title,
                      ),
                    ),
                    action: SnackBarAction(
                      label: l10n.todosOverviewUndoDeletionButtonText,
                      onPressed: () {
                        messenger.hideCurrentSnackBar();
                        context.read<TodosOverviewBloc>().add(const TodosOverviewUndoDeletionRequested());
                      },
                    ),
                  ),
                );
            },
          ),
        ],
        child: BlocBuilder<TodosOverviewBloc, TodosOverviewState>(
          builder: (context, state) {
            if (state.todos.isEmpty) {
              if (state.status == TodosOverviewStatus.loading) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (state.status != TodosOverviewStatus.success) {
                return const SizedBox();
              } else {
                return Center(
                  child: Text(
                    l10n.todosOverviewEmptyText,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              }
            }

            return CupertinoScrollbar(
              child: ListView(
                children: [
                  for (final todo in state.filteredTodos)
                    TodoListTile(
                      todo: todo,
                      onToggleCompleted: (isCompleted) {
                        context.read<TodosOverviewBloc>().add(
                              TodosOverviewTodoCompletionToggled(
                                todo: todo,
                                isCompleted: isCompleted,
                              ),
                            );
                      },
                      onDismissed: (_) {
                        context.read<TodosOverviewBloc>().add(TodosOverviewTodoDeleted(todo));
                      },
                      onTap: () {
                        // Navigator.of(context).push(
                        //   EditTodoPage.route(initialTodo: todo),
                        // );
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
