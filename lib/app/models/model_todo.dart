import 'dart:convert';
import 'model_field.dart';

class ModelTodo {
  final int id;
  final String name;
  final String description;
  final List<ModelField> fields;

  ModelTodo({
    required this.id,
    required this.name,
    required this.description,
    required this.fields,
  });

  ModelTodo copyWith({
    int? id,
    String? name,
    String? description,
    List<ModelField>? fields,
  }) {
    return ModelTodo(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      fields: fields ?? this.fields,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'fields': fields.map((x) => x.toMap()).toList(),
    };
  }

  factory ModelTodo.fromMap(Map<String, dynamic> map) {
    return ModelTodo(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      fields: List<ModelField>.from(
        map['fields']?.map((x) => ModelField.fromMap(x)) ?? const [],
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelTodo.fromJson(String source) =>
      ModelTodo.fromMap(json.decode(source));
}
