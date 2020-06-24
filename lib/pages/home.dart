import 'dart:ui';

import 'package:exchange_rate/widgets/dot_indicator.dart';
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
    return const Center(
      child: CircularProgressIndicator(),
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
      body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 250.0,
              floating: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Header(),
              ),
            ),
            BlocBuilder<ExchangeBloc, ExchangeState>(
              builder: (BuildContext context, ExchangeState state) {
                Widget result;
                if (state is ExchangeLoading) {
                  result = buildLoading();
                } else if (state is ExchangeLoaded) {
                  return ExchangedSliverContent(state);
                } else if (state is ExchangeError) {
                  result = buildError(context, state);
                } else {
                  result = const SizedBox.shrink();
                }
                return SliverFillRemaining(
                    hasScrollBody: false, fillOverscroll: true, child: result);
              },
            ),
          ]),
    );
  }
}

class ExchangedSliverContent extends StatelessWidget {
  const ExchangedSliverContent(this.data, {Key key}) : super(key: key);

  final ExchangeLoaded data;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverFixedExtentList(
        itemExtent: 60.0,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text(data.exchange.rates[index].key),
                trailing:
                    Text(data.exchange.rates[index].value.toStringAsFixed(3)),
              ),
            );
          },
          childCount: data.exchange.rates.length,
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  Header({
    Key key,
  }) : super(key: key);

  final List<String> bases = <String>['USD', 'EUR', 'GBP'];

  static const Duration _kDuration = Duration(milliseconds: 300);
  static const Cubic _kCurve = Curves.ease;

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
              alignment: Alignment.center,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                          iconSize: 30,
                          icon: Icon(
                            Icons.arrow_left,
                            color: Colors.white,
                          ),
                          onPressed: () {}),
                      const Spacer(),
                      IconButton(
                          iconSize: 30,
                          icon: Icon(
                            Icons.arrow_right,
                            color: Colors.white,
                          ),
                          onPressed: () {})
                    ],
                  ),
                ),
                Positioned(
                    bottom: 16.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: DotsIndicator(
                          controller: _controller,
                          itemCount: 3,
                          indexPage: 0,
                          onPageSelected: (int page) {
                            _controller.animateToPage(
                              page,
                              duration: _kDuration,
                              curve: _kCurve,
                            );
                          },
                        ),
                      ),
                    ))
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
