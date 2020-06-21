import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/exchange_bloc.dart';
import 'data/exchange_repository.dart';
import 'pages/home.dart';
import 'style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Style.colorPrimary,
        accentColor: Style.colorAccent,
        disabledColor: Style.colorSubText,
        backgroundColor: Colors.white,
        textTheme: Typography.material2018()
            .englishLike
            .apply(bodyColor: Style.colorText),
      ),
      home: BlocProvider<ExchangeBloc>(
        create: (BuildContext context) => ExchangeBloc(ExchangeRepositoryECB()),
        child: const Home(),
      ),
    );
  }
}
