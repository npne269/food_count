import 'package:flutter/material.dart';
import 'package:foodcount/colors.dart';

import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';
import 'package:iconify_flutter/icons/game_icons.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/tabler.dart';

class InfoCard extends StatefulWidget {
  const InfoCard({
    super.key,
    required this.title,
    required this.data,
    this.delete,
    this.increase,
  });

  // final ConsumedModel c;
  final String title;
  final List<double>? data;
  final Widget? delete;
  final Widget? increase;

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  List<Set> getAllTitles() {
    return [
      {
        "energy",
        const Iconify(
          Mdi.fire,
          color: Colors.red,
          size: 12,
        ),
        "K Cal"
      },
      {
        "protein",
        const Iconify(
          Tabler.meat,
          color: Colors.brown,
          size: 12,
        ),
        "g"
      },
      {
        "carbs",
        const Iconify(
          GameIcons.wheat,
          color: Colors.lightGreen,
          size: 12,
        ),
        "g"
      },
      {
        "fat",
        const Iconify(
          Ic.outline_water_drop,
          color: Colors.amber,
          size: 12,
        ),
        "g"
      },
      {
        "iron",
        const Iconify(
          Mdi.food_apple,
          color: Colors.red,
          size: 12,
        ),
        "g"
      },
      {
        "carotene",
        const Iconify(
          Mdi.carrot,
          color: Colors.orange,
          size: 12,
        ),
        "µg"
      },
      {
        "vitamin c",
        const Iconify(
          Fa6Solid.tablets,
          color: Colors.grey,
          size: 12,
        ),
        "mg"
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: widget.title.isEmpty ? 10 : 14.0,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.bgColor,
            AppColors.filledGrey,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.title.isNotEmpty) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
                widget.delete ?? const SizedBox()
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            widget.increase ?? const SizedBox(),
            const SizedBox(
              height: 10,
            ),
          ] else ...[
            const Divider(
              thickness: 1.2,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: getAllTitles().length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: width < 430 ? 3 : (width > 720 ? 6 : 5),
              mainAxisExtent: 60,
            ),
            itemBuilder: (context, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      getAllTitles()[index].elementAt(1),
                      const SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        getAllTitles()[index].first,
                        style: const TextStyle(
                          color: AppColors.lightFontGrey,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    gramToKg(
                        widget.data?[index] ?? 0, getAllTitles()[index].last),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }

  String gramToKg(double stringAsFixed, String unit) {
    // if (stringAsFixed > 500) {
    //   return "${(stringAsFixed / 1000.0).toStringAsFixed(1)} K$unit";
    // } else {
    return "${stringAsFixed.toStringAsFixed(1)} $unit";
    // }
  }
}
