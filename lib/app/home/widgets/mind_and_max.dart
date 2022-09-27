import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electricity_price/app/custom_widgets/glass.dart';
import 'package:electricity_price/app/home/cubit/home_cubit.dart';

class MinAndMax extends StatelessWidget {
  const MinAndMax({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GlassMorphism(
          start: .9,
          end: .6,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Precio más bajo',
                      style:
                          TextStyle(fontSize: 20.0, color: Color(0xff141625)),
                    ),
                    Text(
                      '${(BlocProvider.of<HomeCubit>(context).state.minAndMax!.min! / 1000).toStringAsFixed(5)} €/kwh',
                      style: TextStyle(fontSize: 24.0, color: Colors.green),
                    ),
                    _formatHour(BlocProvider.of<HomeCubit>(context).state.minAndMax!.minHour!),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Precio más alto',
                      style:
                          TextStyle(fontSize: 20.0, color: Color(0xff141625)),
                    ),
                    Text(
                      '${(BlocProvider.of<HomeCubit>(context).state.minAndMax!.max! / 1000).toStringAsFixed(5)} €/kwh',
                      style: TextStyle(fontSize: 24.0, color: Colors.red),
                    ),
                    _formatHour(BlocProvider.of<HomeCubit>(context).state.minAndMax!.maxHour!),
                  ],
                )
              ],
            ),
          )),
    );
  }

  Text _formatHour(String hour) {
    var from = hour.split('-')[0];
    var to = hour.split('-')[1];
    return Text(
        '${hour.split('-')[0]}:00  ${_getTime(from)} - ${hour.split('-')[1]}:00  ${_getTime(to)}');
  }

  String _getTime(String hour) {
    return int.parse(hour) > 11 ? 'PM' : 'AM';
  }
}
