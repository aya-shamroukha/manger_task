part of 'inventory_bloc.dart';

abstract class InventoryEvent {}

class LoadInventoryEvent extends InventoryEvent {}

class FilterChangedEvent extends InventoryEvent {
  final String? searchText;
  final String? selectedCategory;

  FilterChangedEvent({this.searchText, this.selectedCategory});
}