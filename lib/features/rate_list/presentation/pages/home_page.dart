import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc/ratelist_bloc.dart';
import '../../../../injection_container.dart';
import 'dart:math' as math;

import '../widgets/loading_shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  String generateItemTitle(String src, String divider) {
    String newStr = '';
    int step = 3;
    for (int i = 0; i < src.length; i += step) {
      newStr += src.substring(i, math.min(i + step, src.length));
      if (i + step < src.length) newStr += divider;
    }
    return newStr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => sl<RatelistBloc>()..add(GetRateList()),
        child: SingleChildScrollView(
            child: BlocBuilder<RatelistBloc, RatelistState>(
          builder: (context, state) {
            return state is Empty
                ? const Center(
                    child: Text(
                      "Please check your internet connectivity\nFailed to get data!",
                      textAlign: TextAlign.center,
                    ),
                  )
                : listViewBuilder(state);
          },
        )),
      ),
    );
  }

  Widget listViewBuilder(RatelistState state) {
    late int itemCountLength;
    if (state is Loading) {
      itemCountLength = state.fakeLength;
    } else if (state is Loaded) {
      itemCountLength = state.rateList.list.length;
    } else {
      itemCountLength = 0;
    }
    return Container(
      padding: const EdgeInsets.all(8),
      height: MediaQuery.sizeOf(context).height,
      child: ListView.builder(
        itemCount: itemCountLength,
        itemBuilder: (context, index) {
          double height = 60;
          if (state is Loading) {
            return LoadingShimmer(height: height);
          } else if (state is Loaded) {
            return Container(
              height: height,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8)),
              child: listViewItems(state, index),
            );
          }
          return null;
        },
      ),
    );
  }

  ListTile listViewItems(Loaded state, int index) {
    return ListTile(
      leading:
          Image.asset('assets/Images/${state.rateList.list[index].symbol}.png'),
      title: Text(generateItemTitle(state.rateList.list[index].symbol, '/')),
      trailing: Text(state.rateList.list[index].price.toStringAsFixed(4)),
    );
  }
}
