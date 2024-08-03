import 'package:hive_flutter/hive_flutter.dart';

part 'repository_model.g.dart';

@HiveType(typeId: 1)
class RepositoryModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String description;
  @HiveField(2)
  bool isFavorite;

  RepositoryModel({
    this.isFavorite = false,
    required this.name,
    required this.description,
  });

  factory RepositoryModel.fromJSON(Map<String, dynamic> jsonData) {
    return RepositoryModel(
      name: jsonData['name'],
      description: jsonData['description'] ?? 'no description',
    );
  }
  set favorite(bool value) {
    isFavorite = value;
  }

  RepositoryModel copyWith({
    String? name,
    String? description,
    bool? isFavorite,
  }) {
    return RepositoryModel(
      name: name ?? this.name,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RepositoryModel &&
        name == other.name &&
        description == other.description &&
        isFavorite == other.isFavorite;
  }

  @override
  int get hashCode => Object.hash(name, description, isFavorite);

}
