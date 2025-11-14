import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manger_task/core/domain/data/inventory_data.dart';
import 'package:manger_task/core/domain/data/inventory_data.dart' as InventoryData;
import 'package:manger_task/core/domain/model/item_model.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  InventoryBloc() : super(InventoryInitial()) {
    on<LoadInventoryEvent>((event, emit) {
      emit(InventoryLoadingState());
      final allItems = InventoryData.inventory;
      final categories = ['All Categories', ...allItems.map((item) => item.category).toSet().toList()];
      emit(InventoryLoadedState(
        allItems: allItems,
        filteredItems: allItems,
        categories: categories,
        selectedCategory: 'All Categories',
        searchQuery: '',
      ));
    });

    on<FilterChangedEvent>((event, emit) {
      final currentState = state;
      if (currentState is InventoryLoadedState) {
        List<ItemModel> filteredList = currentState.allItems;

        final searchQuery = event.searchText ?? currentState.searchQuery;
        final category = event.selectedCategory ?? currentState.selectedCategory;

        if (searchQuery.isNotEmpty) {
          filteredList = filteredList
              .where((item) =>
                  item.name.toLowerCase().contains(searchQuery.toLowerCase()))
              .toList();
        }

        if (category != 'All Categories') {
          filteredList = filteredList
              .where((item) => item.category == category)
              .toList();
        }

        emit(currentState.copyWith(
          filteredItems: filteredList,
          searchQuery: searchQuery,
          selectedCategory: category,
        ));
      }
    });
  }
}
