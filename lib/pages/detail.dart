import 'package:exchange_rate/bloc/exchange_detail/exchange_detail_bloc.dart';
import 'package:exchange_rate/widgets/exchange_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(this.base, this.currency, {Key key}) : super(key: key);

  final String base;
  final String currency;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildError(BuildContext context, ExchangeDetailError error) {
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
              context.bloc<ExchangeDetailBloc>().add(GetExchangeDetail(
                  base: widget.base, currency: widget.currency));
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.base}/${widget.currency}'),
      ),
      body: BlocBuilder<ExchangeDetailBloc, ExchangeDetailState>(
        builder: (BuildContext context, ExchangeDetailState state) {
          Widget result;
          if (state is ExchangeDetailLoading) {
            result = buildLoading();
          } else if (state is ExchangeDetailLoaded) {
            return ExchangeChart();
          } else if (state is ExchangeDetailError) {
            result = buildError(context, state);
          } else {
            result = const SizedBox.shrink();
          }

          return result;
        },
      ),
    );
  }
}
