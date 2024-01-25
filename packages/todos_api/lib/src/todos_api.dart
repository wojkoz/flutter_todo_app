import 'package:todos_api/src/todo_model.dart';

/// {@template todos_api}
/// The interface and models for an API providing access to todos.
/// {@endtemplate}
abstract class TodosApi {
  /// {@macro todos_api}
  const TodosApi();

  /// Retrieve all `todo` items
  Stream<List<Todo>> getTodos();

  ///Save `todo` item
  ///or replace if exists
  Future<void> saveTodo(Todo todo);

  ///Delete `todo` item
  Future<void> deleteTodo(String id);

  ///Remove completed `todo` items
  Future<void> clearCompleted();

  ///Sets the `isCompleted` field to given value
  Future<int> completeAll({required bool isCompleted});
}
