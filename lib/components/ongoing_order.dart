import 'package:agencia_la/colors.dart';
import 'package:agencia_la/model/mock.dart';
import 'package:agencia_la/model/order.dart';
import 'package:flutter/material.dart';
import 'title.dart';

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
          child: OrderCard(
            order: Mock.orders[0],
          ),
        ),
      ],
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: AgenciaLaColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: AgenciaLaColors.primary,
                  backgroundImage: AssetImage(order.lanny.picture),
                  radius: 48,
                ),
                SizedBox(width: 24),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Lanny ${order.lanny.name}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AgenciaLaColors.foreground,
                        ),
                      ),
                      Text(
                        "${order.lanny.age} anos",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: AgenciaLaColors.foreground,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.phone),
                          SizedBox(width: 8),
                          Text(
                            order.lanny.phone,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AgenciaLaColors.foreground,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(width: 16),
                    Text(
                      "${order.date} às ${order.time}",
                      style: TextStyle(
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
                    Icon(Icons.access_time),
                    SizedBox(width: 16),
                    Text(
                      order.duration,
                      style: TextStyle(
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
                Icon(Icons.place),
                SizedBox(width: 16),
                Flexible(
                  child: Text(
                    order.address,
                    style: TextStyle(
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
}
