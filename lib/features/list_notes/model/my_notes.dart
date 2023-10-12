import 'package:equatable/equatable.dart';

// Extending Equatable will help us to compare two instances of
// MyUser class, and we will not have to override == and hashCode.
class MyNotes extends Equatable {
  final String id;
  final String description;

  const MyNotes({
    required this.id,
    required this.description,
  });

  // When comparing two instances of MyUser class we want to check
  // that all the properties are the same, then we can say that
  // the two instances are equals
  @override
  List<Object?> get props => [id, description];

  // Helper function to convert this MyUser to a Map
  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'description': description,
    };
  }

  // Helper function to convert a Map to an instance of MyUser
  MyNotes.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        description = data['description'] as String;

  // Helper function that updates some properties of this instance,
  // and returns a new updated instance of MyUser
  MyNotes copyWith({
    String? id,
    String? description,
  }) {
    return MyNotes(
      id: id ?? this.id,
      description: description ?? this.description,
    );
  }
}
