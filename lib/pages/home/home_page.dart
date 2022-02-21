import 'package:electricity_price/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../service_locator.dart';

class HomePage extends StatelessWidget {
  final HttpService _httpService = getIt<HttpService>();

  String formatter = DateFormat('d/M/y').format(new DateTime.now());
  List<dynamic> get data => data;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _httpService.getData(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              elevation: 8.0,
              title: Text(
                  'Precio medio: ${snapshot.data[2]['price']} €/Mvh'),
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .02),
                      child: Text('$formatter'),
                    )
                  ],
            ),
            body: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  color: Colors.blue[200],
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.02,
                        vertical: MediaQuery.of(context).size.height * 0.02),
                    child: Text(
                        'Precio más bajo: ${snapshot.data[1]['min']} €/Mvh',
                        style: TextStyle(fontSize: 24.0)),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  color: Colors.blue[500],
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.02,
                        vertical: MediaQuery.of(context).size.height * 0.02),
                    child: Text(
                        'Precio más alto: ${snapshot.data[1]['max']} €/Mvh',
                        style: TextStyle(fontSize: 24.0)),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.02,
                        vertical: MediaQuery.of(context).size.height * 0.02),
                    child: Text('Precio por tramos horarios: ',
                        style: TextStyle(fontSize: 24.0)),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      if (index <= 23)
                        return Container(
                          color: snapshot.data[0][index].price ==
                                  snapshot.data[1]['min']
                              ? Colors.amber
                              : snapshot.data[0][index].isCheap
                                  ? Colors.green[500]
                                  : Colors.red[300],
                          child: ListTile(
                            title: _formatHour(snapshot.data[0][index].hour),
                            subtitle: Text(
                              '${snapshot.data[0][index].price} €/Mwh',
                            ),
                          ),
                        );
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
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
