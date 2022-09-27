import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electricity_price/app/custom_widgets/glass.dart';
import 'package:electricity_price/app/home/cubit/home_cubit.dart';


class AveragePrice extends StatelessWidget {
  const AveragePrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GlassMorphism(
        start: .9,
        end: .6,
        child: Column(
          children: [
            Text('Precio medio del día',
                style: TextStyle(fontSize: 24.0, color: Color(0xff141625))),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .2,
                  right: MediaQuery.of(context).size.width * .2,
                  bottom: MediaQuery.of(context).size.height * .001),
              child: Divider(
                color: Colors.black,
              ),
            ),
            Text(
              '${(BlocProvider.of<HomeCubit>(context).state.averagePriceModel!.price! / 1000).toStringAsFixed(5)} €/kwh',
              style: TextStyle(fontSize: 24.0, color: Colors.lightBlue),
            )
          ],
        ),
      ),
    );
  }
}
