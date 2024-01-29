import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_repository/random_quote_repository.dart';
import 'package:todo_app/feature/random_quotes/cubit/random_quote_cubit.dart';
import 'package:todo_app/feature/random_quotes/screen/random_quote_view.dart';

class RandomQuoteScreen extends StatelessWidget {
  const RandomQuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RandomQuoteCubit(
        repository: RandomQuoteRepository(dio: DioInitlializer().dio),
      ),
      child: const RandomQuoteView(),
    );
  }
}
