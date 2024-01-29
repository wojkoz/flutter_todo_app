// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:random_quote_api/random_quotes_api.dart';
import 'package:random_quote_repository/random_quote_repository.dart';

part 'random_quote_state.dart';

class RandomQuoteCubit extends Cubit<RandomQuoteState> {
  RandomQuoteCubit({required this.repository}) : super(const RandomQuoteState());

  final RandomQuoteRepository repository;

  Future<void> getQuote() async {
    emit(const RandomQuoteState(status: RandomQuoteStatus.loading));
    final responseWrapper = await repository.getRandomQuote();

    if (responseWrapper.failed) {
      print(responseWrapper.message);
      emit(const RandomQuoteState(status: RandomQuoteStatus.failure));
    }

    if (responseWrapper.data == null) {
      emit(const RandomQuoteState(status: RandomQuoteStatus.failure));
    } else {
      emit(RandomQuoteState(status: RandomQuoteStatus.success, quote: responseWrapper.data));
    }
  }
}
