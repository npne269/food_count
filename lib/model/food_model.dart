import 'dart:convert';

import 'package:flutter/services.dart';

class ConsumedModel {
  FoodModel? foodEat;
  double amount;

  ConsumedModel({
    required this.foodEat,
    required this.amount,
  });

  addAmount(double amt) {
    amount = amt;
  }

  increaseAmount({double? amt}) {
    amount += amt ?? 1;
  }

  decreaseAmount() {
    if (amount > 0) {
      amount -= 1;
    }
  }
}

class FoodModel {
  FoodModel({
    required this.id,
    required this.name,
    required this.components,
  });
  final int id;
  final String name;
  final Components components;

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        id: json["id"],
        name: json["name"],
        components: Components.fromJson(json["components"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "components": components.toJson(),
      };

  static Future<String> _loadFromAsset() async {
    return await rootBundle.loadString("assets/foodcomposition.json");
  }

  static Future parseJson() async {
    String jsonString = await _loadFromAsset();
    return jsonDecode(jsonString);
  }

  static Future<List<FoodModel>> getListFoodItems() async {
    List<FoodModel> a = [];
    var data = await parseJson();
    for (var element in data) {
      a.add(FoodModel.fromJson(element));
    }
    return a;
  }

  // static FoodModel? getItemsById(String id) {
  // getListFoodItems().then((value) {
  // return value.where((element) => "${element.id}" == id).toList();
  // });
  // return null;
  // List<FoodModel> a =
  //     getListFoodItems().where((element) => "${element.id}" == id).toList();
  // return a.isEmpty ? null : a.first;
  // }
}

class Components {
  Components({
    required this.energy,
    required this.protein,
    required this.carbohydrate,
    required this.fat,
    required this.iron,
    required this.carotene,
    required this.vitaminC,
  });

  final double energy;
  final double protein;
  final double carbohydrate;
  final double fat;
  final double iron;
  final double carotene;
  final double vitaminC;

  factory Components.fromJson(Map<String, dynamic> json) => Components(
        energy: json["energy"].toDouble(),
        protein: json["protein"].toDouble(),
        carbohydrate: json["carbohydrate"].toDouble(),
        fat: json["fat"].toDouble(),
        iron: json["iron"].toDouble(),
        carotene: json["carotene"].toDouble(),
        vitaminC: json["vitamin c"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "energy": energy,
        "protein": protein,
        "carbohydrate": carbohydrate,
        "fat": fat,
        "iron": iron,
        "carotene": carotene,
        "vitamin c": vitaminC,
      };

  List<double> getItems(double gm) {
    return [
      (energy * gm) / 100,
      (protein * gm) / 100,
      (carbohydrate * gm) / 100,
      (fat * gm) / 100,
      (iron * gm) / 100,
      (carotene * gm) / 100,
      (vitaminC * gm) / 100,
    ];
  }
}
