part of 'random_quote_cubit.dart';

enum RandomQuoteStatus { initial, loading, success, failure }

final class RandomQuoteState extends Equatable {
  const RandomQuoteState({this.status = RandomQuoteStatus.initial, this.quote});
  final RandomQuoteStatus status;
  final Quote? quote;

  @override
  List<Object> get props => [status];
}
