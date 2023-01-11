import 'dart:typed_data';

import 'package:flutter/material.dart' as fl;
import 'package:foodcount/model/food_model.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';
import 'package:iconify_flutter/icons/game_icons.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/tabler.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
// import 'package:flutter/services.dart' show rootBundle;

Future<Uint8List> makePdf(
    List<ConsumedModel> model, List<double> total, String fullName) async {
  final pdf = Document();
  // final imageLogo = MemoryImage(
  //     (await rootBundle.load('assets/technical_logo.png'))
  //         .buffer
  //         .asUint8List());

  pdf.addPage(
    Page(
      build: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fullName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Table(
              border: TableBorder.all(color: PdfColor.fromHex("#000")),
              columnWidths: {
                0: const FixedColumnWidth(90),
                1: const FixedColumnWidth(70),
                2: const FixedColumnWidth(70),
                3: const FixedColumnWidth(70),
                4: const FixedColumnWidth(70),
                5: const FixedColumnWidth(70),
                6: const FixedColumnWidth(70),
                7: const FixedColumnWidth(70),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: PdfColor.fromHex("#117D8088"),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Foods",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: PdfColors.white,
                        ),
                      ),
                    ),
                    ...List.generate(getAllTitles().length, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          getAllTitles()[index].first +
                              "\n" +
                              "(${getAllTitles()[index].last})",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: PdfColors.white,
                          ),
                        ),
                      );
                    })
                  ],
                ),
                ...List.generate(
                  model.length,
                  (index) => TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          model[index].foodEat?.name ?? "",
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      ...List.generate(
                          model[index]
                              .foodEat!
                              .components
                              .getItems(model[index].amount)
                              .length, (ind) {
                        double data = model[index]
                            .foodEat!
                            .components
                            .getItems(model[index].amount)[ind];
                        return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              data.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ));
                      })
                    ],
                  ),
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ...List.generate(total.length, (index) {
                      double data = total[index];
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          data.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ],
            ),
          ],
        );
      },
    ),
  );
  return pdf.save();
}

List<Set> getAllTitles() {
  return [
    {
      "energy",
      const Iconify(
        Mdi.fire,
        color: fl.Colors.red,
        size: 12,
      ),
      "K Cal"
    },
    {
      "protein",
      const Iconify(
        Tabler.meat,
        color: fl.Colors.brown,
        size: 12,
      ),
      "g"
    },
    {
      "carbs",
      const Iconify(
        GameIcons.wheat,
        color: fl.Colors.lightGreen,
        size: 12,
      ),
      "g"
    },
    {
      "fat",
      const Iconify(
        Ic.outline_water_drop,
        color: fl.Colors.amber,
        size: 12,
      ),
      "g"
    },
    {
      "iron",
      const Iconify(
        Mdi.food_apple,
        color: fl.Colors.red,
        size: 12,
      ),
      "g"
    },
    {
      "carotene",
      const Iconify(
        Mdi.carrot,
        color: fl.Colors.orange,
        size: 12,
      ),
      "µg"
    },
    {
      "vitamin c",
      const Iconify(
        Fa6Solid.tablets,
        color: fl.Colors.grey,
        size: 12,
      ),
      "mg"
    },
  ];
}
