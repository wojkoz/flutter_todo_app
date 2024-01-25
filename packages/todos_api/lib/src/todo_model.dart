// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:todos_api/src/json_map.dart';
import 'package:uuid/uuid.dart';

part 'todo_model.g.dart';

@immutable
@JsonSerializable()
class Todo extends Equatable {
  Todo({required this.title, String? id, this.description = '', this.isCompleted = false})
      : assert(
          id == null || id.isNotEmpty,
          'id must be null or not empty',
        ),
        id = id ?? const Uuid().v4();

  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  static Todo fromJson(JsonMap json) => _$TodoFromJson(json);

  JsonMap toJson() => _$TodoToJson(this);

  @override
  List<Object?> get props => [id, title, description, isCompleted];
}
