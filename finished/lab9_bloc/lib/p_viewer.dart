import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab4_5/main.dart';
import 'package:lab4_5/second_page.dart';
import 'package:flutter/services.dart';

import 'PageBlock.dart';

class PviewerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<PageBloc>(
        create: (context) => PageBloc(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Agency Demo'),
          ),
          body: BlocBuilder<PageBloc, PageState>(
            builder: (context, state) {
              return PageView(
                controller: PageController(initialPage: state.currentPage),
                children: <Widget>[
                  MyHomePage(),
                  PagePricing(price1: '\$53/hr', price2: '\$45/hr', price3: '\$60/hr'),
                ],
                onPageChanged: (pageIndex) {
                  context.read<PageBloc>().add(NextPageEvent());
                },
              );
            },
          ),
        ),
      ),
    );
  }
}