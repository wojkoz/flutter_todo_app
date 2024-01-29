// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quote _$QuoteFromJson(Map<String, dynamic> json) => Quote(
      json['content'] as String,
      json['author'] as String,
    );

Map<String, dynamic> _$QuoteToJson(Quote instance) => <String, dynamic>{
      'content': instance.content,
      'author': instance.author,
    };
