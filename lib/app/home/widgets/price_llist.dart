import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:electricity_price/app/custom_widgets/glass.dart';
import 'package:electricity_price/app/home/cubit/home_cubit.dart';
import 'package:electricity_price/app/services/notification_service.dart';
import 'package:electricity_price/app/home/models/min_and_max_model.dart';
import 'package:electricity_price/app/home/models/price_model.dart';

class HourlyPrices extends StatelessWidget {
  const HourlyPrices({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          setNotification(BlocProvider.of<HomeCubit>(context).state.minAndMax!),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Padding(
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
                        itemCount: BlocProvider.of<HomeCubit>(context)
                            .state
                            .priceList
                            .length,
                        itemBuilder: (BuildContext context, int index) {
                          return PriceItemList(
                            prices: BlocProvider.of<HomeCubit>(context)
                                .state
                                .priceList,
                            minAndMax: BlocProvider.of<HomeCubit>(context)
                                .state
                                .minAndMax!,
                            index: index,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> setNotification(MinAndMaxModel minAndMax) async {
    await NotificationService().zonedScheduleNotification(
        2,
        int.parse(minAndMax.minHour!.split('-')[0]),
        'Tenemos buenas noticias',
        'El precio de la luz ahora durante la próxima hora será el más barato de hoy. ${double.parse((minAndMax.min! / 1000).toStringAsFixed(5))} €/kwh');
  }
}

class PriceItemList extends StatelessWidget {
  final List<PriceModel> prices;
  final MinAndMaxModel minAndMax;
  final int index;
  const PriceItemList({
    Key? key,
    required this.minAndMax,
    required this.prices,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> showNotification = ValueNotifier(false);
    ValueNotifier<int> selectedIndex = ValueNotifier(-1);
    return GestureDetector(
      onLongPress: () async {
        var result = await NotificationService().zonedScheduleNotification(
            1,
            int.parse(prices[index].hour!.split('-')[0]),
            'Hora de encenderlo todo',
            'El precio de la luz ahora es de ${(prices[index].price! / 1000).toStringAsFixed(5)} €/kwh');

        _showToastMessage(result, prices, index);
        selectedIndex.value = index;
        showNotification.value = true;
      },
      child: Container(
        height: MediaQuery.of(context).size.height * .04,
        color: prices[index].price == minAndMax.min
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
                color: prices[index].isCheap!
                    ? Colors.green[500]
                    : Colors.red[300],
              ),
              _formatHour(prices[index].hour!),
              Text(
                '${(prices[index].price! / 1000).toStringAsFixed(5)} €/kwh',
                style: TextStyle(
                  color: prices[index].isCheap!
                      ? Colors.green[500]
                      : Colors.red[300],
                ),
              ),
              Container()
            ],
          ),
        ),
      ),
    );
  }

  void _showToastMessage(dynamic result, List<PriceModel> prices, int index) =>
      Fluttertoast.showToast(
        msg: result == -1
            ? 'No puedes añadir una notificación en un tiempo pasado'
            : 'Notificación añadida con éxito para las ${prices[index].hour!.split('-')[0]}:00h',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
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
