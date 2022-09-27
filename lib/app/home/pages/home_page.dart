import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:electricity_price/app/home/cubit/home_cubit.dart';
import 'package:electricity_price/app/home/cubit/home_state.dart';
import 'package:electricity_price/app/home/repositories/price_repository.dart';
import 'package:electricity_price/app/home/widgets/average_price.dart';
import 'package:electricity_price/app/home/widgets/chart.dart';
import 'package:electricity_price/app/home/widgets/mind_and_max.dart';
import 'package:electricity_price/app/home/widgets/price_llist.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit(PriceRepository(RepositoryProvider.of<Dio>(context)))
            ..loadPrices(),
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light
              .copyWith(statusBarColor: Theme.of(context).primaryColor),
          child: SafeArea(
            child: MainContent(),
          ),
        ),
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  const MainContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStateCubit>(
      builder: (context, state) => state.loading
          ? Center(child: CircularProgressIndicator())
          : NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    forceElevated: true,
                    elevation: 8.0,
                    expandedHeight: MediaQuery.of(context).size.height * .4,
                    pinned: true,
                    floating: true,
                    automaticallyImplyLeading: false,
                    snap: false,
                    flexibleSpace: FlexibleSpaceBar(
                      title: innerBoxIsScrolled
                          ? Text('Precio Luz', textScaleFactor: 1)
                          : Text(''),
                      centerTitle: true,
                      background: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/background.webp"),
                                  colorFilter: ColorFilter.mode(
                                    Colors.white.withOpacity(0.9),
                                    BlendMode.modulate,
                                  ),
                                  fit: BoxFit.cover)),
                          child: Column(
                            children: [
                              AveragePrice(),
                              MinAndMax(),
                              Chart(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: Container(
                child: Builder(
                  builder: (context) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/background.webp"),
                            colorFilter: ColorFilter.mode(
                              Colors.white.withOpacity(0.9),
                              BlendMode.modulate,
                            ),
                            fit: BoxFit.cover),
                      ),
                      child: HourlyPrices(),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
