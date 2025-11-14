import 'package:manger_task/core/domain/model/item_model.dart';


final List<ItemModel> inventory = [
  ItemModel(name: "Organic Extra Virgin Olive Oil 1L", category: "Grocery"),
  ItemModel(name: "Gluten-Free Whole Grain Multigrain Bread", category: "Bakery"),
  ItemModel(name: "Cold-Pressed Unsweetened Almond Milk 1L", category: "Beverages"),
  ItemModel(name: "Free-Range Large Brown Eggs, Dozen Pack", category: "Dairy"),
  ItemModel(name: "Freshly Roasted Colombian Coffee Beans 500g", category: "Beverages"),
];

final List<String> categories = ['All Categories'] + 
    inventory.map((item) => item.category).toSet().toList();