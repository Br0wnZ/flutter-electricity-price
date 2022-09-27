import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:electricity_price/app/home/cubit/home_cubit.dart';
import 'package:electricity_price/app/custom_widgets/glass.dart';


class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GlassMorphism(
        start: .9,
        end: .6,
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * .01,
                    bottom: MediaQuery.of(context).size.height * .02),
                alignment: Alignment.centerLeft,
                child: Text('Evolución del precio para hoy')),
            Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * .03),
              height: MediaQuery.of(context).size.height * 0.1,
              child: SfSparkLineChart(
                color: Color(0xff141625),
                trackball: const SparkChartTrackball(
                    activationMode: SparkChartActivationMode.tap),
                highPointColor: Colors.red,
                lowPointColor: Colors.green,
                marker: const SparkChartMarker(
                    borderWidth: 3,
                    size: 5,
                    shape: SparkChartMarkerShape.circle,
                    displayMode: SparkChartMarkerDisplayMode.all,
                    color: Color(0xff141625)),
                axisLineWidth: 0,
                data: BlocProvider.of<HomeCubit>(context).state.chartPrices!,
              ),
            )
          ],
        ),
      ),
    );
  }
}
