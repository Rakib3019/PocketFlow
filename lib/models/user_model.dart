class UserModel {
  final String name;
  final String imagePath;
  final bool isProfileCompleted;

  const UserModel({
    required this.name,
    required this.imagePath,
    required this.isProfileCompleted,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imagePath': imagePath,
      'isProfileCompleted': isProfileCompleted,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      imagePath: json['imagePath'] ?? '',
      isProfileCompleted: json['isProfileCompleted'] ?? false,
    );
  }

  UserModel copyWith({
    String? name,
    String? imagePath,
    bool? isProfileCompleted,
  }) {
    return UserModel(
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      isProfileCompleted:
      isProfileCompleted ?? this.isProfileCompleted,
    );
  }
}