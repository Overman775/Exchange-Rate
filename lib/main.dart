import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/currency/currency_bloc.dart';
import 'bloc/exchange/exchange_bloc.dart';
import 'data/exchange_repository.dart';
import 'pages/home.dart';
import 'style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: <BlocProvider<dynamic>>[
          BlocProvider<ExchangeBloc>(
            create: (BuildContext context) =>
                ExchangeBloc(ExchangeRepositoryECB()),
          ),
          BlocProvider<CurrencyBloc>(
            create: (BuildContext context) => CurrencyBloc(),
          ),
        ],
        child: MaterialApp(
          title: 'Exhange',
          theme: ThemeData(
            primaryColor: Style.colorPrimary,
            accentColor: Style.colorAccent,
            disabledColor: Style.colorSubText,
            backgroundColor: Colors.white,
            textTheme: Typography.material2018()
                .englishLike
                .apply(bodyColor: Style.colorText),
          ),
          home: const Home(),
        ));
  }
}
