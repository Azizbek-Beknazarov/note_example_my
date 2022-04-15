const String TABLE_NAME = 'notes';

class NoteModel {
  final int? id;
  final String title;
  final String description;
  final DateTime createdAt;

  NoteModel(
      {this.id,
      required this.title,
      required this.description,
      required this.createdAt});

  NoteModel copy({
    final int? id,
    final String? title,
    final String? description,
    final DateTime? createdAt,
  }) =>
      NoteModel(
          id: id ?? this.id,
          title: title ?? this.title,
          description: description ?? this.description,
          createdAt: createdAt ?? this.createdAt);

  //from Map
  static NoteModel fromMap(Map<String, dynamic> map) {
    return NoteModel(
        id: map[NoteField.id] as int?,
        title: map[NoteField.title] as String,
        description: map[NoteField.description] as String,
        createdAt: DateTime.parse(map[NoteField.createdAt] as String));
  }

  // to Map
  Map<String, dynamic> toMap() {
    return ({
      NoteField.id: id,
      NoteField.title: title,
      NoteField.description: description,
      NoteField.createdAt: createdAt.toIso8601String(),
    });
  }
}

class NoteField {
  static final List<String> values = [
    id,
    title,
    description,
    createdAt,
  ];

  static const String id = 'id';
  static const String title = 'title';
  static const String description = 'description';
  static const String createdAt = 'createdAt';
}
