import 'package:flutter/material.dart';
import 'package:foodcount/colors.dart';
import 'package:foodcount/model/food_model.dart';

class ViewAllProducts extends StatefulWidget {
  const ViewAllProducts({Key? key}) : super(key: key);

  @override
  State<ViewAllProducts> createState() => _ViewAllProductsState();
}

class _ViewAllProductsState extends State<ViewAllProducts> {
  List<FoodModel> list = [];

  bool isLoading = true;
  int _columnIndex = 0;
  bool _sortAscending = true;

  toogleisLoading(bool val) {
    setState(() {
      isLoading = val;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    list = await FoodModel.getListFoodItems();
    toogleisLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        foregroundColor: Colors.black,
        backgroundColor: AppColors.bgColor,
      ),
      // body: FutureBuilder<List<FoodModel>>(
      //     future: FoodModel.getListFoodItems(),
      //     builder: (context, snapshot) {
      //       if (!snapshot.hasData) {
      //         return const Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       }
      //       if (snapshot.hasError) {
      //         return Center(
      //           child: Text("${snapshot.error}"),
      //         );
      //       }
      //       List<FoodModel> list = snapshot.data ?? [];
      //       return;
      //     }),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 23, vertical: 10.0),
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    sortColumnIndex: _columnIndex,
                    sortAscending: _sortAscending,
                    columns: [
                      "Food",
                      "Energy",
                      "Protein",
                      "Carbohydrate",
                      "Fat",
                      "Iron",
                      "Carotene",
                      "Vitamin c"
                    ]
                        .map(
                          (e) => DataColumn(
                            label: Text(e),
                            onSort: (columnIndex, ascending) {
                              setState(() {
                                _sortAscending = ascending;
                                _columnIndex = columnIndex;
                                _sortList(columnIndex);
                              });
                            },
                          ),
                        )
                        .toList(),
                    rows: list.map(
                      (model) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                model.name,
                              ),
                            ),
                            DataCell(
                              Text(
                                "${model.components.energy}",
                              ),
                            ),
                            DataCell(
                              Text(
                                "${model.components.protein}",
                              ),
                            ),
                            DataCell(
                              Text(
                                "${model.components.carbohydrate}",
                              ),
                            ),
                            DataCell(
                              Text(
                                "${model.components.fat}",
                              ),
                            ),
                            DataCell(
                              Text(
                                "${model.components.iron}",
                              ),
                            ),
                            DataCell(
                              Text(
                                "${model.components.carotene}",
                              ),
                            ),
                            DataCell(
                              Text(
                                "${model.components.vitaminC}",
                              ),
                            ),
                          ],
                        );
                      },
                    ).toList(),
                    border: TableBorder.all(color: Colors.grey),
                  ),
                ),
              ],
            ),
    );
  }

  void _sortList(int columnIndex) {
    switch (_columnIndex) {
      case 1:
        if (_sortAscending) {
          list.sort(
            (a, b) => a.components.energy.compareTo(
              b.components.energy,
            ),
          );
        } else {
          list.sort(
            (a, b) => b.components.energy.compareTo(
              a.components.energy,
            ),
          );
        }
        break;
      case 2:
        if (_sortAscending) {
          list.sort(
            (a, b) => a.components.protein.compareTo(
              b.components.protein,
            ),
          );
        } else {
          list.sort(
            (a, b) => b.components.protein.compareTo(
              a.components.protein,
            ),
          );
        }
        break;
      case 3:
        if (_sortAscending) {
          list.sort(
            (a, b) => a.components.carbohydrate.compareTo(
              b.components.carbohydrate,
            ),
          );
        } else {
          list.sort(
            (a, b) => b.components.carbohydrate.compareTo(
              a.components.carbohydrate,
            ),
          );
        }
        break;
      case 4:
        if (_sortAscending) {
          list.sort(
            (a, b) => a.components.fat.compareTo(
              b.components.fat,
            ),
          );
        } else {
          list.sort(
            (a, b) => b.components.fat.compareTo(
              a.components.fat,
            ),
          );
        }
        break;
      case 5:
        if (_sortAscending) {
          list.sort(
            (a, b) => a.components.iron.compareTo(
              b.components.iron,
            ),
          );
        } else {
          list.sort(
            (a, b) => b.components.iron.compareTo(
              a.components.iron,
            ),
          );
        }
        break;
      case 6:
        if (_sortAscending) {
          list.sort(
            (a, b) => a.components.carotene.compareTo(
              b.components.carotene,
            ),
          );
        } else {
          list.sort(
            (a, b) => b.components.carotene.compareTo(
              a.components.carotene,
            ),
          );
        }
        break;
      case 7:
        if (_sortAscending) {
          list.sort(
            (a, b) => a.components.vitaminC.compareTo(
              b.components.vitaminC,
            ),
          );
        } else {
          list.sort(
            (a, b) => b.components.vitaminC.compareTo(
              a.components.vitaminC,
            ),
          );
        }
        break;
      default:
        if (_sortAscending) {
          list.sort(
            (a, b) => a.name.compareTo(
              b.name,
            ),
          );
        } else {
          list.sort(
            (a, b) => b.name.compareTo(
              a.name,
            ),
          );
        }
    }
  }
}
