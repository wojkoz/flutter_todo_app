// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quote_model.g.dart';

@JsonSerializable()
class Quote extends Equatable {
  const Quote(this.content, this.author);

  factory Quote.fromJson(Map<String, dynamic> json) {
    return _$QuoteFromJson(json);
  }

  final String content;
  final String author;

  @override
  List<Object?> get props => [content, author];
}
