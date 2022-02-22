import 'package:electricity_price/services/api_service.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../service_locator.dart';

class HomePage extends StatelessWidget {
  final HttpService _httpService = getIt<HttpService>();

  final String dateTime = DateFormat('d/M/y').format(new DateTime.now());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _httpService.getAllData(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[Expanded(child: _loadShimmer(context))]);
        }
        if (snapshot.hasData) {
          return Scaffold(
            appBar: _buildAppBar(dateTime),
            body: _buildBody(context, snapshot),
          );
        }
        return Container();
      },
    );
  }

  AppBar _buildAppBar(String dateTime) =>
      AppBar(elevation: 8.0, title: Text('Precio para $dateTime'));

  Shimmer _loadShimmer(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        enabled: true,
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * .01)),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .03),
              height: MediaQuery.of(context).size.height * 0.1,
              color: Colors.white,
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * .02)),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .02),
              height: MediaQuery.of(context).size.height * 0.1,
              color: Colors.white,
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * .02)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .03),
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * .4,
                  color: Colors.white,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.height * .02)),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .03),
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * .4,
                  color: Colors.white,
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * .02)),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .03),
              height: MediaQuery.of(context).size.height * 0.5,
              color: Colors.white,
            ),
          ],
        ),
      );

  Container _buildBody(BuildContext context, AsyncSnapshot snapshot) =>
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Colors.grey[400]!,
              Colors.grey[300]!,
              Colors.grey[200]!,
              Colors.grey[100]!,
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * .01)),
            ..._buildPriceChart(context, snapshot),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * .02)),
            _averagePrice(context, snapshot),
            Container(
              height: MediaQuery.of(context).size.height * .01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .02),
              child: _minAndMaxPrice(context, snapshot),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.02,
                    vertical: MediaQuery.of(context).size.height * 0.02),
                child: Text('Precio del Kwh por horas: ',
                    style: TextStyle(fontSize: 20.0, color: Color(0xff141625))),
              ),
            ),
            _hourlyPrices(context, snapshot),
            Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom))
          ],
        ),
      );

  List<Widget> _buildPriceChart(BuildContext context, AsyncSnapshot snapshot) =>
      [
        Container(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * .01,
                bottom: MediaQuery.of(context).size.height * .02),
            alignment: Alignment.centerLeft,
            child: Text('Evolución del precio para hoy')),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .03),
          height: MediaQuery.of(context).size.height * 0.1,
          child: SfSparkLineChart(
            color: Color(0xff141625),
            trackball: const SparkChartTrackball(
                activationMode: SparkChartActivationMode.tap),
            labelDisplayMode: SparkChartLabelDisplayMode.high,
            highPointColor: Colors.red,
            lowPointColor: Colors.green,
            marker: const SparkChartMarker(
                borderWidth: 3,
                size: 5,
                shape: SparkChartMarkerShape.circle,
                displayMode: SparkChartMarkerDisplayMode.all,
                color: Color(0xff141625)),
            axisLineWidth: 0,
            data: <double>[...snapshot.data[2]],
          ),
        ),
      ];

  Column _averagePrice(BuildContext context, AsyncSnapshot snapshot) => Column(
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
            '${snapshot.data[3]['price'] / 1000} €/kvh',
            style: TextStyle(fontSize: 24.0, color: Colors.lightBlue),
          )
        ],
      );

  Row _minAndMaxPrice(BuildContext context, AsyncSnapshot snapshot) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Precio más bajo',
                style: TextStyle(fontSize: 20.0, color: Color(0xff141625)),
              ),
              Text(
                '${snapshot.data[1]['min'] / 1000} €/kvh',
                style: TextStyle(fontSize: 24.0, color: Colors.green),
              ),
              _formatHour(snapshot.data[1]['minHour']),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Precio más alto',
                style: TextStyle(fontSize: 20.0, color: Color(0xff141625)),
              ),
              Text(
                '${(snapshot.data[1]['max'] / 1000).toStringAsFixed(5)} €/kvh',
                style: TextStyle(fontSize: 24.0, color: Colors.red),
              ),
              _formatHour(snapshot.data[1]['maxHour']),
            ],
          )
        ],
      );

  Container _hourlyPrices(BuildContext context, AsyncSnapshot snapshot) =>
      Container(
        child: Expanded(
          child: Scrollbar(
            child: ListView.builder(
              itemCount: snapshot.data[0].length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    height: MediaQuery.of(context).size.height * .04,
                    color:
                        snapshot.data[0][index].price == snapshot.data[1]['min']
                            ? Colors.amber
                            : Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Icon(
                          Icons.watch_later_outlined,
                          color: snapshot.data[0][index].isCheap
                              ? Colors.green[500]
                              : Colors.red[300],
                        ),
                        _formatHour(snapshot.data[0][index].hour),
                        Text(
                          '${(snapshot.data[0][index].price / 1000).toStringAsFixed(5)} €/kwh',
                          style: TextStyle(
                              color: snapshot.data[0][index].isCheap
                                  ? Colors.green[500]
                                  : Colors.red[300]),
                        ),
                        Container()
                      ],
                    ));
              },
            ),
          ),
        ),
      );

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
