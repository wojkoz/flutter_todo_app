// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/feature/random_quotes/cubit/random_quote_cubit.dart';
import 'package:todo_app/l10n/l10n.dart';

class RandomQuoteView extends StatelessWidget {
  const RandomQuoteView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final status = context.select((RandomQuoteCubit cubit) => cubit.state.status);
    final quote = context.select((RandomQuoteCubit cubit) => cubit.state.quote);
    final mediaQuerySize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.randomQuoteScreenTitle,
        ),
      ),
      body: switch (status) {
        RandomQuoteStatus.initial => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _getQuoteButton(l10n, context, isFirstQuote: true),
            ],
          ),
        RandomQuoteStatus.loading => SizedBox(
            width: mediaQuerySize.width,
            height: mediaQuerySize.height,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CircularProgressIndicator()],
            ),
          ),
        RandomQuoteStatus.success => SizedBox(
            width: mediaQuerySize.width,
            height: mediaQuerySize.height,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _textView(
                    quote?.content,
                  ),
                  _textView(quote?.author),
                  const SizedBox(
                    height: 30,
                  ),
                  _getQuoteButton(l10n, context, isFirstQuote: false),
                ],
              ),
            ),
          ),
        RandomQuoteStatus.failure => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _textView(l10n.randomQuoteScreenError),
                  _getQuoteButton(l10n, context, isFirstQuote: true),
                ],
              ),
            ],
          ),
      },
    );
  }

  Widget _getQuoteButton(AppLocalizations l10n, BuildContext context, {required bool isFirstQuote}) {
    return OutlinedButton(
      onPressed: () => {context.read<RandomQuoteCubit>().getQuote()},
      child: Text(isFirstQuote ? l10n.randomQuoteScreenGetFirst : l10n.randomQuoteScreenGetAnother),
    );
  }

  Widget _textView(String? text) {
    return Text(
      text ?? '',
      textAlign: TextAlign.justify,
    );
  }
}
