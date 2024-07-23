import 'package:cloud_firestore/cloud_firestore.dart';

enum TaskStatus { notStart, start, done }

class TaskModel {
  String id;
  String projectId;
  String title;
  String description;
  String? userId;
  bool priority;
  TaskStatus status;
  DateTime? startDate;
  DateTime? endDate;
  DateTime createdAt;

  TaskModel({
    required this.id,
    required this.projectId,
    required this.title,
    required this.description,
    this.userId,
    required this.status,
    required this.priority,
    required this.createdAt,
    this.startDate,
    this.endDate,
  });

  String getProjectId() => projectId;

  set setProjectId(String value) => projectId = value;

  String getTitle() => title;

  set setTitle(String value) => title = value;

  String getDescription() => description;

  set setDescription(String value) => description = value;

  String? getUserId() => userId;

  set setUserId(String value) => userId = value;

  bool getPriority() => priority;

  set setPriority(bool value) => priority = value;

  TaskStatus getStatus() => status;

  set setStatus(TaskStatus value) => status = value;

  DateTime? getStartDate() => startDate;

  set setStartDate(DateTime? value) => startDate = value;

  DateTime? getEndDate() => endDate;

  set setEndDate(DateTime? value) => endDate = value;

  DateTime getCreatedAt() => createdAt;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'projectId': projectId,
      'title': title,
      'description': description,
      'userId': userId,
      'status': status.index,
      'priority': priority,
      'startDate': startDate,
      'endDate': endDate,
      'createdAt': createdAt,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? '',
      projectId: map['projectId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      userId: map['userId'] ?? '',
      status: TaskStatus.values[map['status'] ?? 0],
      priority: map['priority'] ?? false,
      startDate: map['startDate'] != null
          ? (map['startDate'] as Timestamp).toDate()
          : null,
      endDate: map['endDate'] != null
          ? (map['endDate'] as Timestamp).toDate()
          : null,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  TaskModel copyWith({
    String? id,
    String? projectId,
    String? title,
    String? description,
    String? userId,
    bool? priority,
    TaskStatus? status,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? createdAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
