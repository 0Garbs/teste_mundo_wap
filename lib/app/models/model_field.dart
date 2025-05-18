import 'dart:convert';

class ModelField {
  final int id;
  final String label;
  final bool obligatory;
  final String type;

  ModelField({
    required this.id,
    required this.label,
    required this.obligatory,
    required this.type,
  });

  ModelField copyWith({
    int? id,
    String? label,
    bool? obligatory,
    String? type,
  }) {
    return ModelField(
      id: id ?? this.id,
      label: label ?? this.label,
      obligatory: obligatory ?? this.obligatory,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
      'required': obligatory,
      'field_type': type,
    };
  }

  factory ModelField.fromMap(Map<String, dynamic> map) {
    return ModelField(
      id: map['id']?.toInt() ?? 0,
      label: map['label'] ?? '',
      obligatory: map['required'] ?? false,
      type: map['field_type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelField.fromJson(String source) =>
      ModelField.fromMap(json.decode(source));
}
