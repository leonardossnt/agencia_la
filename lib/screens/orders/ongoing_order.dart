import 'package:agencia_la/colors.dart';
import 'package:agencia_la/model/lanny.dart';
import 'package:agencia_la/model/order.dart';
import 'package:agencia_la/network/auth.dart';
import 'package:agencia_la/network/database.dart';
import 'package:agencia_la/screens/components/title.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class OngoingOrders extends StatelessWidget {
  const OngoingOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTitle("Em andamento"),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: OngoingOrderList(),
        ),
      ],
    );
  }
}

class OngoingOrderList extends StatefulWidget {
  const OngoingOrderList({Key? key}) : super(key: key);

  @override
  State<OngoingOrderList> createState() => _OngoingOrderListState();
}

class _OngoingOrderListState extends State<OngoingOrderList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Database.getOngoingOrdersByClient(Auth.getCurrentUser()?.uid ?? ""),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var ongoingOrders = snapshot.data as List<Order>;
            var orderList = <Widget>[];
            for (Order order in ongoingOrders) {
              orderList.add(OrderCard(order: order));
            }
            return Column(children: orderList);
          } else {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 60),
              child: Text(
                "Nenhum pedido em andamento!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                ),
              ),
            );
          }
        } else {
          return Column(
            children: const [
              SizedBox(height: 18),
              CircularProgressIndicator(),
            ],
          );
        }
      },
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: AgenciaLaColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _lannyInfo(order.lanny),
            SizedBox(height: 24),
            Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today,
                        color: AgenciaLaColors.foreground),
                    SizedBox(width: 16),
                    Text(
                      "${DateFormat('d/MM').format(DateTime.parse(order.date))} às ${order.time}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AgenciaLaColors.foreground,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 24),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: AgenciaLaColors.foreground,
                    ),
                    SizedBox(width: 8),
                    Text(
                      order.duration,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AgenciaLaColors.foreground,
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.place,
                  color: AgenciaLaColors.foreground,
                ),
                SizedBox(width: 16),
                Flexible(
                  child: Text(
                    order.address,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AgenciaLaColors.foreground,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _lannyInfo(Lanny? lanny) {
    if (lanny == null) {
      return Text("Aguardando uma Lanny...",
        style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AgenciaLaColors.foreground,
      ),);
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: AgenciaLaColors.inputBackground,
            backgroundImage: AssetImage('assets/images/logo_teal.png'),
            foregroundImage: NetworkImage(lanny.picture),
            radius: 52,
          ),
          SizedBox(width: 24),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Lanny ${lanny.name}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: AgenciaLaColors.foreground,
                  ),
                ),
                Text(
                  "${lanny.age()} anos",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AgenciaLaColors.foreground,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phone,
                      color: AgenciaLaColors.foreground,
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      onTap: () =>
                      {
                        UrlLauncher.launchUrl(
                            Uri.parse('tel:${lanny.phone}'))
                      },
                      child: Text(
                        lanny.phone,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AgenciaLaColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
