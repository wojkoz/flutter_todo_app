// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:random_quote_api/random_quotes_api.dart';

/// {@template random_image_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
abstract class RandomQuotesApi {
  /// {@macro random_quotes_api}
  const RandomQuotesApi();

  /// Get random [Quote]
  Future<ResponseWrapper<Quote>> getRandomQuote();

  /// Url for getting quotes
  static const String baseUrl = 'https://api.quotable.io/quotes/random';
}

class ResponseWrapper<T> {
  ResponseWrapper({required this.data, required this.failed, required this.code, required this.message});

  final T? data;
  final bool failed;
  final int? code;
  final String? message;
}
