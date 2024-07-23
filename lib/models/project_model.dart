import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectModel {
  String id;
  String name;
  String description;
  String? userId;
  DateTime createdAt;
  DateTime? finishedAt;

  ProjectModel(
      {required this.id,
      required this.name,
      required this.description,
      this.userId,
      required this.createdAt,
      this.finishedAt});

  String getId() => id;

  set setId(String value) => id = value;

  String getName() => name;

  set setName(String value) => name = value;

  String getDescription() => description;

  set setDescription(String value) => description = value;

  String? getUserId() => userId;

  set setUserId(String value) => userId = value;

  DateTime getCreatedAt() => createdAt;

  set setCreatedAt(DateTime value) => createdAt = value;

  DateTime? getFinishedAt() => finishedAt;

  set setFinishedAt(DateTime? value) => finishedAt = value;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'userId': userId,
      'createdAt': createdAt,
      'finishedAt': finishedAt,
    };
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      userId: map['userId'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      finishedAt: map['finishedAt'] != null
          ? (map['finishedAt'] as Timestamp).toDate()
          : null,
    );
  }

  ProjectModel copyWith({
    String? id,
    String? name,
    String? description,
    String? userId,
    DateTime? createdAt,
    DateTime? finishedAt,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      finishedAt: finishedAt ?? this.finishedAt,
    );
  }
}
