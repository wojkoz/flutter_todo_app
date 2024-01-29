// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars, omit_local_variable_types

import 'package:dio/dio.dart';
import 'package:random_quote_api/random_quotes_api.dart';

/// {@template random_image_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class RandomQuoteRepository extends RandomQuotesApi {
  /// {@macro random_image_repository}
  const RandomQuoteRepository({required this.dio});

  final Dio dio;

  @override
  Future<ResponseWrapper<Quote>> getRandomQuote() async {
    try {
      final Response<List<dynamic>> response = await dio.get(RandomQuotesApi.baseUrl);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return ResponseWrapper(
          data: Quote.fromJson(response.data?[0] as Map<String, dynamic>),
          failed: false,
          code: response.statusCode,
          message: response.statusMessage,
        );
      }
      return ResponseWrapper(data: null, failed: true, code: response.statusCode, message: response.statusMessage);
    } on Exception catch (_, e) {
      return ResponseWrapper(data: null, failed: true, code: null, message: e.toString());
    }
  }
}
