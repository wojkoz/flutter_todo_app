// ignore_for_file: public_member_api_docs

import 'package:todos_api/todos_api.dart';

class TodosRepository {
  /// {@macro todos_repository}
  const TodosRepository({
    required TodosApi todosApi,
  }) : _todosApi = todosApi;

  final TodosApi _todosApi;

  /// Provides a [Stream] of all todos.
  Stream<List<Todo>> getTodos() => _todosApi.getTodos();

  /// Saves a [todo].
  ///
  /// If a [todo] with the same id already exists, it will be replaced.
  Future<void> saveTodo(Todo todo) => _todosApi.saveTodo(todo);

  /// Deletes the `todo` with the given id.
  Future<void> deleteTodo(String id) => _todosApi.deleteTodo(id);

  /// Deletes all completed todos.
  Future<void> clearCompleted() => _todosApi.clearCompleted();

  /// Sets the `isCompleted` state of all todos to the given value.
  Future<int> completeAll({required bool isCompleted}) => _todosApi.completeAll(isCompleted: isCompleted);
}
