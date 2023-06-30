class Note {
  String? id;
  String? userID;
  String? title;
  String? content;
  DateTime? dateAdded;
  Note({
    this.id,
    this.userID,
    this.title,
    this.content,
    this.dateAdded,
  });

  Note copyWith({
    String? id,
    String? userID,
    String? title,
    String? content,
    DateTime? dateAdded,
  }) {
    return Note(
      id: id ?? this.id,
      userID: userID ?? this.userID,
      title: title ?? this.title,
      content: content ?? this.content,
      dateAdded: dateAdded ?? this.dateAdded,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userID': userID,
      'title': title,
      'content': content,
      'dateAdded': dateAdded?.toIso8601String(),
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
        id: map['id'] != null ? map['id'] as String : null,
        userID: map['userID'] != null ? map['userID'] as String : null,
        title: map['title'] != null ? map['title'] as String : null,
        content: map['content'] != null ? map['content'] as String : null,
        dateAdded: DateTime.tryParse(map['dateAdded']));
  }

  @override
  String toString() {
    return 'Note(id: $id, userID: $userID, title: $title, content: $content, dateAdded: $dateAdded)';
  }

  @override
  bool operator ==(covariant Note other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userID == userID &&
        other.title == title &&
        other.content == content &&
        other.dateAdded == dateAdded;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userID.hashCode ^
        title.hashCode ^
        content.hashCode ^
        dateAdded.hashCode;
  }
}
