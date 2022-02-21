import 'package:electricity_price/services/api_service.dart';
import 'package:flutter/material.dart';

import '../../service_locator.dart';

class HomePage extends StatelessWidget {
  final HttpService _httpService = getIt<HttpService>();

  final List<dynamic> _data = [];

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
              title: Text('Precio Luz'),
            ),
            body: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: snapshot.data[index].isCheap
                          ? Colors.green[100]
                          : Colors.red[100],
                      child: ListTile(
                        title: _formatHour(snapshot.data[index].hour),
                        subtitle: Text('${snapshot.data[index].price} €/Mwh'),
                      ),
                    );
                  },
                )),
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
