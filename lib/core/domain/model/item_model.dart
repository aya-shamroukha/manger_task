// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ItemModel {
  final String name;
  final String category;
  ItemModel({
    required this.name,
    required this.category,
  });


  ItemModel copyWith({
    String? name,
    String? category,
  }) {
    return ItemModel(
      name: name ?? this.name,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'category': category,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      name: map['name'] as String,
      category: map['category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) => ItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ItemModel(name: $name, category: $category)';

  @override
  bool operator ==(covariant ItemModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.category == category;
  }

  @override
  int get hashCode => name.hashCode ^ category.hashCode;
}
