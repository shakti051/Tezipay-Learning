import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final String id;
  final String description;
  String date;
  bool isDone;
  bool? isDeleted;
  bool isFavorite;
  
  Task({
    required this.title,
    required this.id,
    required this.description,
    required this.date,
    this.isFavorite = false,
    this.isDone = false,
    this.isDeleted = false,
  });

  Task copyWith({String? title, String? id, bool? isDone, bool? isDeleted,String? description,String? date,bool? isFavorite }) {
    return Task(
      title: title ?? this.title,
      id: id ?? this.id,
      description: description ?? this.description,
      date: date ?? this.date,
      isFavorite: isFavorite ?? this.isFavorite,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'id': id,
      "description":description,
      "date":date,
      "isFavorite":isFavorite,
      'isDone': isDone,
      'isDeleted': isDeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] as String,
      id: map['id'] as String,
      description: map['description'] as String,
      date: map['date'] as String,
      isFavorite: map['isFavorite'] != null ? map['isFavorite'] as bool : false,
      isDone: map['isDone'] != null ? map['isDone'] as bool : false,
      isDeleted: map['isDeleted'] != null ? map['isDeleted'] as bool : null,
    );
  }

  @override
  String toString() =>
      'Task(title: $title,id: $id,isDone: $isDone, isDeleted: $isDeleted, description $description)';

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.id == id &&
        other.isDone == isDone &&
        other.description == description &&
        other.date == date &&
        other.isFavorite == isFavorite &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode => title.hashCode ^ isDone.hashCode ^ isDeleted.hashCode ^id.hashCode^description.hashCode^date.hashCode^isFavorite.hashCode;

  @override
  // TODO: implement props
  List<Object?> get props => [title, isDeleted, isDone, id,description,date,isFavorite];
}
