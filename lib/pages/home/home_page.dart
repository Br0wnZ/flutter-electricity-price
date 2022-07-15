import 'dart:io';

import 'package:electricity_price/custom_widgets/glass.dart';
import 'package:electricity_price/pages/home/home_viewmodel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../services/notification_service.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final String dateTime = DateFormat('d/M/y').format(new DateTime.now());

  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;
  ValueNotifier<bool> showNotification = ValueNotifier(false);
  ValueNotifier<int> selectedIndex = ValueNotifier(-1);

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1).animate(animation);
    animation.forward();
    _showTips();
  }

  Future<void> _showTips() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('firstTime') == null) {
      Future.delayed(Duration(seconds: 1), () {
        Fluttertoast.showToast(
          msg:
              '! Mantén presionado sobre la hora que desees para recibir una notificación',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue
        );
        prefs.setBool('firstTime', false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
      viewModelBuilder: () {
        final viewModel = HomeViewModel();
        return viewModel;
      },
      builder: (BuildContext context, model, Widget? child) {
        return FutureBuilder(
          future: _checkInternetConnection(),
          initialData: '',
          builder: (BuildContext context, AsyncSnapshot snap) {
            return snap.data.toString() == 'true'
                ? FutureBuilder(
                    future: model.loadData(),
                    initialData: [],
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      }
                      if (snapshot.hasData) {
                        return Scaffold(
                            backgroundColor: Colors.transparent,
                            // appBar: _buildAppBar(dateTime),
                            body: FadeTransition(
                              opacity: _fadeInFadeOut,
                              child: SafeArea(
                                  child: _nestedScroll(context, snapshot)),
                            ));
                      }
                      return Container();
                    },
                  )
                : Scaffold(
                    appBar: _buildAppBar(dateTime),
                    body: Center(
                      child: Text('Sin conexión a internet'),
                    ),
                    floatingActionButton: FloatingActionButton(
                        backgroundColor: Color(0xff141625),
                        child: Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                        onPressed: () => setState(() {})),
                  );
          },
        );
      },
    );
  }

  Future<bool> _checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  AppBar _buildAppBar(String dateTime) =>
      AppBar(elevation: 8.0, title: Text('Precio para $dateTime'));

  // ignore: todo
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

  NestedScrollView _nestedScroll(BuildContext context, AsyncSnapshot snapshot) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
                            image: AssetImage("assets/images/background.webp"),
                            colorFilter: ColorFilter.mode(
                              Colors.white.withOpacity(0.9),
                              BlendMode.modulate,
                            ),
                            fit: BoxFit.cover)),
                    child: Column(
                      children: [
                        _averagePrice(context, snapshot),
                        _minAndMaxPrice(context, snapshot),
                        _buildPriceChart(context, snapshot),
                      ],
                    ),
                  ),
                )),
          ),
        ];
      },
      body: Container(child: Builder(builder: (context) {
        return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background.webp"),
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.9),
                      BlendMode.modulate,
                    ),
                    fit: BoxFit.cover)),
            child: _hourlyPrices(context, snapshot));
      })),
    );
  }

  Widget _buildPriceChart(BuildContext context, AsyncSnapshot snapshot) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GlassMorphism(
          start: .9,
          end: .6,
          child: Column(children: [
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
                // labelDisplayMode: SparkChartLabelDisplayMode.high,
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
            )
          ]),
        ),
      );

  Widget _averagePrice(BuildContext context, AsyncSnapshot snapshot) => Padding(
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
                '${(snapshot.data[3]['price'] / 1000).toStringAsFixed(5)} €/kwh',
                style: TextStyle(fontSize: 24.0, color: Colors.lightBlue),
              )
            ],
          ),
        ),
      );

  Widget _minAndMaxPrice(BuildContext context, AsyncSnapshot snapshot) =>
      Padding(
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
                        '${(snapshot.data[1]['min'] / 1000).toStringAsFixed(5)} €/kwh',
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
                        style:
                            TextStyle(fontSize: 20.0, color: Color(0xff141625)),
                      ),
                      Text(
                        '${(snapshot.data[1]['max'] / 1000).toStringAsFixed(5)} €/kwh',
                        style: TextStyle(fontSize: 24.0, color: Colors.red),
                      ),
                      _formatHour(snapshot.data[1]['maxHour']),
                    ],
                  )
                ],
              ),
            )),
      );

  Widget _hourlyPrices(BuildContext context, AsyncSnapshot snapshot) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: GlassMorphism(
          start: .9,
          end: .6,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * .02,
                      top: MediaQuery.of(context).size.height * .01,
                      bottom: MediaQuery.of(context).size.height * .01),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Precio del Kw por horas')),
                ),
                Expanded(
                  child: Scrollbar(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data[0].length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buidItemList(snapshot.data, index);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  GestureDetector _buidItemList(dynamic data, int index) {
    return GestureDetector(
      onLongPress: () async {
        var result = await NotificationService().zonedScheduleNotification(
            1,
            int.parse(data[0][index].hour.split('-')[0]),
            'Hora de encenderlo todo',
            'El precio de la luz ahora es de ${(data[0][index].price / 1000).toStringAsFixed(5)} €/kwh');
        _showToastMessage(bool, result, data, index);
        selectedIndex.value = index;
        showNotification.value = true;
      },
      child: Container(
          height: MediaQuery.of(context).size.height * .04,
          color: data[0][index].price == data[1]['min']
              ? Colors.amber
              : Colors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Icon(
                  Icons.watch_later_outlined,
                  color: data[0][index].isCheap
                      ? Colors.green[500]
                      : Colors.red[300],
                ),
                _formatHour(data[0][index].hour),
                Text(
                  '${(data[0][index].price / 1000).toStringAsFixed(5)} €/kwh',
                  style: TextStyle(
                      color: data[0][index].isCheap
                          ? Colors.green[500]
                          : Colors.red[300]),
                ),
                Container()
              ],
            ),
          )),
    );
  }

  void _showToastMessage(bool, result, dynamic data, int index) =>
      Fluttertoast.showToast(
          msg: result == -1
              ? 'No puedes añadir una notificación en un tiempo pasado'
              : 'Notificación añadida con éxito para las ${data[0][index].hour.split('-')[0]}:00h',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);

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
