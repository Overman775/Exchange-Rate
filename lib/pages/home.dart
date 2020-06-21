import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/exchange_bloc.dart';
import '../style.dart';
import '../widgets/currency_item.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget buildLoading() {
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget buildError(BuildContext context, ExchangeError error) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
            iconSize: 50,
            icon: Icon(
              Icons.refresh,
            ),
            onPressed: () {
              //TODO: finis
              context.bloc<ExchangeBloc>().add(const GetExchange('USD'));
            }),
        Text(
          error.message,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red),
        )
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //load exchanges
    //TODO: finis
    context.bloc<ExchangeBloc>().add(const GetExchange('USD'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Header(),
        BlocBuilder<ExchangeBloc, ExchangeState>(
          builder: (BuildContext context, ExchangeState state) {
            if (state is ExchangeLoading) {
              return buildLoading();
            } else if (state is ExchangeLoaded) {
              return ExchangedContent(state);
            } else if (state is ExchangeError) {
              return buildError(context, state);
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    ));
  }
}

class ExchangedContent extends StatelessWidget {
  const ExchangedContent(this.data, {Key key}) : super(key: key);

  final ExchangeLoaded data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemCount: data.exchange.rates.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: Text(data.exchange.rates[index].key),
                  trailing:
                      Text(data.exchange.rates[index].value.toStringAsFixed(3)),
                ),
              );
            }));
  }
}

class Header extends StatelessWidget {
  Header({
    Key key,
  }) : super(key: key);

  final List<String> bases = <String>['USD', 'EUR', 'GBP'];

  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ClipPath(
          clipper: TopClipper(),
          child: Container(
            height: 250,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter,
                    stops: const <double>[
                  0.3,
                  1,
                  0.3
                ],
                    colors: <Color>[
                  Style.colorPrimary,
                  Style.colorAccent,
                  Style.colorPrimary,
                ])),
            child: Stack(
              children: <Widget>[
                PageView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: bases.length,
                    controller: _controller,
                    onPageChanged: (int page) {
                      context
                          .bloc<ExchangeBloc>()
                          .add(GetExchange(bases[page]));
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return CurrencyItem(bases[index]);
                    }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
