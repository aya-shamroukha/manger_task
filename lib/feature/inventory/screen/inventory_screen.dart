import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manger_task/feature/inventory/bloc/inventory_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  int? _expandedCardIndex;

  IconData _getIconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'grocery':
        return Icons.local_grocery_store_outlined;
      case 'bakery':
        return Icons.bakery_dining_outlined;
      case 'beverages':
        return Icons.local_cafe_outlined;
      case 'dairy':
        return Icons.icecream_outlined;
      default:
        return Icons.label_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => InventoryBloc()..add(LoadInventoryEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Inventory Manager'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: theme.scaffoldBackgroundColor,
          foregroundColor: theme.textTheme.titleLarge?.color,
        ),
        body: BlocBuilder<InventoryBloc, InventoryState>(
          builder: (context, state) {
            if (state is InventoryInitial || state is InventoryLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is InventoryLoadedState) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search by name...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: theme.dividerColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: theme.dividerColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: theme.primaryColor),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                        ),
                      ),
                      onChanged: (query) {
                        context.read<InventoryBloc>().add(
                          FilterChangedEvent(searchText: query),
                        );
                      },
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Container(
                          width: 170.w,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey[400]!),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: state.selectedCategory,
                              isExpanded: true,
                              hint: const Text('Filter by category'),
                              items: state.categories.map((String category) {
                                return DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(category),
                                );
                              }).toList(),
                              onChanged: (category) {
                                context.read<InventoryBloc>().add(
                                  FilterChangedEvent(
                                    selectedCategory: category,
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.filter_list,
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Expanded(
                      child: state.filteredItems.isEmpty
                          ? Center(
                              child: Text(
                                'No items found.',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8.0,
                                    mainAxisSpacing: 8.0,
                                    childAspectRatio: 1,
                                  ),
                              itemCount: state.filteredItems.length,
                              itemBuilder: (context, index) {
                                final item = state.filteredItems[index];
                                final isExpanded = _expandedCardIndex == index;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (isExpanded) {
                                        _expandedCardIndex = null;
                                      } else {
                                        _expandedCardIndex = index;
                                      }
                                    });
                                  },
                                  child: Card(
                                    elevation: 2.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: AnimatedSize(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              _getIconForCategory(
                                                item.category,
                                              ),
                                              color: theme.primaryColor,
                                              size: 32,
                                            ),
                                            isExpanded
                                                ? const SizedBox(height: 0)
                                                : SizedBox(height: 15.h),
                                            Text(
                                              item.name,
                                              style: theme.textTheme.titleMedium
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                              maxLines: isExpanded ? null : 2,
                                              overflow: isExpanded
                                                  ? TextOverflow.visible
                                                  : TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              item.category,
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                    color: Colors.grey[600],
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text('Something went wrong!'));
          },
        ),
      ),
    );
  }
}
