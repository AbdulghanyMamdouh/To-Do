// import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  static const String collectionName = 'task';
  String? id;
  String? title;
  String? description;
  DateTime? dateTime;
  bool? isDone;
  Task({
    this.id = '',
    required this.title,
    required this.description,
    required this.dateTime,
    this.isDone = false,
  });

  /// object => Json
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'isDone': isDone,
    };
  }

  /// Json => object
  Task.fromFirestore(Map<String, dynamic> data)
      : this(
          id: data['id'] as String?,
          title: data['title'] as String?,
          description: data['description'] as String?,
          dateTime: data['dateTime'] != null
              ? DateTime.fromMillisecondsSinceEpoch(data['dateTime'])
              : null,
          // DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
          isDone: data['isDone'] as bool?,
        );
}
