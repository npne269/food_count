import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:foodcount/colors.dart';
import 'package:foodcount/model/food_model.dart';
import 'package:foodcount/my_drawer.dart';
import 'package:foodcount/result_page.dart';
import 'package:foodcount/widget/info_card.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';
import 'package:iconify_flutter/icons/game_icons.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/tabler.dart';
import 'package:iconify_flutter/icons/wpf.dart';

// widget

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ConsumedModel> consumedModelList = [];
  final _formKey = GlobalKey<FormState>();

  List<Set> getAllTitles() {
    return [
      {
        "energy",
        const Iconify(
          Mdi.fire,
          color: Colors.red,
          size: 12,
        ),
      },
      {
        "protein",
        const Iconify(
          Tabler.meat,
          color: Colors.brown,
          size: 12,
        ),
      },
      {
        "carbs",
        const Iconify(
          GameIcons.wheat,
          color: Colors.lightGreen,
          size: 12,
        ),
      },
      {
        "fat",
        const Iconify(
          Ic.outline_water_drop,
          color: Colors.amber,
          size: 12,
        ),
      },
      {
        "iron",
        const Iconify(
          Mdi.food_apple,
          color: Colors.red,
          size: 12,
        ),
      },
      {
        "carotene",
        const Iconify(
          Mdi.carrot,
          color: Colors.orange,
          size: 12,
        ),
      },
      {
        "vitamin c",
        const Iconify(
          Fa6Solid.tablets,
          color: Colors.grey,
          size: 12,
        ),
      },
    ];
  }

  FoodModel? eaten;
  final amountController = TextEditingController();

  ConsumedModel? getConsumedModelOrNull(int id) {
    List<ConsumedModel> cc = consumedModelList
        .where((element) => element.foodEat?.id == id)
        .toList();
    if (cc.isNotEmpty) {
      return cc.first;
    }

    return null;
  }

  addConsumedModel(ConsumedModel c) {
    ConsumedModel? oldConsumedModel = getConsumedModelOrNull(c.foodEat!.id);
    if (oldConsumedModel != null) {
      int index = consumedModelList
          .indexWhere((element) => element.foodEat?.id == c.foodEat!.id);
      consumedModelList[index].increaseAmount(amt: c.amount);
    } else {
      consumedModelList.add(c);
    }
    amountController.clear();
    eaten = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        leading: Builder(builder: (context) {
          return InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Iconify(
                Bx.menu_alt_left,
              ),
            ),
          );
        }),
        title: const Text(
          "You And Food",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(23.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TypeAheadFormField<FoodModel>(
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                    errorMaxLines: 2,
                    filled: true,
                    fillColor: AppColors.filledGrey,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.filledGrey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.filledGrey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.filledGrey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Select Food From List",
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.hintGrey,
                    ),
                    suffixIcon: const Iconify(
                      Wpf.search,
                      size: 50,
                      color: AppColors.hintGrey,
                    ),
                    suffixIconConstraints: const BoxConstraints(
                      maxHeight: 24,
                      maxWidth: 50,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                  ),
                ),
                suggestionsCallback: (a) async {
                  List<FoodModel> list = await FoodModel.getListFoodItems();
                  return list.where((e) => e.name.contains(a)).toList();
                },
                itemBuilder: (context, FoodModel suggestion) {
                  return ListTile(
                    tileColor: AppColors.filledGrey,
                    title: Text(
                      suggestion.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                loadingBuilder: ((context) {
                  return const ListTile(
                    tileColor: AppColors.filledGrey,
                    title: Text(
                      "Loading...",
                      style: TextStyle(
                        color: AppColors.hintGrey,
                      ),
                    ),
                  );
                }),
                noItemsFoundBuilder: (context) {
                  return const ListTile(
                    title: Text("No Food Found"),
                  );
                },
                onSuggestionSelected: (picked) {
                  // setState(() {
                  //   eaten = picked;
                  // });
                  addConsumedModel(
                    ConsumedModel(
                      foodEat: picked,
                      amount: 1.0,
                    ),
                  );
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Select the Food";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              if (consumedModelList.isEmpty) ...[
                // Expanded(
                //   child: Center(
                //     child: Container(
                //       height: 200,
                //       padding: const EdgeInsets.symmetric(horizontal: 23.0),
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(10.0),
                //       ),
                //       child: const Text(
                //         "Add some food",
                //       ),
                //     ),
                //   ),
                // ),
              ] else ...[
                Expanded(
                  child: ListView.separated(
                    itemCount: consumedModelList.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10.0,
                    ),
                    itemBuilder: (context, index) {
                      ConsumedModel c = consumedModelList[index];
                      return InfoCard(
                        title: c.foodEat?.name ?? "",
                        data: c.foodEat?.components.getItems(c.amount),
                        delete: IconButton(
                          onPressed: () {
                            setState(() {
                              consumedModelList.removeAt(index);
                            });
                          },
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.red,
                          ),
                        ),
                        increase: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  c.decreaseAmount();
                                  if (c.amount == 0) {
                                    consumedModelList.removeAt(index);
                                  }
                                });
                              },
                              child: const Iconify(
                                Ic.baseline_remove_circle,
                                color: AppColors.hintGrey,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0),
                                            child: Text(
                                              "${c.foodEat?.name}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          TextField(
                                            keyboardType: TextInputType.number,
                                            onSubmitted: ((value) {
                                              Navigator.pop(context);
                                              setState(() {
                                                c.addAmount(
                                                    double.parse(value));
                                              });
                                            }),
                                            cursorColor: AppColors.primary,
                                            decoration: InputDecoration(
                                              errorMaxLines: 2,
                                              filled: true,
                                              fillColor: AppColors.filledGrey,
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color:
                                                        AppColors.filledGrey),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color:
                                                        AppColors.filledGrey),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color:
                                                        AppColors.filledGrey),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              hintText: "Enter amount in gm",
                                              hintStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.hintGrey,
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0, vertical: 8.0),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Text("${c.amount.toInt()} g"),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  c.increaseAmount();
                                });
                              },
                              child: const Iconify(
                                Ic.baseline_add_circle,
                                color: AppColors.hintGrey,
                              ),
                            )
                          ],
                        ),
                      );
                      // return Container(
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 20.0,
                      //     vertical: 14.0,
                      //   ),
                      //   decoration: BoxDecoration(
                      //     gradient: const LinearGradient(
                      //       colors: [
                      //         AppColors.bgColor,
                      //         AppColors.filledGrey,
                      //       ],
                      //       begin: Alignment.topCenter,
                      //       end: Alignment.bottomCenter,
                      //     ),
                      //     borderRadius: BorderRadius.circular(10.0),
                      //   ),
                      //   child: Column(
                      //     children: [
                      //       Row(
                      //         children: [
                      //           Expanded(
                      //             child: Text(
                      //               "${c.foodEat?.name}",
                      //               style: const TextStyle(
                      //                 fontWeight: FontWeight.w500,
                      //                 fontSize: 18,
                      //               ),
                      //             ),
                      //           ),
                      // IconButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       consumedModelList.removeAt(index);
                      //     });
                      //   },
                      //   icon: const Icon(
                      //     Icons.delete_outline_rounded,
                      //     color: Colors.red,
                      //   ),
                      // )
                      //         ],
                      //       ),
                      //       const SizedBox(
                      //         height: 20,
                      //       ),
                      // Row(
                      //   children: [
                      //     InkWell(
                      //       onTap: () {
                      //         setState(() {
                      //           c.decreaseAmount();
                      //           if (c.amount == 0) {
                      //             consumedModelList.removeAt(index);
                      //           }
                      //         });
                      //       },
                      //       child: const Iconify(
                      //         Ic.baseline_remove_circle,
                      //         color: AppColors.hintGrey,
                      //       ),
                      //     ),
                      //     InkWell(
                      //       onTap: () {
                      //         showDialog(
                      //           context: context,
                      //           builder: (context) {
                      //             return Dialog(
                      //               child: Column(
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                 mainAxisSize: MainAxisSize.min,
                      //                 children: [
                      //                   const SizedBox(
                      //                     height: 10,
                      //                   ),
                      //                   Padding(
                      //                     padding: const EdgeInsets.only(
                      //                         left: 16.0),
                      //                     child: Text(
                      //                       "${c.foodEat?.name}",
                      //                       style: const TextStyle(
                      //                         fontWeight: FontWeight.w500,
                      //                         fontSize: 16,
                      //                       ),
                      //                     ),
                      //                   ),
                      //                   TextField(
                      //                     keyboardType:
                      //                         TextInputType.number,
                      //                     onSubmitted: ((value) {
                      //                       Navigator.pop(context);
                      //                       setState(() {
                      //                         c.addAmount(
                      //                             double.parse(value));
                      //                       });
                      //                     }),
                      //                     cursorColor: AppColors.primary,
                      //                     decoration: InputDecoration(
                      //                       errorMaxLines: 2,
                      //                       filled: true,
                      //                       fillColor:
                      //                           AppColors.filledGrey,
                      //                       border: OutlineInputBorder(
                      //                         borderSide:
                      //                             const BorderSide(
                      //                                 color: AppColors
                      //                                     .filledGrey),
                      //                         borderRadius:
                      //                             BorderRadius.circular(
                      //                                 10.0),
                      //                       ),
                      //                       enabledBorder:
                      //                           OutlineInputBorder(
                      //                         borderSide:
                      //                             const BorderSide(
                      //                                 color: AppColors
                      //                                     .filledGrey),
                      //                         borderRadius:
                      //                             BorderRadius.circular(
                      //                                 10.0),
                      //                       ),
                      //                       focusedBorder:
                      //                           OutlineInputBorder(
                      //                         borderSide:
                      //                             const BorderSide(
                      //                                 color: AppColors
                      //                                     .filledGrey),
                      //                         borderRadius:
                      //                             BorderRadius.circular(
                      //                                 10.0),
                      //                       ),
                      //                       errorBorder:
                      //                           OutlineInputBorder(
                      //                         borderSide:
                      //                             const BorderSide(
                      //                                 color: Colors.red),
                      //                         borderRadius:
                      //                             BorderRadius.circular(
                      //                                 10.0),
                      //                       ),
                      //                       hintText:
                      //                           "Enter amount in gm",
                      //                       hintStyle: const TextStyle(
                      //                         fontSize: 16,
                      //                         fontWeight: FontWeight.w400,
                      //                         color: AppColors.hintGrey,
                      //                       ),
                      //                       contentPadding:
                      //                           const EdgeInsets
                      //                               .symmetric(
                      //                         horizontal: 16.0,
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             );
                      //           },
                      //         );
                      //       },
                      //       child: Container(
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 4.0, vertical: 8.0),
                      //         margin: const EdgeInsets.symmetric(
                      //           horizontal: 8.0,
                      //         ),
                      //         decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           borderRadius: BorderRadius.circular(6.0),
                      //         ),
                      //         child: Text("${c.amount.toInt()} g"),
                      //       ),
                      //     ),
                      //     InkWell(
                      //       onTap: () {
                      //         setState(() {
                      //           c.increaseAmount();
                      //         });
                      //       },
                      //       child: const Iconify(
                      //         Ic.baseline_add_circle,
                      //         color: AppColors.hintGrey,
                      //       ),
                      //     )
                      //   ],
                      // ),
                      //       const SizedBox(
                      //         height: 20,
                      //       ),
                      //       GridView.builder(
                      //         padding: EdgeInsets.zero,
                      //         shrinkWrap: true,
                      //         itemCount: getAllTitles().length,
                      //         gridDelegate:
                      //             SliverGridDelegateWithFixedCrossAxisCount(
                      //           crossAxisCount:
                      //               width < 430 ? 3 : (width > 720 ? 6 : 5),
                      //           mainAxisExtent: 60,
                      //         ),
                      //         itemBuilder: (context, index) {
                      //           return Column(
                      //             mainAxisSize: MainAxisSize.min,
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               Row(
                      //                 mainAxisSize: MainAxisSize.min,
                      //                 children: [
                      //                   getAllTitles()[index].last,
                      //                   const SizedBox(
                      //                     width: 4.0,
                      //                   ),
                      //                   Text(
                      //                     getAllTitles()[index].first,
                      //                     style: const TextStyle(
                      //                       color: AppColors.lightFontGrey,
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //               Text(
                      //                 gramToKg(c.foodEat?.components
                      //                         .getItems(c.amount)[index] ??
                      //                     0),
                      //                 style: const TextStyle(
                      //                   fontSize: 16,
                      //                   fontWeight: FontWeight.w600,
                      //                 ),
                      //               ),
                      //             ],
                      //           );
                      //         },
                      //       )
                      //     ],
                      //   ),
                      // );
                    },
                  ),
                )
              ],
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: consumedModelList.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 54,
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0))),
                  onPressed: () {
                    if (consumedModelList.isNotEmpty) {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ResultPage(
                          consumedList: consumedModelList,
                        );
                      }));
                    }
                  },
                  child: const Text(
                    "CALCULATE",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  String gramToKg(double stringAsFixed) {
    if (stringAsFixed > 500) {
      return "${(stringAsFixed / 1000.0).toStringAsFixed(1)} Kg";
    } else {
      return "${stringAsFixed.toStringAsFixed(1)}g";
    }
  }
}
