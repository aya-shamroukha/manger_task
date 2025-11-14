part of 'inventory_bloc.dart';

abstract class InventoryState {
  const InventoryState();
}

class InventoryInitial extends InventoryState {}

class InventoryLoadingState extends InventoryState {}

class InventoryLoadedState extends InventoryState {
  final List<ItemModel> allItems;
  final List<ItemModel> filteredItems;
  final List<String> categories;
  final String selectedCategory;
  final String searchQuery;

  const InventoryLoadedState({
    required this.allItems,
    required this.filteredItems,
    required this.categories,
    required this.selectedCategory,
    required this.searchQuery,
  });

  InventoryLoadedState copyWith({
    List<ItemModel>? filteredItems,
    String? selectedCategory,
    String? searchQuery,
  }) {
    return InventoryLoadedState(
      allItems: allItems,
      filteredItems: filteredItems ?? this.filteredItems,
      categories: categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}