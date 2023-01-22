import 'dart:convert';

class ProfileModel {
  String id; // used in firebase UID
  String name;
  String email;
  DateTime registeredAt;
  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.registeredAt,
  });

  ProfileModel copyWith({
    String? id,
    String? name,
    String? email,
    DateTime? registeredAt,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      registeredAt: registeredAt ?? this.registeredAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'registeredAt': registeredAt.millisecondsSinceEpoch,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      registeredAt:
          DateTime.fromMillisecondsSinceEpoch(map['registeredAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProfileModel(id: $id, name: $name, email: $email, registeredAt: $registeredAt)';
  }

  @override
  bool operator ==(covariant ProfileModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.registeredAt == registeredAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ email.hashCode ^ registeredAt.hashCode;
  }
}
