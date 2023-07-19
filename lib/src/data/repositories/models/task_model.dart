// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TaskModel {
  final String id;
  final String name;
  final String description;
  final String group;
  final String location;
  final String displayLocation;
  final String startDate;
  final String displayStartDate;
  final String endDate;
  final String status;
  final List users;

  TaskModel({
    required this.id,
    required this.name,
    required this.description,
    required this.group,
    required this.location,
    required this.displayLocation,
    required this.startDate,
    required this.displayStartDate,
    required this.endDate,
    required this.status,
    required this.users,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'group': group,
      'location': location,
      'displayLocation': displayLocation,
      'startDate': startDate,
      'displayStartDate': displayStartDate,
      'endDate': endDate,
      'status': status,
      'users': users,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['_id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      group: map['group'] as String,
      location: map['location'] as String,
      displayLocation: map['displayLocation'] as String,
      startDate: map['startDate'] as String,
      displayStartDate: map['displayStartDate'] as String,
      endDate: map['endDate'] as String,
      status: map['status'] != null ? map['status'] as String : '',
      users: List.from(
        (map['users'] as List),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return '(id: $id, name: $name, description: $description, group: $group, location: $location, displayLocation: $displayLocation, startDate: $startDate, displayStartDate: $displayStartDate, endDate: $endDate, status: $status, users: $users)';
  }
}
